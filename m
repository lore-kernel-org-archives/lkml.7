Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26B2C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E1421721
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IHOZFXWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfG0B51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 21:57:27 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52528 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0B50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:57:26 -0400
Received: from pendragon.ideasonboard.com (om126200118163.15.openmobile.ne.jp [126.200.118.163])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C7D12E7;
        Sat, 27 Jul 2019 03:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564192643;
        bh=uI0bqTAW3t85cdKpK+aJtIq1FdKPSDyFmGcCRL27uww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHOZFXWK6i11B9Y5Yp8r4rV/SwPIw8+i8amu6nqTFpW25jE/5BxkgNnqkQ8LXj4ep
         f0OWUvcY17E0rmisWI5XM2/NqWyAbteTdPbnQCLX+oMpNFeNCrIBv9Sz7/noGheFp4
         uB5GA8vnAmhDHDWaaqcza7FOFKEeB9Vcn5UbDOv4=
Date:   Sat, 27 Jul 2019 04:57:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
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
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robert Chiras <robert.chiras@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: display/bridge: Add binding for IMX NWL
 mipi dsi host controller
Message-ID: <20190727015716.GA4902@pendragon.ideasonboard.com>
References: <cover.1563983037.git.agx@sigxcpu.org>
 <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Wed, Jul 24, 2019 at 05:52:25PM +0200, Guido Günther wrote:
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/display/bridge/imx-nwl-dsi.txt   | 89 +++++++++++++++++++
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

There's one too many =.

> +
> +NWL MIPI-DSI host controller found on i.MX8 platforms. This is a
> +dsi bridge for the for the NWL MIPI-DSI host.

s/dsi/DSI/
s/for the for the /for the /

> +
> +Required properties:
> +- compatible: 		"fsl,<chip>-nwl-dsi"
> +	The following strings are expected:
> +			"fsl,imx8mq-nwl-dsi"
> +- reg: 			the register range of the MIPI-DSI controller
> +- interrupts: 		the interrupt number for this module

It's not just a number but a specifier (with flags).

> +- clock, clock-names: 	phandles to the MIPI-DSI clocks

That should be phandles and names.

> +	The following clocks are expected on all platforms:

Expected or required ?

s/ on all platforms// as you only support a single platform.

> +		"core"    - DSI core clock
> +		"tx_esc"  - TX_ESC clock (used in escape mode)
> +		"rx_esc"  - RX_ESC clock (used in escape mode)
> +		"phy_ref" - PHY_REF clock. Clock is managed by the phy. Only
> +                            used to read the clock rate.
> +- assigned-clocks:	phandles to clocks that require initial configuration
> +- assigned-clock-rates:	rates of the clocks that require initial configuration
> +	The following clocks need to have an initial configuration:
> +	"tx_esc" (20 MHz) and "rx_esc" (80 Mhz).

I think those two properties are out of scope for these bindings.

> +- phys: 		phandle to the phy module representing the DPHY
> +			inside the MIPI-DSI IP block
> +- phy-names: 		should be "dphy"
> +
> +Optional properties:
> +- power-domains 	phandle to the power domain
> +- src			phandle to the system reset controller (required on
> +			i.MX8MQ)

Should this use the standard resets property ?

> +- mux-sel		phandle to the MUX register set (required on i.MX8MQ)
> +- assigned-clock-parents phandles to parent clocks that needs to be assigned as
> +			parents to clocks defined in assigned-clocks

This property is also out of scope.

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

The ports should be documented too. There are multiple example bindings
available.

> +	};

-- 
Regards,

Laurent Pinchart
