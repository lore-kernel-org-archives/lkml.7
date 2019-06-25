Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55733C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F5C20665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFYHzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:55:49 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35659 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfFYHzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:55:48 -0400
X-Originating-IP: 90.88.16.156
Received: from localhost (aaubervilliers-681-1-41-156.w90-88.abo.wanadoo.fr [90.88.16.156])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0484C20007;
        Tue, 25 Jun 2019 07:55:42 +0000 (UTC)
Date:   Tue, 25 Jun 2019 09:55:42 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 06/15] dt-bindings: display: Convert dlc,dlc0700yzg-1
 panel to DT schema
Message-ID: <20190625075542.u5kzex4cbrcss5ga@flea>
References: <20190624215649.8939-1-robh@kernel.org>
 <20190624215649.8939-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="frjixve4rb2lda6m"
Content-Disposition: inline
In-Reply-To: <20190624215649.8939-7-robh@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frjixve4rb2lda6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jun 24, 2019 at 03:56:40PM -0600, Rob Herring wrote:
> Convert the dlc,dlc0700yzg-1 panel binding to DT schema.
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/panel/dlc,dlc0700yzg-1.txt        | 13 ---------
>  .../display/panel/dlc,dlc0700yzg-1.yaml       | 28 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
> deleted file mode 100644
> index bf06bb025b08..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.txt
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
> -
> -Required properties:
> -- compatible: should be "dlc,dlc0700yzg-1"
> -- power-supply: See simple-panel.txt
> -
> -Optional properties:
> -- reset-gpios: See panel-common.txt
> -- enable-gpios: See simple-panel.txt
> -- backlight: See simple-panel.txt
> -
> -This binding is compatible with the simple-panel binding, which is specified
> -in simple-panel.txt in this directory.
> diff --git a/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> new file mode 100644
> index 000000000000..1b0b63d46f3e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/dlc,dlc0700yzg-1.yaml
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/dlc,dlc0700yzg-1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DLC Display Co. DLC0700YZG-1 7.0" WSVGA TFT LCD panel
> +
> +maintainers:
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: dlc,dlc0700yzg-1
> +
> +  reset-gpios: true
> +  enable-gpios: true
> +  backlight: true

Do we need to list them?

Since we don't have additionalItems, it doesn't really change anything
since it will be validated by panel-common.

Either way, it should be consistent between your patches, and the
previous patches in this series didn't list all the properties in the
binding.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--frjixve4rb2lda6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRHTfgAKCRDj7w1vZxhR
xckbAP9haADI6iVzGhwqdxZYMaptx5O2GF8fzxwrKHZAZdAcJwEA3R3Tmk1C/okO
mASJ6FAiJiVOZxzo24B0UCtOmozocA0=
=EraD
-----END PGP SIGNATURE-----

--frjixve4rb2lda6m--
