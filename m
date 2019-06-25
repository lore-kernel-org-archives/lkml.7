Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7ABC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD0220883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfFYH6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:58:10 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:55419 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfFYH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:58:08 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 34B78FF810;
        Tue, 25 Jun 2019 07:57:58 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:57:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: Re: [PATCH v2 09/15] dt-bindings: display: Convert
 tfc,s9700rtwv43tr-01b panel to DT schema
Message-ID: <20190625075757.hmszypzfp6uoch4e@flea>
References: <20190624215649.8939-1-robh@kernel.org>
 <20190624215649.8939-10-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6oswsdiie6i3dzo4"
Content-Disposition: inline
In-Reply-To: <20190624215649.8939-10-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6oswsdiie6i3dzo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2019 at 03:56:43PM -0600, Rob Herring wrote:
> Convert the tfc,s9700rtwv43tr-01b panel binding to DT schema.
>
> Cc: Heiko Stuebner <heiko.stuebner@bq.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/panel/tfc,s9700rtwv43tr-01b.txt   | 15 ----------
>  .../display/panel/tfc,s9700rtwv43tr-01b.yaml  | 30 +++++++++++++++++++
>  2 files changed, 30 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
> deleted file mode 100644
> index dfb572f085eb..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with
> -resistive touch
> -
> -The panel is found on TI AM335x-evm.
> -
> -Required properties:
> -- compatible: should be "tfc,s9700rtwv43tr-01b"
> -- power-supply: See panel-common.txt
> -
> -Optional properties:
> -- enable-gpios: GPIO pin to enable or disable the panel, if there is one
> -- backlight: phandle of the backlight device attached to the panel
> -
> -This binding is compatible with the simple-panel binding, which is specified
> -in simple-panel.txt in this directory.
> diff --git a/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
> new file mode 100644
> index 000000000000..614f4a8d8403
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/tfc,s9700rtwv43tr-01b.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/tfc,s9700rtwv43tr-01b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TFC S9700RTWV43TR-01B 7" Three Five Corp 800x480 LCD panel with resistive touch
> +
> +maintainers:
> +  - Jyri Sarha <jsarha@ti.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |+
> +  The panel is found on TI AM335x-evm.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: tfc,s9700rtwv43tr-01b
> +
> +  enable-gpios: true
> +  backlight: true

There's the same remark than on patch 6. Once figured out,
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6oswsdiie6i3dzo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHUBQAKCRDj7w1vZxhR
xSecAQDqKErYh7aZkwXVNAT5hV+bceLec0CBY2P1sXgUXMVl2QEAiZkB70zuoLHW
mVBhETT1uXuxRYOs/+Qq9uTmPvvCigI=
=LEEZ
-----END PGP SIGNATURE-----

--6oswsdiie6i3dzo4--
