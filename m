Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA5EC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FF620879
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554534847;
	bh=Urpb87Ho0j/uUFVQFnnAMXmiPHMwX37HFQdCL1thtno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWY4lHQSrZAyn9JKF7izHEiafjDjoBgoWrCR0F4GliIiDnCKtc+2aIB0M3TjAGSLS
	 10Sk/PO+BZSBm7PjOvWRgMWruqlQ+izHNhNPPgqkiAOdOfEibvlysuAtO4BKDhEp/W
	 TF87qDAa6Hm8QsRd+/8sTv0/zCGnbJEjkNqSY9dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfDFHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:14:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41099 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDFHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:14:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id d1so4247349plj.8;
        Sat, 06 Apr 2019 00:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtnZVgGpUPAC9FI3mMvruPQumnTJn+wT5jX4iXUuE/U=;
        b=oWW24+yZSY7UF9OgudWDykTuvV96Rz3ZVaTO/5s07GfxKIjinMrug/T3gdZd/uQ1WK
         yBLsWRZna2I3jJQY+WznpadoOVr7KCmW9QNVHa5jCeBS5TyuS4Tlj+QnT9ngzyApeth3
         jNOeS80+oDaGsha1uVcYtwMGoRfdzk7fZdSD9dGZQapIb3Zjxp9Ai5RSHrEDSwbW3O/Y
         IZUOqQxryh63SVYm6YwP0GvnvsGTe4Np9UjoXhrJZl0Fq0qCanePQbJodOCLVNHOTA+E
         1NGWhtQXAhpjBAVmiQhOXc1QcCVzPWPcoEEp46vOONnULXgsi/FTaPq1Hm5jDgJUu4vS
         xWsQ==
X-Gm-Message-State: APjAAAVbLNvGDGsUVLvs4uK/ZZUooif9ixC+2N4AytZzJgnXY0QOIDJM
        81jubzUZQKWWlepBRnFC4Q==
X-Google-Smtp-Source: APXvYqwzFFU/bTjYXqwS50ZEPfZBcK/XqGaJ2uBXTppNb/xiheQiNW16RgYmcOC9O8a/Iau0SzXM7Q==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr17755230plb.171.1554534844920;
        Sat, 06 Apr 2019 00:14:04 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id u4sm68433170pgn.12.2019.04.06.00.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 00:14:04 -0700 (PDT)
Date:   Sat, 6 Apr 2019 02:14:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v5 2/5] dt-bindings: phy: add binding for Allwinner USB3
 PHY
Message-ID: <20190406071402.GA6006@bogus>
References: <20190405205736.55177-1-icenowy@aosc.io>
 <20190405205736.55177-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405205736.55177-3-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2019 at 04:57:33AM +0800, Icenowy Zheng wrote:
> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
> external USB3 pins of the SoC.
> 
> Add a device tree binding for the PHY.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v5:
> - Dropped Vbus regulator and added connector subnode.
> 
> Changes in v4:
> - Changed Vbus regulator property to vbus-supply.
> 
> Changes in v3:
> - Added Chen-Yu's Review tag.
> 
> No changes in v2, v1.
> 
>  .../bindings/phy/sun50i-usb3-phy.txt          | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> new file mode 100644
> index 000000000000..eeedc53e6360
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> @@ -0,0 +1,28 @@
> +Allwinner sun50i USB3 PHY
> +-----------------------
> +
> +Required properties:
> +- compatible : should be one of
> +  * allwinner,sun60i-h6-usb3-phy
> +- reg : a list of offset + length pairs
> +- #phy-cells : from the generic phy bindings, must be 0
> +- clocks : phandle + clock specifier for the phy clock
> +- resets : phandle + reset specifier for the phy reset
> +
> +Optional nodes:
> +- connector : A sub-node required for representing the connector connected
> +	      to the USB PHY. See ../connector/usb-connector.txt for details.
> +
> +Example:
> +	usb3phy: phy@5210000 {
> +		compatible = "allwinner,sun50i-h6-usb3-phy";
> +		reg = <0x5210000 0x10000>;
> +		clocks = <&ccu CLK_USB_PHY1>;
> +		resets = <&ccu RST_USB_PHY1>;
> +		#phy-cells = <0>;
> +
> +		connector {
> +			compatible = "usb-a-connector";
> +			label = "USB3";

The binding defines that a connector is a child of USB controller or 
some port controller (such as USB-C ctrlr) with OF graph to USB 
controller. So either way, this is wrong unless this is more than just a 
phy.

Rob
