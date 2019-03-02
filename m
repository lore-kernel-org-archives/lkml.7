Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A64C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FACD2086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551551209;
	bh=GHRJ3DDrTlbJPRQAc3QJTHCMKl2pB/VknEl3bOgcRmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GowC7L9YR/AHlkv/bjrZ78JKu0LFGlUOVov5Jy/XBdwsbuK+7QONKIZPnWFM1jx5j
	 vUbvXWMZbZPlUOB2IhhjCxMrWlP+rvMMEUPop6kQJZHFp0cl+wGZcx3FRW7ce1yP1n
	 vPoQiFr9J7gWNWkmD2G4RUqKyDi4eF8sqpxu8Rig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCBS0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfCBS0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:26:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A120B20863;
        Sat,  2 Mar 2019 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551551207;
        bh=GHRJ3DDrTlbJPRQAc3QJTHCMKl2pB/VknEl3bOgcRmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wHGu808KT7GTo9BXa8YKj2YLBjOKYs5GZBCHsC8wCYiQ8APacvR0/nLQJ8eXOyRXu
         Gzy9MB2fZ/8J6K8yxsn+hib3VbdT39hP4JO8oF+ZXD4kV1VEYE+VZ+RkOx1jbHUrVW
         ba27UKAn7gJb+Da90HPaJQlg60AGjYMlgeTerOUw=
Date:   Sat, 2 Mar 2019 18:26:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        arnd@arndb.de, davem@davemloft.net, gregkh@linuxfoundation.org,
        johan@kernel.org, khilman@baylibre.com, knaack.h@gmx.de,
        lars@metafoo.de, linux-kernel@vger.kernel.org,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh@kernel.org, songqiang1304521@gmail.com,
        treding@nvidia.com, techsupport@maxbotix.com
Subject: Re: [PATCH v2 2/4] dt-bindings: maxbotix,i2cxl: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190302182639.48e73885@archlinux>
In-Reply-To: <20190301134225.susjgtck4iktkbeg@arbad>
References: <20190301134225.susjgtck4iktkbeg@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019 14:42:27 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add doc for dt binding maxbotix,i2cxl. This binding is for MaxBotix
> I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.

I'm a bit confused on the naming. Certainly the binding should have
separate entries for each supported part, rather than a group one
for their i2cxl naming.  Having said that they do have a wide
range of parts with only the one datasheet.

Rob, what do you think?  Go with this i2cxl naming
or list the individual supported parts?

mb1202, mb1212, mb1222, mb1232, mb1242, mb7040, 
mb7137?

I'm loving that the last one is called the trashsonar ;)

A few minor bits inline.

Thanks,

Jonathan
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/maxbotix,i2cxl.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
> new file mode 100644
> index 000000000000..528f428fc583
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,i2cxl.txt
> @@ -0,0 +1,21 @@
> +* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type mb12x2 using
> +  the i2c interface for ranging
> +
> +Required properties:
> + - compatible:		Should be "maxbotix,i2cxl"
> +
> + - reg:			i2c address of the device
A cross reference to the i2c docs is always nice.
> +
> +Optional properties:
> + - status-gpios:	Status gpio (input) used to announce the preceding
> +			reading request has finished and that data is
> +			available. If no status gpio is specified the
> +			device driver falls back to wait until data can be
> +			retrieved.
This isn't a standard gpio name - it's purpose is definitely device
specific so give it a vendor prefix.

maxbotix,status-gpios

> +
> +Example:
> +proximity@70 {
> +	compatible = "maxbotix,i2cxl";
> +	reg = <0x70>;
> +	status-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
> +};

