Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB2C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CBE229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfGZJXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:23:25 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55767 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:23:25 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 3483420026;
        Fri, 26 Jul 2019 11:23:17 +0200 (CEST)
Date:   Fri, 26 Jul 2019 11:23:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: display/bridge: Add binding for IMX NWL
 mipi dsi host controller
Message-ID: <20190726092315.GA9754@ravnborg.org>
References: <cover.1563983037.git.agx@sigxcpu.org>
 <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=ze386MxoAAAA:8
        a=e5mUnYsNAAAA:8 a=uEMGSPKFWDNqce5SinMA:9 a=NMl6CGBPn1O5J89H:21
        a=Vgy-7kDX4t5A4FfJ:21 a=wPNLvfGTeEIA:10 a=iBZjaW-pnkserzjvUTHh:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido.

A few comments follows.

	Sam

On Wed, Jul 24, 2019 at 05:52:25PM +0200, Guido Günther wrote:
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/display/bridge/imx-nwl-dsi.txt   | 89 +++++++++++++++++++

New binding. Any chance we can get this in yaml format?
This is the way forward and we have to convert the file anyway.

None of the other bridges use yaml format, but someone has to be the
first.

>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> new file mode 100644
> index 000000000000..288fdb726d5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> @@ -0,0 +1,89 @@
> +Northwest Logic MIPI-DSI on imx SoCs
> +=====================================
> +
> +NWL MIPI-DSI host controller found on i.MX8 platforms. This is a
> +dsi bridge for the for the NWL MIPI-DSI host.

To my best understanding a bridge is something that converts from one
format to another format.
Something that in the drm world are connected to an encoder.

I do not know the HW here - but from this very brif description this
sounds more like a display controller and not a bridge?


> +
> +Required properties:
> +- compatible: 		"fsl,<chip>-nwl-dsi"
> +	The following strings are expected:
> +			"fsl,imx8mq-nwl-dsi"
> +- reg: 			the register range of the MIPI-DSI controller
> +- interrupts: 		the interrupt number for this module
> +- clock, clock-names: 	phandles to the MIPI-DSI clocks
> +	The following clocks are expected on all platforms:
> +		"core"    - DSI core clock
> +		"tx_esc"  - TX_ESC clock (used in escape mode)
> +		"rx_esc"  - RX_ESC clock (used in escape mode)
> +		"phy_ref" - PHY_REF clock. Clock is managed by the phy. Only
> +                            used to read the clock rate.
> +- assigned-clocks:	phandles to clocks that require initial configuration
> +- assigned-clock-rates:	rates of the clocks that require initial configuration
> +	The following clocks need to have an initial configuration:
> +	"tx_esc" (20 MHz) and "rx_esc" (80 Mhz).
> +- phys: 		phandle to the phy module representing the DPHY
> +			inside the MIPI-DSI IP block
> +- phy-names: 		should be "dphy"
> +
> +Optional properties:
> +- power-domains 	phandle to the power domain
> +- src			phandle to the system reset controller (required on
> +			i.MX8MQ)
Name is not very descriptive.
Other bindings seems to use "resets" here?

> +- mux-sel		phandle to the MUX register set (required on i.MX8MQ)
> +- assigned-clock-parents phandles to parent clocks that needs to be assigned as
> +			parents to clocks defined in assigned-clocks
> +
> +Example:
> +	mipi_dsi: mipi_dsi@30a00000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,imx8mq-nwl-dsi";
> +		reg = <0x30A00000 0x300>;
> +		clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
> +			 <&clk IMX8MQ_CLK_DSI_AHB>,
> +			 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
> +			 <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +		clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> +		assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
> +				  <&clk IMX8MQ_CLK_DSI_CORE>,
> +				  <&clk IMX8MQ_CLK_DSI_IPG_DIV>;
> +		assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
> +					 <&clk IMX8MQ_SYS1_PLL_266M>;
> +		assigned-clock-rates = <80000000>,
> +				       <266000000>,
> +				       <20000000>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&pgc_mipi>;
> +		src = <&src>;
> +		mux-sel = <&iomuxc_gpr>;
> +		phys = <&dphy>;
> +		phy-names = "dphy";
> +		status = "okay";
I recall status should not be included in examples.

> +
> +		panel@0 {
> +			compatible = "...";
> +			port {
> +			     panel_in: endpoint {
> +				       remote-endpoint = <&mipi_dsi_out>;
> +			     };
> +			};
> +		};
> +
> +		ports {
> +		      #address-cells = <1>;
> +		      #size-cells = <0>;
> +
> +		      port@0 {
> +			     reg = <0>;
> +			     mipi_dsi_in: endpoint {
> +					  remote-endpoint = <&dcss_disp0_mipi_dsi>;
> +			     };
> +		      };
> +		      port@1 {
> +			     reg = <1>;
> +			     mipi_dsi_out: endpoint {
> +					   remote-endpoint = <&panel_in>;
> +			     };
> +		      };
> +		};
> +	};
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
