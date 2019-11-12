Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B55C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314D20674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wMgKZZjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfKLOfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:35:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39946 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfKLOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:35:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEZB9b101477;
        Tue, 12 Nov 2019 08:35:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569311;
        bh=x9hWpDcDogZT5+pZJ4sFKROQGd5yq+xxcXDXvuL4G0U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wMgKZZjbWS1mo7YhpKgA6rzT5yPuU+L0a0/2n0xx5Yre4Zbab+uPhygmoy9Z8E7XM
         dE5TKtUskNicGMGFRJuepTDzULIHhpm8HzcpmnqlglAjbPZWU4IbjsFu6+R3BOj12b
         WIBFCZugVZlpVcH37FgRS661URmUQCpDFKPwh/Bw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEZBkm047314;
        Tue, 12 Nov 2019 08:35:11 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:34:53 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:35:11 -0600
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with SMTP id xACEZBgh120737;
        Tue, 12 Nov 2019 08:35:11 -0600
Date:   Tue, 12 Nov 2019 08:38:13 -0600
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v3 20/20] dt-bindings: media: cal: convert binding to yaml
Message-ID: <20191112143813.tfshtp3zqq6xhw4f@ti.com>
References: <20191112143152.23176-1-bparrot@ti.com>
 <20191112143152.23176-21-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112143152.23176-21-bparrot@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob

Benoit Parrot <bparrot@ti.com> wrote on Tue [2019-Nov-12 08:31:52 -0600]:
> Convert ti-cal.txt to ti,cal.yaml.
> Add ti,cal.yaml to the MAINTAINERS file.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  .../devicetree/bindings/media/ti,cal.yaml     | 202 ++++++++++++++++++
>  .../devicetree/bindings/media/ti-cal.txt      |  81 -------
>  MAINTAINERS                                   |   1 +
>  3 files changed, 203 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/ti,cal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/media/ti-cal.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/ti,cal.yaml b/Documentation/devicetree/bindings/media/ti,cal.yaml
> new file mode 100644
> index 000000000000..1ea784179536
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti,cal.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/ti,cal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DRA72x CAMERA ADAPTATION LAYER (CAL) Device Tree Bindings
> +
> +maintainers:
> +  - Benoit Parrot <bparrot@ti.com>
> +
> +description: |-
> +  The Camera Adaptation Layer (CAL) is a key component for image capture
> +  applications. The capture module provides the system interface and the
> +  processing capability to connect CSI2 image-sensor modules to the
> +  DRA72x device.
> +
> +  CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
> +  should contain a 'port' child node with child 'endpoint' node. Please
> +  refer to the bindings defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +properties:
> +  compatible:
> +    enum:
> +      # for DRA72 controllers
> +      - ti,dra72-cal
> +      # for DRA72 controllers pre ES2.0
> +      - ti,dra72-pre-es2-cal
> +      # for DRA76 controllers
> +      - ti,dra76-cal
> +      # for AM654 controllers
> +      - ti,am654-cal
> +
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: The CAL main register region
> +      - description: The RX Core0 (DPHY0) register region
> +      - description: The RX Core1 (DPHY1) register region
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: cal_top
> +      - const: cal_rx_core0
> +      - const: cal_rx_core1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,camerrx-control:
> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    description:
> +      phandle to the device control module and offset to the
> +      control_camerarx_core register
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: fck
> +
> +  power-domains:
> +    description:
> +      List of phandle and PM domain specifier as documented in
> +      Documentation/devicetree/bindings/power/power_domain.txt
> +    maxItems: 1
> +
> +  # See ./video-interfaces.txt for details
> +  ports:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            const: 0
> +            description: CSI2 Port #0
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +              remote-endpoint: true
> +
> +        required:
> +          - reg
> +
> +      port@1:
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            const: 1
> +            description: CSI2 Port #1
> +
> +        patternProperties:
> +          endpoint:
> +            type: object
> +            additionalProperties: false
> +
> +            properties:
> +              clock-lanes:
> +                maxItems: 1
> +
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +              remote-endpoint: true
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +      - port@0
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - ti,camerrx-control
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    cal: cal@4845b000 {
> +        compatible = "ti,dra72-cal";
> +        reg = <0x4845B000 0x400>,
> +              <0x4845B800 0x40>,
> +              <0x4845B900 0x40>;
> +        reg-names = "cal_top",
> +                    "cal_rx_core0",
> +                    "cal_rx_core1";
> +        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> +        ti,camerrx-control = <&scm_conf 0xE94>;
> +
> +        ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              csi2_0: port@0 {
> +                    reg = <0>;
> +                    csi2_phy0: endpoint {
> +                           remote-endpoint = <&csi2_cam0>;
> +                           clock-lanes = <0>;
> +                           data-lanes = <1 2>;
> +                    };
> +              };
> +        };
> +    };
> +
> +    i2c5: i2c@4807c000 {
> +        clock-frequency = <400000>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        camera-sensor@3c {
> +               compatible = "ovti,ov5640";
> +               reg = <0x3c>;
> +
> +               clocks = <&clk_ov5640_fixed>;
> +               clock-names = "xclk";
> +
> +               port {
> +                    csi2_cam0: endpoint {
> +                            remote-endpoint = <&csi2_phy0>;
> +                            clock-lanes = <0>;
> +                            data-lanes = <1 2>;
> +                    };
> +               };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/media/ti-cal.txt b/Documentation/devicetree/bindings/media/ti-cal.txt
> deleted file mode 100644
> index 2deb256e7032..000000000000
> --- a/Documentation/devicetree/bindings/media/ti-cal.txt
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -Texas Instruments DRA72x CAMERA ADAPTATION LAYER (CAL)
> -------------------------------------------------------
> -
> -The Camera Adaptation Layer (CAL) is a key component for image capture
> -applications. The capture module provides the system interface and the
> -processing capability to connect CSI2 image-sensor modules to the
> -DRA72x device.
> -
> -Required properties:
> -- compatible:
> - Should be "ti,dra72-cal", for DRA72 controllers
> - Should be "ti,dra72-pre-es2-cal", for DRA72 controllers pre ES2.0
> - Should be "ti,dra76-cal", for DRA76 controllers
> - Should be "ti,am654-cal", for AM654 controllers
> -- reg:	CAL Top level, Receiver Core #0, Receiver Core #1 and Camera RX
> -	control address space
> -- reg-names: cal_top, cal_rx_core0, cal_rx_core1 and camerrx_control
> -	     registers
> -- interrupts: should contain IRQ line for the CAL;
> -- ti,camerrx-control: phandle to the device control module and offset to
> -		      the control_camerarx_core register.
> -		      This node is meant to replace the "camerrx_control"
> -		      reg entry above but "camerrx_control" is still
> -		      handled for backward compatibility.
> -
> -CAL supports 2 camera port nodes on MIPI bus. Each CSI2 camera port nodes
> -should contain a 'port' child node with child 'endpoint' node. Please
> -refer to the bindings defined in
> -Documentation/devicetree/bindings/media/video-interfaces.txt.
> -
> -Example:
> -	cal: cal@4845b000 {
> -		compatible = "ti,dra72-cal";
> -		reg = <0x4845B000 0x400>,
> -		      <0x4845B800 0x40>,
> -		      <0x4845B900 0x40>;
> -		reg-names = "cal_top",
> -			    "cal_rx_core0",
> -			    "cal_rx_core1";
> -		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> -		ti,camerrx-control = <&scm_conf 0xE94>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			csi2_0: port@0 {
> -				reg = <0>;
> -				csi2_phy0: endpoint {
> -					remote-endpoint = <&csi2_cam0>;
> -					clock-lanes = <0>;
> -					data-lanes = <1 2>;
> -				};
> -			};
> -			csi2_1: port@1 {
> -				reg = <1>;
> -			};
> -		};
> -	};
> -
> -	i2c5: i2c@4807c000 {
> -		clock-frequency = <400000>;
> -
> -		camera-sensor@3c {
> -			compatible = "ovti,ov5640";
> -			reg = <0x3c>;
> -
> -			clocks = <&clk_fixed>;
> -			clock-names = "xclk";
> -
> -			port {
> -				csi2_cam0: endpoint {
> -					remote-endpoint = <&csi2_phy0>;
> -					clock-lanes = <0>;
> -					data-lanes = <1 2>;
> -				};
> -			};
> -		};
> -	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 37a977cbac6f..909961cff0fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16324,6 +16324,7 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>  S:	Maintained
>  F:	drivers/media/platform/ti-vpe/
>  F:	Documentation/devicetree/bindings/media/ti,vpe.yaml
> +	Documentation/devicetree/bindings/media/ti,cal.yaml
>  
>  TI WILINK WIRELESS DRIVERS
>  L:	linux-wireless@vger.kernel.org
> -- 
> 2.17.1
> 
