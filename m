Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03EF206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfHMKKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:10:11 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:51972 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfHMKKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:10:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 4D013FB03;
        Tue, 13 Aug 2019 12:10:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qBv1tHLBoCNN; Tue, 13 Aug 2019 12:10:06 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 0825F416CC; Tue, 13 Aug 2019 12:10:05 +0200 (CEST)
Date:   Tue, 13 Aug 2019 12:10:05 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
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
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
Message-ID: <20190813101005.GA10751@bogon.m.sigxcpu.org>
References: <cover.1565367567.git.agx@sigxcpu.org>
 <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
 <CAL_JsqK-5=WMZgNuJDTJ3Dm3YOJNw_9QCrPOOSe7MQzMV26pHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK-5=WMZgNuJDTJ3Dm3YOJNw_9QCrPOOSe7MQzMV26pHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
thanks for having a look!

On Fri, Aug 09, 2019 at 02:41:03PM -0600, Rob Herring wrote:
> On Fri, Aug 9, 2019 at 10:24 AM Guido Günther <agx@sigxcpu.org> wrote:
> >
> > The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> >
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++++++++++++++++
> >  1 file changed, 155 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > new file mode 100644
> > index 000000000000..5ed8bc4a4d18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> > @@ -0,0 +1,155 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/imx-nwl-dsi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Northwest Logic MIPI-DSI on imx SoCs
> > +
> > +maintainers:
> > +  - Guido Gúnther <agx@sigxcpu.org>
> > +  - Robert Chiras <robert.chiras@nxp.com>
> > +
> > +description: |
> > +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
> > +  the SOCs NWL MIPI-DSI host controller.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - const: fsl,imx8mq-nwl-dsi
> 
> Don't need oneOf nor items here for a single possible value:

I wanted to prepare for adding other SoCs so there's less diff noise
(other imx8 SoCs will be rather simple) but let's go with 'const' for
now then.

> compatible:
>   const: fsl,imx8mq-nwl-dsi
> 
> Or go ahead and add other compatibles because the 'if' below seems to
> indicate you'll have more.

> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: DSI core clock
> > +      - description: RX_ESC clock (used in escape mode)
> > +      - description: TX_ESC clock (used in escape mode)
> > +      - description: PHY_REF clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: rx_esc
> > +      - const: tx_esc
> > +      - const: phy_ref
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description:
> > +      A phandle to the phy module representing the DPHY
> > +
> > +  phy-names:
> > +    items:
> > +      - const: dphy
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description:
> > +      A phandle to the power domain
> > +
> > +  resets:
> > +    maxItems: 4
> > +    description:
> > +      A phandle to the reset controller
> 
> Sounds like 4 phandles... This should look similar to 'clocks'.

Added them individually, will be soc specific too later on.

> 
> > +
> > +  reset-names:
> > +    items:
> > +      - const: byte
> > +      - const: dpi
> > +      - const: esc
> > +      - const: pclk
> > +
> > +  mux-sel:
> 
> Needs a vendor prefix and will need a $ref to the type.

Made that fsl,mux-sel. This require me to add '$ref:
/schemas/types.yaml#definitions/phandle' as well which
I hope is correct.

> > +    maxItems: 1
> > +    description:
> > +      A phandle to the MUX register set
> > +
> > +  port:
> > +    type: object
> > +    description:
> > +      A input put or output port node.
> > +
> > +  ports:
> > +    type: object
> > +    description:
> > +      A node containing DSI input & output port nodes with endpoint
> > +      definitions as documented in
> > +      Documentation/devicetree/bindings/graph.txt.
> 
> You need to define what port@0 and port@1 are.

Added.

> 
> > +
> > +patternProperties:
> > +  "^panel@[0-9]+$": true
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8mq-nwl-dsi
> 
> This conditional isn't needed until you have more than one compatible.

Again intended for other upcoming SoCs but dropped for now.

> > +      required:
> > +        - resets
> > +        - reset-names
> > +        - mux-sel
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
> 
> ports should be required.

Added.

> > +
> > +examples:
> > + - |
> > +
> > +   mipi_dsi: mipi_dsi@30a00000 {
> > +              #address-cells = <1>;
> > +              #size-cells = <0>;
> > +              compatible = "fsl,imx8mq-nwl-dsi";
> > +              reg = <0x30A00000 0x300>;
> > +              clocks = <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
> > +              clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> > +              interrupts = <0 34 4>;
> > +              power-domains = <&pgc_mipi>;
> > +              resets = <&src 0>, <&src 1>, <&src 2>, <&src 3>;
> > +              reset-names = "byte", "dpi", "esc", "pclk";
> > +              mux-sel = <&iomuxc_gpr>;
> > +              phys = <&dphy>;
> > +              phy-names = "dphy";
> > +
> > +              panel@0 {
> > +                      compatible = "...";
> 
> Needs to be a valid compatible. Also need 'reg' here or drop the
> unit-address.

Fixed.

> 
> 
> > +                      port@0 {
> > +                           panel_in: endpoint {
> > +                                     remote-endpoint = <&mipi_dsi_out>;
> > +                           };
> > +                      };
> > +              };
> > +
> > +              ports {
> > +                    #address-cells = <1>;
> > +                    #size-cells = <0>;
> > +
> > +                    port@0 {
> > +                           reg = <0>;
> > +                           mipi_dsi_in: endpoint {
> > +                                        remote-endpoint = <&lcdif_mipi_dsi>;
> > +                           };
> > +                    };
> > +                    port@1 {
> > +                           reg = <1>;
> > +                           mipi_dsi_out: endpoint {
> > +                                         remote-endpoint = <&panel_in>;
> > +                           };
> > +                    };
> > +              };
> > +      };
> > --
> > 2.20.1
> >
> 

Cheers and thanks again for having a look!
 -- Guido
