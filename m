Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E8C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF832089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfGaOhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:37:09 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:52650 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbfGaOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:37:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DECAEFB03;
        Wed, 31 Jul 2019 16:37:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uyFt2kyVmQ3o; Wed, 31 Jul 2019 16:37:05 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2ACD946D8A; Wed, 31 Jul 2019 16:37:05 +0200 (CEST)
Date:   Wed, 31 Jul 2019 16:37:05 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
Message-ID: <20190731143705.GB1935@bogon.m.sigxcpu.org>
References: <cover.1563983037.git.agx@sigxcpu.org>
 <70a5c6617936a4a095e7608b96e3f9fae5ddfbb1.1563983037.git.agx@sigxcpu.org>
 <20190727015716.GA4902@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190727015716.GA4902@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

thanks for having a look.

On Sat, Jul 27, 2019 at 04:57:16AM +0300, Laurent Pinchart wrote:
> Hi Guido,
> 
> Thank you for the patch.
> 
> On Wed, Jul 24, 2019 at 05:52:25PM +0200, Guido Günther wrote:
> > The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../bindings/display/bridge/imx-nwl-dsi.txt   | 89 +++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > new file mode 100644
> > index 000000000000..288fdb726d5a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/imx-nwl-dsi.txt
> > @@ -0,0 +1,89 @@
> > +Northwest Logic MIPI-DSI on imx SoCs
> > +=====================================
> 
> There's one too many =.
> 
> > +
> > +NWL MIPI-DSI host controller found on i.MX8 platforms. This is a
> > +dsi bridge for the for the NWL MIPI-DSI host.
> 
> s/dsi/DSI/
> s/for the for the /for the /
> 
> > +
> > +Required properties:
> > +- compatible: 		"fsl,<chip>-nwl-dsi"
> > +	The following strings are expected:
> > +			"fsl,imx8mq-nwl-dsi"
> > +- reg: 			the register range of the MIPI-DSI controller
> > +- interrupts: 		the interrupt number for this module
> 
> It's not just a number but a specifier (with flags).
> 
> > +- clock, clock-names: 	phandles to the MIPI-DSI clocks
> 
> That should be phandles and names.
> 
> > +	The following clocks are expected on all platforms:
> 
> Expected or required ?
> 
> s/ on all platforms// as you only support a single platform.
> 
> > +		"core"    - DSI core clock
> > +		"tx_esc"  - TX_ESC clock (used in escape mode)
> > +		"rx_esc"  - RX_ESC clock (used in escape mode)
> > +		"phy_ref" - PHY_REF clock. Clock is managed by the phy. Only
> > +                            used to read the clock rate.
> > +- assigned-clocks:	phandles to clocks that require initial configuration
> > +- assigned-clock-rates:	rates of the clocks that require initial configuration
> > +	The following clocks need to have an initial configuration:
> > +	"tx_esc" (20 MHz) and "rx_esc" (80 Mhz).
> 
> I think those two properties are out of scope for these bindings.
> 
> > +- phys: 		phandle to the phy module representing the DPHY
> > +			inside the MIPI-DSI IP block
> > +- phy-names: 		should be "dphy"
> > +
> > +Optional properties:
> > +- power-domains 	phandle to the power domain
> > +- src			phandle to the system reset controller (required on
> > +			i.MX8MQ)
> 
> Should this use the standard resets property ?
> 
> > +- mux-sel		phandle to the MUX register set (required on i.MX8MQ)
> > +- assigned-clock-parents phandles to parent clocks that needs to be assigned as
> > +			parents to clocks defined in assigned-clocks
> 
> This property is also out of scope.
> 
> > +
> > +Example:
> > +	mipi_dsi: mipi_dsi@30a00000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "fsl,imx8mq-nwl-dsi";
> > +		reg = <0x30A00000 0x300>;
> > +		clocks = <&clk IMX8MQ_CLK_DSI_CORE>,
> > +			 <&clk IMX8MQ_CLK_DSI_AHB>,
> > +			 <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
> > +			 <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> > +		clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> > +		assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
> > +				  <&clk IMX8MQ_CLK_DSI_CORE>,
> > +				  <&clk IMX8MQ_CLK_DSI_IPG_DIV>;
> > +		assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
> > +					 <&clk IMX8MQ_SYS1_PLL_266M>;
> > +		assigned-clock-rates = <80000000>,
> > +				       <266000000>,
> > +				       <20000000>;
> > +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +		power-domains = <&pgc_mipi>;
> > +		src = <&src>;
> > +		mux-sel = <&iomuxc_gpr>;
> > +		phys = <&dphy>;
> > +		phy-names = "dphy";
> > +		status = "okay";
> > +
> > +		panel@0 {
> > +			compatible = "...";
> > +			port {
> > +			     panel_in: endpoint {
> > +				       remote-endpoint = <&mipi_dsi_out>;
> > +			     };
> > +			};
> > +		};
> > +
> > +		ports {
> > +		      #address-cells = <1>;
> > +		      #size-cells = <0>;
> > +
> > +		      port@0 {
> > +			     reg = <0>;
> > +			     mipi_dsi_in: endpoint {
> > +					  remote-endpoint = <&dcss_disp0_mipi_dsi>;
> > +			     };
> > +		      };
> > +		      port@1 {
> > +			     reg = <1>;
> > +			     mipi_dsi_out: endpoint {
> > +					   remote-endpoint = <&panel_in>;
> > +			     };
> > +		      };
> > +		};
> 
> The ports should be documented too. There are multiple example bindings
> available.

I've followed you suggestions while moving the whole thing to YAML
syntax for an upcoming v2.

Thanks for having a look,
Cheers,
 -- Guido

> > +	};
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
