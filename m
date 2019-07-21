Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865FC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3262083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfGULrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:47:12 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58918 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfGULrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:47:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id D8422FB03;
        Sun, 21 Jul 2019 13:47:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wb98aE-Qp-3O; Sun, 21 Jul 2019 13:47:07 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3880941113; Sun, 21 Jul 2019 13:47:07 +0200 (CEST)
Date:   Sun, 21 Jul 2019 13:47:07 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Add MIPI D-PHY
Message-ID: <20190721114707.GA10132@bogon.m.sigxcpu.org>
References: <cover.1563187253.git.agx@sigxcpu.org>
 <30c7622bf590670190b93c9b5b6dd1e8f809bbb2.1563187253.git.agx@sigxcpu.org>
 <20190715111027.a4wlpzex3taxymyr@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715111027.a4wlpzex3taxymyr@fsr-ub1664-175>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
On Mon, Jul 15, 2019 at 11:10:27AM +0000, Abel Vesa wrote:
> On 19-07-15 12:43:05, Guido Günther wrote:
> > Add a node for the Mixel MIPI D-PHY, "disabled" by default.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Acked-by: Angus Ainslie (Purism) <angus@akkea.ca>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index d09b808eff87..891ee7578c2d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -728,6 +728,19 @@
> >  				status = "disabled";
> >  			};
> >  
> > +			dphy: dphy@30a00300 {
> > +				compatible = "fsl,imx8mq-mipi-dphy";
> > +				reg = <0x30a00300 0x100>;
> > +				clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> > +				clock-names = "phy_ref";
> > +				assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> > +				assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> > +				assigned-clock-rates = <24000000>;
> 
> We have the following in the clk-imx8mq in the vendor tree:
> 
> 	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_PLL1]);
> 
> This unbypasses the video pll 1. And then we also have this:
> 
> 	/* config video_pll1 clock */
> 	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_27M]);
> 	clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);

We don't have anything like this in our tree. This is our current clock
tree in that area which is setup by either the lcdif or dcss DT:

 osc_25m                             10       12        0    25000000          0     0  50000
    video_pll1_ref_sel                1        1        0    25000000          0     0  50000
       video_pll1_ref_div             1        1        0     5000000          0     0  50000
          video_pll1                  1        1        0   593999998          0     0  50000
             video_pll1_bypass        1        1        0   593999998          0     0  50000
                video_pll1_out        2        2        0   593999998          0     0  50000
                   dsi_phy_ref        1        1        0    23760000          0     0  50000

e.g. for lcdif we have:

	lcdif: lcdif@30320000 {
		...
		clock-names = "pix";
		assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
				  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
				  <&clk IMX8MQ_CLK_LCDIF_PIXEL>,
				  <&clk IMX8MQ_VIDEO_PLL1>;
		assigned-clock-parents = <&clk IMX8MQ_CLK_25M>,
				  <&clk IMX8MQ_VIDEO_PLL1>,
				  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
		assigned-clock-rates = <0>, <0>, <0>, <594000000>;
		...
	};

Do we want to add this add for dphy and lcdif?
Cheers,
 -- Guido

> But none of that is acceptable upstream since the clock provider should not
> use clock consumer API.
> 
> So please update the assigned-clock* properties to something like this:
> 				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> 						  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
> 						  <&clk IMX8MQ_CLK_DSI_PHY_REF>,
> 						  <&clk IMX8MQ_VIDEO_PLL1>;
> 				assigned-clock-parents = <&clk IMX8MQ_CLK_27M>,
> 							 <&clk IMX8MQ_VIDEO_PLL1>,
> 							 <&clk IMX8MQ_VIDEO_PLL1_OUT>
> 							 <0>;
> 				assigned-clock-rates = <0>,
> 						       <0>,
> 						       <24000000>,             
> 						       <593999999>;
> 
> I've written this without testing, so please do test it on your setup.

> 
> > +				#phy-cells = <0>;
> > +				power-domains = <&pgc_mipi>;
> > +				status = "disabled";
> > +			};
> > +
> >  			i2c1: i2c@30a20000 {
> >  				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
> >  				reg = <0x30a20000 0x10000>;
> > -- 
> > 2.20.1
> > 
