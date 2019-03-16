Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140CE21904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552756527;
	bh=yaBuVQHY5hPsXZmrW0saq5dB6OZCZYvsjwhlKw2zVpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w8elksduj1mZtemkNuiqjgKytQpjlVRkGYQnT57JUAl6zDWS+CNfYOQ4i4xnHKRgR
	 R5TWGI+K6VF6vt/FUlCDqV97vCVnrwHCVDhZGigTkalajGNnR2V5JphaZGkKvVZcCI
	 ELUj0/FY5AIFWVO9BxxQrny1Q/CAiriVeuZZsdDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfCPRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 13:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbfCPRPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 13:15:25 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE60F218E0;
        Sat, 16 Mar 2019 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552756524;
        bh=yaBuVQHY5hPsXZmrW0saq5dB6OZCZYvsjwhlKw2zVpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ke0KlMeSEfAm1zkXhK9QId6xDS1MtMltiNjV6nMoDyp/VpjE4H35d7ZZD+NQFImL6
         gSKIHmL1PvPkMhvZhhxnG+HY7su3gUfARpptEXkUC5UjjAVZ+Q4rjUDkybc3+eexV/
         g78W7hCjQRxFTrOUpVsS9q1zRHLWbtFHZ2YrNN2A=
Date:   Sat, 16 Mar 2019 17:15:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomas Novotny <tomas@novotny.cz>,
        Brian Masney <masneyb@onstation.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>, ryang <decatf@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: Document the VCNL4xx0
 device tree bindings
Message-ID: <20190316171517.4c783134@archlinux>
In-Reply-To: <20190315215425.24140-3-angus@akkea.ca>
References: <20190315215425.24140-1-angus@akkea.ca>
        <20190315215425.24140-3-angus@akkea.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 14:54:25 -0700
"Angus Ainslie (Purism)" <angus@akkea.ca> wrote:

> devicetree hooks where added to the VCNL4xx0 light and proximity
> sensor driver.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Please avoid wild cards in naming. It goes wrong too often.  People can grep
if they want to see if their device is supported by any drivers rather
than try to figure out wildcards.

> ---
>  .../devicetree/bindings/iio/light/vcnl4xx0.txt    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt b/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt
> new file mode 100644
> index 000000000000..d61cf3c121c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4xx0.txt
> @@ -0,0 +1,15 @@
> +VISHAY VCNL4xx0 -  Ambient Light and proximity sensor
> +
> +This driver supports the VCNL4000/10/20/40 and VCNL4200
> +
> +Required properties:
> +
> +	-compatible: should be "vishay,vcnl4000" or "vishay,vcnl4040"
One per line.

I'd also like to see all the options in the list.  We already seem
to have an undocumented difference between your new part and some
of the older ones.  It's always better for people to use the 'most
correct' part name the can.

> +	-reg: I2C address of the sensor, should be 0x60
> +
> +Example:
> +
> +light-sensor@60 {
> +	compatible = "vishay,vcnl4040";
> +	reg = <0x60>;
> +};

