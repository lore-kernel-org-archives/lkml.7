Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2336CC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3A12084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568385322;
	bh=L2aZaNdCImr47sE9f9LfcMNq+bZWzbgriMVnYufokkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SU+9osyTPLWV0ZdY4Et0EithTro4ZZVJxqU5b+ieRAyIDkL6MDn5oDdc3l7SoJkx9
	 1UdmTrIDnrQviIrbZklEjQo7N0HuEqGOcozstnDUuCdkwykQPmkXFBJ4S4wpXbK8Sy
	 EJ+aCO4lNeNtVTlKyGfKaR7s9kpmiIWYBoezewJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389369AbfIMOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:35:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35372 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388638AbfIMOfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:35:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so2827173oii.2;
        Fri, 13 Sep 2019 07:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gnQ4sN+iRS9l/wFXI9orzxasP2/6niFE7ovuaJFRKm0=;
        b=PUWatByHR6pw+HOsbX+x4WIVr5Ops8vjw/v7jw5w9vsfT//Nb/mYgJ4Q7x/CvyUUrd
         K/soX7BulG7cc3ijDPvnlGm5/BY1798CcxwK/XgOp0btGOtBI6Ry7+XueCNDNIwxIM+Q
         CYv8uIIp4EN63C98AN1UO0losO3l+lJRGr6r9toMUHNdu30qx1BTJ32giPEEnRsZwkSL
         jk8i8ag89NMUt2xrT+1TcHCIp4Y5sWaEfMcOBznt+exBZZ3WgdtA/5ubK3zSfW927Oz0
         Il1l4L39JU6wOGZ38ytcPqOJxRIgFEDrkTx4e4btgRBIVwFyr1Oo/NABd4aAT5cTSTPD
         4zzg==
X-Gm-Message-State: APjAAAVzxmw07e9gQDBoMD/8su7J6pYkYoii7pdQ1ZJZ4fSv+LUshyQY
        VhNxhgugoWbmJ8vPtd7G5NCTu3Q=
X-Google-Smtp-Source: APXvYqzMP+VkEeC4dMtYY+EMMnQK0eRsupvpKLIIFp+Cm46Zg2n9LtLv9VYB5NJgnyrwAD0HPsRlfQ==
X-Received: by 2002:aca:5554:: with SMTP id j81mr3655428oib.113.1568385311491;
        Fri, 13 Sep 2019 07:35:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e1sm9889609otj.48.2019.09.13.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:35:10 -0700 (PDT)
Date:   Fri, 13 Sep 2019 15:35:10 +0100
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] dt-bindings: display: Add xylon logicvc bindings
 documentation
Message-ID: <20190913143510.GA9504@bogus>
References: <20190910153409.111901-1-paul.kocialkowski@bootlin.com>
 <20190910153409.111901-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910153409.111901-2-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:34:08PM +0200, Paul Kocialkowski wrote:
> The Xylon LogiCVC is a display controller implemented as programmable
> logic in Xilinx FPGAs.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  .../bindings/display/xylon,logicvc.txt        | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc.txt

Consider converting this to DT schema format. See 
Documentation/devicetree/writing-schema.rst (.md in 5.3).
 
> diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc.txt b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> new file mode 100644
> index 000000000000..eb4b1553888a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/xylon,logicvc.txt
> @@ -0,0 +1,188 @@
> +Xylon LogiCVC display controller
> +
> +The Xylon LogiCVC is a display controller that supports multiple layers.
> +It is usually implemented as programmable logic and was optimized for use
> +with Xilinx Zynq-7000 SoCs and Xilinx FPGAs.
> +
> +Because the controller is intended for use in a FPGA, most of the configuration
> +of the controller takes place at logic configuration bitstream synthesis time.
> +As a result, many of the device-tree bindings are meant to reflect the
> +synthesis configuration. These do not allow configuring the controller
> +differently than synthesis configuration.
> +
> +Layers are declared in the "layers" sub-node and have dedicated configuration.
> +In version 3 of the controller, each layer has fixed memory offset and address
> +starting from the video memory base address for its framebuffer. With version 4,
> +framebuffers are configured with a direct memory address instead.
> +
> +Matching synthesis parameters are provided when applicable.
> +
> +Required properties:
> +- compatible: Should be one of:
> +  "xylon,logicvc-3.02.a-display"
> +  "xylon,logicvc-4.01.a-display"
> +- reg: Physical base address and size for the controller registers.
> +- clocks: List of phandle and clock-specifier pairs, one for each entry
> +  in 'clock-names'
> +- clock-names: List of clock names that should at least contain:
> +  - "vclk": The VCLK video clock input.
> +- interrupts: The interrupt to use for VBLANK signaling.
> +- xylon,display-interface: Display interface in use, should be one of:
> +  - "lvds-4bits": 4-bit LVDS interface (C_DISPLAY_INTERFACE == 4).
> +- xylon,display-colorspace: Display output colorspace in use, should be one of:
> +  - "rgb": RGB colorspace (C_DISPLAY_COLOR_SPACE == 0).
> +- xylon,display-depth: Display output depth in use (C_PIXEL_DATA_WIDTH).
> +- xylon,row-stride: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
> +- xylon,layers-count: The number of available layers (C_NUM_OF_LAYERS).

Presumably some of this is determined by the display attached. Isn't it 
safe to assume the IP was configured correctly for the intended display 
and you can just get this from the panel?


> +Optional properties:
> +- memory-region: phandle to a node describing memory, as specified in:
> +  Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +- clock-names: List of clock names that can optionally contain:
> +  - "vclk2": The VCLK2 doubled-rate video clock input.
> +  - "lvdsclk": The LVDS clock.
> +  - "lvdsclkn": The LVDS clock inverted.

How are these really optional?

> +- xylon,syscon: Syscon phandle representing the logicvc instance.
> +- xylon,dithering: Dithering module is enabled (C_XCOLOR).
> +- xylon,background-layer: The last layer is used to display a black background
> +  (C_USE_BACKGROUND). It must still be registered.
> +- xylon,layers-configurable: Configuration of layers' size, position and offset
> +  is enabled (C_USE_SIZE_POSITION).

I would think this will effectively have to be enabled to make this 
usable with DRM. I'm not sure if a "standard" userspace would use any of 
the layers if all this is fixed.

> +
> +Required sub-nodes:
> +- layers: The description of the display controller layers, containing layer
> +  sub-nodes that each describe a registered layer.
> +- ports: The LogiCVC connection to an encoder input port. The connection
> +  is modeled using the OF graph bindings, as specified in:
> +  Documentation/devicetree/bindings/graph.txt
> +
> +Required layer properties:
> +- reg: Layer index (from front to back, starting at 0).
> +- xylon,layer-depth: Layer depth in use (C_LAYER_0_DATA_WIDTH).
> +- xylon,layer-colorspace: Layer colorspace in use, should be one of:
> + - "rgb": RGB colorspace (C_LAYER_*_TYPE == 0).

Why is this needed if there's only 1?

> +- xylon,layer-alpha-mode: Alpha mode for the layer, should be one of:
> + - "layer": Alpha is configured layer-wide (C_LAYER_*_ALPHA_MODE == 0).
> + - "pixel": Alpha is configured per-pixel (C_LAYER_*_ALPHA_MODE == 1).

Could just be boolean.

> +- xylon,layer-base-offset: offset in number of lines (C_LAYER_*_OFFSET) starting
> +  from the video RAM base (C_VMEM_BASEADDR), only for version 3.
> +- xylon,layer-buffer-offset: offset in number of lines (C_BUFFER_*_OFFSET)
> +  starting from the layer base offset for the second buffer used in
> +  double-buffering.

It might be better to define all this in terms of byte offsets. I'd 
guess that is what CPU accesses are going to need.

> +
> +Optional layer properties:
> +- xylon,layer-primary: Layer should be registered as a primary plane (exactly
> +  one is required).
> +
> +Example:
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		logicvc_cma: cma@1f800000 {
> +			compatible = "shared-dma-pool";
> +			size = <0x800000>;
> +			alloc-ranges = <0x1f800000 0x800000>;
> +			reusable;
> +		};
> +	};
> +
> +	logicvc: logicvc@43c00000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x43c00000 0x6000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		logicvc_display: display-engine@0 {
> +			compatible = "xylon,logicvc-3.02.a-display";
> +			reg = <0x0 0x6000>;
> +			memory-region = <&logicvc_cma>;
> +
> +			clocks = <&logicvc_vclk 0>, <&logicvc_lvdsclk 0>;
> +			clock-names = "vclk", "lvdsclk";
> +
> +			interrupt-parent = <&intc>;
> +			interrupts = <0 34 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			xylon,syscon = <&logicvc>;
> +
> +			xylon,display-interface = "lvds-4bits";
> +			xylon,display-colorspace = "rgb";
> +			xylon,display-depth = <16>;
> +			xylon,row-stride = <1024>;
> +
> +			xylon,layers-configurable;
> +			xylon,layers-count = <5>;
> +
> +			layers {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				layer@0 {
> +					reg = <0>;
> +					xylon,layer-depth = <16>;
> +					xylon,layer-colorspace = "rgb";
> +					xylon,layer-alpha-mode = "layer";
> +					xylon,layer-base-offset = <0>;
> +					xylon,layer-buffer-offset = <480>;
> +					xylon,layer-primary;
> +				};
> +
> +				layer@1 {
> +					reg = <1>;
> +					xylon,layer-depth = <16>;
> +					xylon,layer-colorspace = "rgb";
> +					xylon,layer-alpha-mode = "layer";
> +					xylon,layer-base-offset = <2400>;
> +					xylon,layer-buffer-offset = <480>;
> +				};
> +
> +				layer@2 {
> +					reg = <2>;
> +					xylon,layer-depth = <16>;
> +					xylon,layer-colorspace = "rgb";
> +					xylon,layer-alpha-mode = "layer";
> +					xylon,layer-base-offset = <960>;
> +					xylon,layer-buffer-offset = <480>;
> +				};
> +
> +				layer@3 {
> +					reg = <3>;
> +					xylon,layer-depth = <16>;
> +					xylon,layer-colorspace = "rgb";
> +					xylon,layer-alpha-mode = "layer";
> +					xylon,layer-base-offset = <480>;
> +					xylon,layer-buffer-offset = <480>;
> +				};
> +
> +				layer@4 {
> +					reg = <4>;
> +					xylon,layer-depth = <16>;
> +					xylon,layer-colorspace = "rgb";
> +					xylon,layer-alpha-mode = "layer";
> +					xylon,layer-base-offset = <8192>;
> +					xylon,layer-buffer-offset = <480>;
> +				};
> +			};
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				logicvc_out: port@1 {
> +					reg = <1>;
> +
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					logicvc_output: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&panel_input>;
> +					};
> +				};
> +			};
> +		};
> +	};
> -- 
> 2.23.0
> 
