Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CDEC28D1C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A81720673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFFISH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:18:07 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58092 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfFFISH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:18:07 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id AC74B3A136A;
        Thu,  6 Jun 2019 07:40:53 +0000 (UTC)
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 17C8310000E;
        Thu,  6 Jun 2019 07:40:36 +0000 (UTC)
Date:   Thu, 6 Jun 2019 09:40:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will.deacon@arm.com, olof@lixom.net, jagan@amarulasolutions.com,
        horms+renesas@verge.net.au, bjorn.andersson@linaro.org,
        leonard.crestez@nxp.com, dinguyen@kernel.org,
        enric.balletbo@collabora.com, aisheng.dong@nxp.com,
        abel.vesa@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/4] dt-bindings: imx: Add clock binding doc for
 i.MX8MN
Message-ID: <20190606074036.vx2smtauiwxy6wzx@flea>
References: <20190606013323.3392-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbx5fpk47vlzcrms"
Content-Disposition: inline
In-Reply-To: <20190606013323.3392-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbx5fpk47vlzcrms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 06, 2019 at 09:33:20AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Add the clock binding doc for i.MX8MN.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- switch binding doc from .txt to .yaml.
> ---
>  .../devicetree/bindings/clock/imx8mn-clock.yaml    | 115 +++++++++++
>  include/dt-bindings/clock/imx8mn-clock.h           | 215 +++++++++++++++++++++
>  2 files changed, 330 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
>  create mode 100644 include/dt-bindings/clock/imx8mn-clock.h
>
> diff --git a/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> new file mode 100644
> index 0000000..8cb8fcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
> @@ -0,0 +1,115 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/imx8mn-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8M Nano Clock Control Module Binding
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +description: |
> +  NXP i.MX8M Nano clock control module is an integrated clock controller, which
> +  generates and supplies to all modules.
> +
> +  This binding uses common clock bindings
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

Which part exactly are you using?

I'm not sure it's worth referring to. Any provider property should be
listed here, and the consumer properties are already checked.

> +properties:
> +  compatible:
> +    const: fsl,imx8mn-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: 32k osc
> +      - description: 24m osc
> +      - description: ext1 clock input
> +      - description: ext2 clock input
> +      - description: ext3 clock input
> +      - description: ext4 clock input
> +
> +  clock-names:
> +    items:
> +      - const: osc_32k
> +      - const: osc_24m
> +      - const: clk_ext1
> +      - const: clk_ext2
> +      - const: clk_ext3
> +      - const: clk_ext4
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    clk: clock-controller@30380000 {
> +        compatible = "fsl,imx8mn-ccm";
> +        reg = <0x0 0x30380000 0x0 0x10000>;
> +        #clock-cells = <1>;
> +        clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>,
> +                 <&clk_ext2>, <&clk_ext3>, <&clk_ext4>;
> +        clock-names = "osc_32k", "osc_24m", "clk_ext1",
> +                      "clk_ext2", "clk_ext3", "clk_ext4";
> +    };
> +
> +  # Required external clocks for Clock Control Module node:
> +  - |
> +    osc_32k: clock-osc-32k {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <32768>;
> +	clock-output-names = "osc_32k";
> +    };
> +
> +    osc_24m: clock-osc-24m {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <24000000>;
> +        clock-output-names = "osc_24m";
> +    };
> +
> +    clk_ext1: clock-ext1 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <133000000>;
> +        clock-output-names = "clk_ext1";
> +    };
> +
> +    clk_ext2: clock-ext2 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <133000000>;
> +        clock-output-names = "clk_ext2";
> +    };
> +
> +    clk_ext3: clock-ext3 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency = <133000000>;
> +        clock-output-names = "clk_ext3";
> +    };
> +
> +    clk_ext4: clock-ext4 {
> +        compatible = "fixed-clock";
> +        #clock-cells = <0>;
> +        clock-frequency= <133000000>;
> +        clock-output-names = "clk_ext4";
> +    };
> +
> +  # The clock consumer should specify the desired clock by having the clock
> +  # ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8mn-clock.h
> +  # for the full list of i.MX8M Nano clock IDs.

I guess this could be part of the clock-cells description.

Once fixed,
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbx5fpk47vlzcrms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPjDdAAKCRDj7w1vZxhR
xQf4AQDGmVlx49YWe4vIu1dehv4zttFw3oRaIsMiDSi4vzwyMQEA+e7hg+RgrL4i
6aPykXgdE5sTJox+CRpk+KGv3Ovk3AU=
=kpoe
-----END PGP SIGNATURE-----

--lbx5fpk47vlzcrms--
