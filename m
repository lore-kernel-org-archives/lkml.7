Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CD1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B520679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qQQRutvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfHUSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:15:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:60112 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfHUSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:15:29 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52F6733D;
        Wed, 21 Aug 2019 20:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1566411324;
        bh=Lb+8Te0kG13/aH5BMLnQNZPSRzaVxlUBbel6YfAFews=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQQRutvFEN1Z7mwfR+jmFizZqhQ5bBYEfS7DASqWk9fYaR+9bG7E3j/LgzbaS1LqS
         9OnMZOJU4IhgvZNbe3zKUQ5zsEY9M3EgZI56xiIN/cfjMCMv1kQxIi+CG6QM3yYbiy
         q/YWhnXNN4HeaROIR0qrYIDw+JxqMwD/ovp/v8yU=
Date:   Wed, 21 Aug 2019 21:15:18 +0300
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
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display/bridge: Add binding for NWL
 mipi dsi host controller
Message-ID: <20190821181518.GB26759@pendragon.ideasonboard.com>
References: <cover.1565367567.git.agx@sigxcpu.org>
 <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c906bb6592424acdb1a67447a482e010a113b49.1565367567.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

Thank you for the patch.

On Fri, Aug 09, 2019 at 06:24:22PM +0200, Guido Günther wrote:
> The Northwest Logic MIPI DSI IP core can be found in NXPs i.MX8 SoCs.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../bindings/display/bridge/nwl-dsi.yaml      | 155 ++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> new file mode 100644
> index 000000000000..5ed8bc4a4d18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/nwl-dsi.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/imx-nwl-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Northwest Logic MIPI-DSI on imx SoCs
> +
> +maintainers:
> +  - Guido Gúnther <agx@sigxcpu.org>
> +  - Robert Chiras <robert.chiras@nxp.com>
> +
> +description: |
> +  NWL MIPI-DSI host controller found on i.MX8 platforms. This is a dsi bridge for
> +  the SOCs NWL MIPI-DSI host controller.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: fsl,imx8mq-nwl-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DSI core clock
> +      - description: RX_ESC clock (used in escape mode)
> +      - description: TX_ESC clock (used in escape mode)
> +      - description: PHY_REF clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: rx_esc
> +      - const: tx_esc
> +      - const: phy_ref
> +
> +  phys:
> +    maxItems: 1
> +    description:
> +      A phandle to the phy module representing the DPHY
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  power-domains:
> +    maxItems: 1
> +    description:
> +      A phandle to the power domain
> +
> +  resets:
> +    maxItems: 4
> +    description:
> +      A phandle to the reset controller
> +
> +  reset-names:
> +    items:
> +      - const: byte
> +      - const: dpi
> +      - const: esc
> +      - const: pclk
> +
> +  mux-sel:
> +    maxItems: 1
> +    description:
> +      A phandle to the MUX register set

Did you mean the MUX syscon ? A phandle to a register set sounds a bit
strange.

> +
> +  port:
> +    type: object
> +    description:
> +      A input put or output port node.

s/input put/input/

> +
> +  ports:
> +    type: object
> +    description:
> +      A node containing DSI input & output port nodes with endpoint
> +      definitions as documented in
> +      Documentation/devicetree/bindings/graph.txt.
> +
> +patternProperties:
> +  "^panel@[0-9]+$": true
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8mq-nwl-dsi
> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +        - mux-sel
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +
> +examples:
> + - |
> +
> +   mipi_dsi: mipi_dsi@30a00000 {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +              compatible = "fsl,imx8mq-nwl-dsi";
> +              reg = <0x30A00000 0x300>;
> +              clocks = <&clk 163>, <&clk 244>, <&clk 245>, <&clk 164>;
> +              clock-names = "core", "rx_esc", "tx_esc", "phy_ref";
> +              interrupts = <0 34 4>;
> +              power-domains = <&pgc_mipi>;
> +              resets = <&src 0>, <&src 1>, <&src 2>, <&src 3>;
> +              reset-names = "byte", "dpi", "esc", "pclk";
> +              mux-sel = <&iomuxc_gpr>;
> +              phys = <&dphy>;
> +              phy-names = "dphy";
> +
> +              panel@0 {
> +                      compatible = "...";
> +                      port@0 {
> +                           panel_in: endpoint {
> +                                     remote-endpoint = <&mipi_dsi_out>;
> +                           };
> +                      };
> +              };
> +
> +              ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    port@0 {
> +                           reg = <0>;
> +                           mipi_dsi_in: endpoint {
> +                                        remote-endpoint = <&lcdif_mipi_dsi>;
> +                           };
> +                    };
> +                    port@1 {
> +                           reg = <1>;
> +                           mipi_dsi_out: endpoint {
> +                                         remote-endpoint = <&panel_in>;
> +                           };
> +                    };
> +              };
> +      };

-- 
Regards,

Laurent Pinchart
