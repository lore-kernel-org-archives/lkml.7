Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C43C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A05722D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566411683;
	bh=DuLBSrqmoydgG3tlds9z+F7YnbhAA6bLsosi3wPzNeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjwb0VBNj4YVsNyr1qOE/FizGwQrYZIi1FfP4BMkMpH2oecJLV+rY4Q2tYpeiOpg7
	 2gJg0CVEKRIAuu2daYtQ1x3q+0L8vZtTNMhDdhFXY5CimpKQ+hdEy86056TPJEGJN/
	 f279FqQxMOBtjv5GX6gNjcrOOZlYXj4eln99EuHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfHUSVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:21:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36539 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfHUSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:21:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id n1so2343705oic.3;
        Wed, 21 Aug 2019 11:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EPCVlMcnobgA0fbJbdjCw5LDxpNEEaKqZxggEUsbNFc=;
        b=Omd99dWbcGAsZOSVYnwaQAP0W9p09UZpNm3+4XY+XOqBsuXFOgIX2kDB4N1/0YywQp
         UVsTHDQLW5okE6BSkOOxUzdVZhxXLN1FVyAEDCYgQ9erxFT1I1tvhyOdTH0opLuJvAsf
         Od/d2UkkikIQEvrhU93XZs1xniuCyvfvCsUVE7tkc3CNCdwNS+0stq540xppcWXctMX9
         Q3pwsC0X+XfAPwRJTg6wYDPNd/0nVXpxtBEmAxDVFwzoJet1hOQAbg6SmyPdlAF0gP+b
         abVMwRow8R21M6WiZanPZqIGu+oyD7dGeMFFAQt4ueZYNktLriY/LIFKA61JaY6RkAxQ
         BIrw==
X-Gm-Message-State: APjAAAUgWYIHOgxvS9S2iFyxVaULNdkCR3cDtrfEFYCZdJX9+PyhRBto
        IhqSaB97f+lbQwWnIXaknw==
X-Google-Smtp-Source: APXvYqzljOsuL5vh4NhYw0Xh6f/8GopaO3UKaFqvaqCcd3CQe18BV/CQbDvf73/PexmBq1PqNTxRCw==
X-Received: by 2002:aca:1313:: with SMTP id e19mr1019955oii.5.1566411680554;
        Wed, 21 Aug 2019 11:21:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l16sm7673045otq.42.2019.08.21.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:21:20 -0700 (PDT)
Date:   Wed, 21 Aug 2019 13:21:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 2/5] dt-bindings: phy: Modify Stingray USB PHY
 #phy-cells
Message-ID: <20190821182119.GA27408@bogus>
References: <1564568395-9980-1-git-send-email-srinath.mannam@broadcom.com>
 <1564568395-9980-3-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564568395-9980-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:49:52PM +0530, Srinath Mannam wrote:
> Increase #phy-cells from 1 to 2 to have bitmask of PHY enabled ports.

And from 0 to 1...

Are you going to update all the dts files so when we convert this to 
schema we don't get a bunch of warnings? (Feel free to convert this 
to schema too).

> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  .../devicetree/bindings/phy/brcm,stingray-usb-phy.txt      | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> index 4ba2989..aeb0568 100644
> --- a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> @@ -6,9 +6,11 @@ Required properties:
>  	- "brcm,sr-usb-hs-phy" is a single HS PHY.
>   - reg: offset and length of the PHY blocks registers
>   - #phy-cells:
> -   - Must be 1 for brcm,sr-usb-combo-phy as it expects one argument to indicate
> -     the PHY number of two PHYs. 0 for HS PHY and 1 for SS PHY.
> -   - Must be 0 for brcm,sr-usb-hs-phy.
> +   - Must be 2 for brcm,sr-usb-combo-phy.
> +     - Cell 1 - PHY Number, 0 for HS PHY and 1 for SS PHY.
> +     - Cell 2 - Bitmask of enabled ports connected to USB Host controller.
> +   - Must be 1 for brcm,sr-usb-hs-phy to indicate Bit mask of ports connected
> +     to USB Host controller.
>  
>  Refer to phy/phy-bindings.txt for the generic PHY binding properties
>  
> @@ -16,17 +18,17 @@ Example:
>  	usbphy0: usb-phy@0 {
>  		compatible = "brcm,sr-usb-combo-phy";
>  		reg = <0x00000000 0x100>;
> -		#phy-cells = <1>;
> +		#phy-cells = <2>;
>  	};
>  
>  	usbphy1: usb-phy@10000 {
>  		compatible = "brcm,sr-usb-combo-phy";
>  		reg = <0x00010000 0x100>,
> -		#phy-cells = <1>;
> +		#phy-cells = <2>;
>  	};
>  
>  	usbphy2: usb-phy@20000 {
>  		compatible = "brcm,sr-usb-hs-phy";
>  		reg = <0x00020000 0x100>,
> -		#phy-cells = <0>;
> +		#phy-cells = <1>;
>  	};
> -- 
> 2.7.4
> 
