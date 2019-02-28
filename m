Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54350C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08145218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551371352;
	bh=p2Ow9VQ3/WB64luUfYcQtvC7P+FiFjmZynjtFCjxWgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GTPHIBDdEAdQaD61jr0tw8PDEZVmwFXsCsN+130+Qlcz4dHXzVSbhEZdTfFW2s+s2
	 Zdd9tc8lAqHhrkUayi79yFPTlHcOBE+EORRg7PsOdhS8WwTK2Sb+DFbr3axhIrFttf
	 7ML/jdBxWIBnckiFjknBxN8iYRIo/Z1hb4edz/ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbfB1Q3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:29:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43013 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbfB1Q3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:29:09 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so18185529ota.10;
        Thu, 28 Feb 2019 08:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDJPoyiueCFxJIGWXl1p8gm7hPwEGMxrrWrTfC1gVZs=;
        b=Y+R76m/66CYl7BlhxReM0Q/yf0ObsHa04280OcuFKy4oXNlbKV5fmJBqBUMvzEont8
         KFwZuyvxdf32CryhM+oExIzmFLLeR9ut2ju4jqT6D1+J3iuR40J/85jq/IUizqZBXj2o
         0OsMG4yVwTo9RY7gW/0FXLFieO9mMRlk8pV1GC6nTBmy/XIEuN3VAIU2Mp5jG2GxxZUh
         q8LpR8TrI2XCcDZFI2ihgIbGWP50blfDUhLXOUntcp/2oivv63nX2nmJ+KZ4i3yIWjBj
         ZRRSXBYccw7C2oUk2LjlAVo661M3pr1hYEWNTLeif90VHI/UV/4UuTNq3oS5Vg7FT9gL
         cwyw==
X-Gm-Message-State: APjAAAWsa89XyLSFUplz4jq2Vuk61ZUDhpsM3xV1Wj+Fv8jVlhxSvcdi
        50/VTOJcs8WUmZ5bYgh8/Q==
X-Google-Smtp-Source: APXvYqzXYbBWpv3eh4u53oqMMm3NLSs57xKlhsH5F7lgCcnETKjp4124p/F6w8qskmLEXCzMLWtpjQ==
X-Received: by 2002:a9d:58c3:: with SMTP id s3mr261154oth.233.1551371347896;
        Thu, 28 Feb 2019 08:29:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n12sm2993534otl.22.2019.02.28.08.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:29:07 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:29:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue
 Bindings
Message-ID: <20190228162906.GA2387@bogus>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
 <20190212151413.24632-5-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212151413.24632-5-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:14:09PM +0100, Neil Armstrong wrote:
> Adds the bindings for the Amlogic G12A USB Glue HW.
> 
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
> 
> A glue connects these both controllers to 2 USB2 PHYs,
> and optionnally to an USB3+PCIE Combo PHY shared with the PCIE controller.
> 
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
> 
> The PHYs are children of the Glue node since the Glue controls the interface
> with the PHY, not the DWC3 controller.
> 
> The PHY interconnect is handled into ports subnodes, which eases describing
> which PHY is enabled (like the USB3 shared PHY) and futures layouts on
> derivatives of the G12A Family.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/usb/amlogic,dwc3.txt  | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
> index 9a8b631904fd..c7c4726ef10d 100644
> --- a/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
> @@ -40,3 +40,112 @@ Example device nodes:
>  				phy-names = "usb2-phy", "usb3-phy";
>  			};
>  		};
> +
> +Amlogic Meson G12A DWC3 USB SoC Controller Glue
> +
> +The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
> +in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
> +only.
> +
> +A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
> +
> +One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
> +
> +The DWC3 Glue controls the PHY routing and power, an interrupt line is
> +connected to the Glue to serve as OTG ID change detection.
> +
> +Required properties:
> +- compatible:	Should be "amlogic,meson-g12a-usb-ctrl"
> +- clocks:	a handle for the "USB" clock
> +- clock-names:	must be "usb"
> +- resets:	a handle for the shared "USB" reset line
> +- reset-names:	must be "usb"

-name for a single entry is pointless.

> +- reg:		The base address and length of the registers
> +- interrupts:	the interrupt specifier for the OTG detection
> +
> +Required child nodes:
> +
> +USB Ports are described as child 'port' nodes grouped under a 'ports' node,
> +with #address-cells, #size-cells specified.
> +
> +Each 'port' sub-node identifies a possible USB Port served by an USB PHY
> +identified by the 'phy' property as decribed in ../phy/phy-bindings.txt
> +
> +Each 'port' is identified by a reg property to number the port.
> +
> +The following table lists for each supported model the port number
> +corresponding to each PHY serving a physical USB Port.
> +
> + Family	   Port 0     Port 1    Port 2    Port 3    Port 4
> +---------------------------------------------------------------
> + G12A	   USBHOST_A  USBOTG_B  Reserved  Reserved  USB3_0
> +
> +A child node must exist to represent the core DWC3 IP block. The name of
> +the node is not important. The content of the node is defined in dwc3.txt.
> +
> +A child node must exist to represent the core DWC2 IP block. The name of
> +the node is not important. The content of the node is defined in dwc2.txt.
> +
> +PHY documentation is provided in the following places:
> +- Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
> +- Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
> +
> +
> +Example device nodes:
> +	usb: usb@ffe09000 {
> +			compatible = "amlogic,meson-g12a-usb-ctrl";
> +			reg = <0x0 0xffe09000 0x0 0xa0>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&clkc CLKID_USB>;
> +			clock-names = "usb";
> +			resets = <&reset RESET_USB>;
> +			reset-names = "usb";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* USB2 Port 0 */
> +				usb20: port@0 {
> +					reg = <0>;
> +					phys = <&usb2_phy0>;

'ports' and 'port' are reserved for the graph binding. Don't use it for 
your own thing.

Can't you just make 'phys' a list using 0 phandle if you need to skip 
entries.

> +				};
> +
> +				/* USB2 Port 1 */
> +				usb21: port@1 {
> +					reg = <1>;
> +					phys = <&usb2_phy1>;
> +				};
> +
> +				/* USB3 Port 0 */
> +				usb3: port@4 {
> +					reg = <4>;
> +					phys = <&usb3_pcie_phy PHY_TYPE_USB3>;
> +				};
> +			};
> +
> +			dwc2: usb@ff400000 {
> +				compatible = "amlogic,meson-g12a-usb", "snps,dwc2";
> +				reg = <0x0 0xff400000 0x0 0x40000>;
> +				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc CLKID_USB1_DDR_BRIDGE>;
> +				clock-names = "ddr";
> +				dr_mode = "peripheral";
> +				g-rx-fifo-size = <192>;
> +				g-np-tx-fifo-size = <128>;
> +				g-tx-fifo-size = <128 128 16 16 16>;
> +			};
> +
> +			dwc3: dwc3@ff500000 {

usb@... or usb3@...

> +				compatible = "snps,dwc3";
> +				reg = <0x0 0xff500000 0x0 0x100000>;
> +				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +				dr_mode = "host";
> +				snps,dis_u2_susphy_quirk;
> +				snps,quirk-frame-length-adjustment;
> +			};
> +	};
> -- 
> 2.20.1
> 
