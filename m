Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A120850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfDAKXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:23:38 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34875 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfDAKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C1F60FB04;
        Mon,  1 Apr 2019 12:23:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 07DnQTbRGG0g; Mon,  1 Apr 2019 12:23:33 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9AE0444B5C; Mon,  1 Apr 2019 12:23:32 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:23:32 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH RESEND v7 2/3] dt-bindings: phy: Add documentation for
 mixel dphy
Message-ID: <20190401102332.GA23517@bogon.m.sigxcpu.org>
References: <cover.1553674604.git.agx@sigxcpu.org>
 <3319783f60fedd7f0029dd60a51c76a75003fe05.1553674604.git.agx@sigxcpu.org>
 <20190328165729.GA32345@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328165729.GA32345@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Mar 28, 2019 at 11:57:29AM -0500, Rob Herring wrote:
> On Wed, Mar 27, 2019 at 09:20:00AM +0100, Guido Günther wrote:
> > Add support for the MIXEL DPHY IP as found in the NXP's i.MX8MQ.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >  .../bindings/phy/mixel,mipi-dsi-phy.txt       | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > new file mode 100644
> > index 000000000000..d3646580412a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mixel,mipi-dsi-phy.txt
> > @@ -0,0 +1,29 @@
> > +Mixel DSI PHY for i.MX8
> > +
> > +The Mixel MIPI-DSI PHY IP block is e.g. found on i.MX8 platforms (along the
> > +MIPI-DSI IP from Northwest Logic). It represents the physical layer for the
> > +electrical signals for DSI.
> > +
> > +Required properties:
> > +- compatible: Must be:
> > +  - "mixel,imx8mq-mipi-dphy"
> 
> If you had a fallback for mixel, then it would make sense, but as this 
> is imx8mq specifc 'fsl' should be the vendor prefix.

Fixed in v8.

> 
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +- clock-names: Must contain the following entries:
> > +  - "phy_ref": phandle and specifier referring to the DPHY ref clock
> > +- reg: the register range of the PHY controller
> > +- #phy-cells: number of cells in PHY, as defined in
> > +  Documentation/devicetree/bindings/phy/phy-bindings.txt
> > +  this must be <0>
> > +
> > +Optional properties:
> > +- power-domains: phandle to power domain
> > +
> > +Example:
> > +	mipi_dphy: mipi_dphy@30A0030 {
> 
> mipi-dphy@... or just dphy@...

And this one as well.
Thanks for the review!
 -- Guido

>
> 
> > +		compatible = "mixel,imx8mq-mipi-dphy";
> > +		clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> > +		clock-names = "phy_ref";
> > +		reg = <0x30A00300 0x100>;
> > +		power-domains = <&pd_mipi0>;
> > +		#phy-cells = <0>;
> > +        };
> > -- 
> > 2.20.1
> > 
> 
