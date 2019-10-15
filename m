Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A922ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFB720872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571174975;
	bh=T7AWOqTvTWmoZd5J7PfN4061r/+5WWRP4xKsLs5V+Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u0QVvtG0ily6diCpj5hGBow3kpRtanISCRLjyBTOfl+nKhyBgk/5ckJg5vfZvQCsU
	 ApKf8HJl524nThrpG4abM3mg4DqVEa2r1MBNcGsHOyD+BQNFvsAEhKtU7ostfY8S4H
	 cTS9pFxiP9y9+4JgEEjhiqvP2s6+M//C6KLGbCkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfJOV3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:29:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38819 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfJOV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:29:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id m16so18182991oic.5;
        Tue, 15 Oct 2019 14:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbwveZ50AkqIbP4Itqlsx5ooyBIGNElzrTfxvpsJZS8=;
        b=Y9C8cvxGeo8nWxLEL3sYbZ850RTm42JSYsIayve1dzg6Hdr8AKWADDDKcfXcaZSRkJ
         YAN5u+HBc3gbky9bPnnfP7d5JYdE7AuvNCxr29HEju370BQmKVfquiANK/txngYLN/yx
         UdxGoWwU9dDJyHZylLoEspafGgb7H7gBwFwSf5xV1pHW5rBbf6JEpqKGASva7yB6Dek+
         wN3HSHyrvPiS6bGV06B+DVDd9PcQIK8FMlDfc5iAtuaZBHwVpe4tFpOjPb3FK+/srkVz
         srKLeSkMIB7RBMmTp1zK5RX2Yl4UgwlZ78z2stFNJBQGZqmTww55yNPXtcsYCuOIUa3e
         5rbw==
X-Gm-Message-State: APjAAAWMK1Ku24ojhMFU7vgYk7tc+aBfoJPEiUsSSf2jMKVry/HdTeVD
        YUHTAAL63Hdusy0uP8fzlQ==
X-Google-Smtp-Source: APXvYqwZwL8+yC/RXLuTkW6Sv3IuKwFVCiV0tFWnlQN1htXXuxCwMA0OHypPOp7q5Kl9gE79aV4i6g==
X-Received: by 2002:aca:490f:: with SMTP id w15mr540730oia.159.1571174972402;
        Tue, 15 Oct 2019 14:29:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q18sm6913157otk.57.2019.10.15.14.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 14:29:31 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:29:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        pawell@cadence.com, nsekhar@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add binding for the TI wrapper for
 Cadence USB3 controller
Message-ID: <20191015212931.GA8031@bogus>
References: <20191007114142.5182-1-rogerq@ti.com>
 <20191007114142.5182-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007114142.5182-2-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:41:41PM +0300, Roger Quadros wrote:
> TI platforms have a wrapper module around the Cadence USB3
> controller. Add binding information for that.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  .../devicetree/bindings/usb/cdns-usb3-ti.txt  | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt

Please convert to DT schema.

> diff --git a/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
> new file mode 100644
> index 000000000000..12c7c903e6da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/cdns-usb3-ti.txt
> @@ -0,0 +1,59 @@
> +Binding for the TI specific wrapper for the Cadence USBSS-DRD controller
> +
> +Required properties:
> +  - compatible: Should contain "ti,j721e-usb"
> +  - reg: Physical base address and size of the wrappers register area.
> +  - power-domains: Should contain a phandle to a PM domain provider node
> +                   and an args specifier containing the USB device id
> +                   value. This property is as per the binding documentation:
> +                   Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> +  - clocks: Clock phandles to usb2_refclk and lpm_clk
> +  - clock-names: Should contain "usb2_refclk" and "lpm_clk"

_clk is redundant. 'ref' amd 'lpm' is sufficient.

> +
> +Optional properties:
> + - ti,usb2-only: If present, it restricts the controller to USB2.0 mode of
> +		 operation. Must be present if USB3 PHY is not available
> +		 for USB.

Seems like this should be discoverable based on describing the phy 
connections.

> + - ti,modestrap-host: Set controller modestrap to HOST mode.
> + - ti,modestrap-peripheral: Set controller modestrap to PERIPHERAL mode.

What does modestrap mean? Fixed to the mode or that's the default? For 
default, John Stultz sent a similar binding. Seems we need something 
common.

> + - ti,vbus-divider: Should be present if USB VBUS line is connected to the
> +		 VBUS pin of the SoC via a 1/3 voltage divider.
> +
> +Sub-nodes:
> +The USB2 PHY and the Cadence USB3 controller should be the sub-nodes.
> +
> +Example:
> +
> +	ti_usb0: cdns_usb@4104000 {
> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x4104000 0x00 0x100>;
> +		power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 288 15>, <&k3_clks 288 3>;
> +		clock-names = "usb2_refclk", "lpm_clk";
> +		assigned-clocks = <&k3_clks 288 15>;	/* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		phy@4108000 {
> +			compatible = "ti,j721e-usb2-phy";
> +			reg = <0x00 0x4108000 0x00 0x400>;
> +		};

Why is this a child node? Use the phy binding.

> +
> +		usb0: usb@6000000 {
> +			compatible = "cdns,usb3-1.0.1";

Not documented.

> +			reg = <0x00 0x6000000 0x00 0x10000>,
> +			      <0x00 0x6010000 0x00 0x10000>,
> +			      <0x00 0x6020000 0x00 0x10000>;
> +			reg-names = "otg", "xhci", "dev";
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,	/* irq.0 */
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,	/* irq.6 */
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;	/* otgirq.0 */
> +			interrupt-names = "host",
> +					  "peripheral",
> +					  "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
