Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C4C10F00
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA9E222D6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553428992;
	bh=SP6sjF3Itg97ixCpRTFZP7MS5K7NcsGqRZ0iTfksgso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GLDEp5urpN1Gpt4aVvIomxIrbpYV4dUwFs4hrZrYzfJHqrORWttzaaJJVepBuktvP
	 EH6Fx1MOO8KfWCDCTAsNa95S3Ns2zM2JWH3cyPbtvtdXPH+DzWOzn3XpHr08uxP5nx
	 WXSsXmAmWG7MwyzCpYr9SHZWhrL96Od76Y/fp9B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfCXMDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 08:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbfCXMDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 08:03:11 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24575222D1;
        Sun, 24 Mar 2019 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553428990;
        bh=SP6sjF3Itg97ixCpRTFZP7MS5K7NcsGqRZ0iTfksgso=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pBxT4zFd1duFKIfBCqNp1X+c99BBrA/4jptB+GMBG4sIIq0bxK7lpqCOnjGOxb/2M
         3Yhc4O0HeHxk2vHbAY4KFxX0QNAU9nrpkUWMD6dP4ZOmWcu7dQZz7FXpxYq2kaSWhr
         mz05c/cVtZ9xzTVDYjEzV8nRVG+I2hveeUpHiMgU=
Date:   Sun, 24 Mar 2019 12:03:02 +0000
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
Subject: Re: [PATCH v3 2/4] dt-bindings: maxbotix,mb1232: Add MaxBotix i2c
 ultrasonic rangers
Message-ID: <20190324120302.55388208@archlinux>
In-Reply-To: <20190317203526.4pcwo4gdrrng44v7@arbad>
References: <20190317203526.4pcwo4gdrrng44v7@arbad>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 21:35:27 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add doc for dt binding maxbotix,mb1232. This binding is for MaxBotix
> I2CXL-MaxSonar ultrasonic rangers which share a common i2c interface.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
This seems pretty straight forward so I'll apply it to the togreg branch
of iio.git and push out as testing.  Still time for any feedback from
Rob or others though before this goes out as non rebasing.

Thanks,

Jonathan

> ---
>  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> new file mode 100644
> index 000000000000..0e9df87eca1d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> @@ -0,0 +1,31 @@
> +* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> +  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> +  for ranging
> +
> +Required properties:
> + - compatible:		"maxbotix,mb1202",
> +			"maxbotix,mb1212",
> +			"maxbotix,mb1222",
> +			"maxbotix,mb1232",
> +			"maxbotix,mb1242",
> +			"maxbotix,mb7040" or
> +			"maxbotix,mb7137"
> +
> + - reg:			i2c address of the device, see also i2c/i2c.txt
> +
> +Optional properties:
> + - interrupt-parent:	Interrupt controller to use
> +
> + - interrupts:		Interrupt used to announce the preceding reading
> +			request has finished and that data is available.
> +			If no interrupt is specified the device driver
> +			falls back to wait a fixed amount of time until
> +			data can be retrieved.
> +
> +Example:
> +proximity@70 {
> +	compatible = "maxbotix,mb1232";
> +	reg = <0x70>;
> +	interrupt-parent = <&gpio2>;
> +	interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +};

