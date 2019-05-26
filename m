Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8F6C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B38521707
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfEZSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 14:22:33 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50465 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfEZSWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 14:22:33 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E0DAAFF803;
        Sun, 26 May 2019 18:22:20 +0000 (UTC)
Date:   Sun, 26 May 2019 20:22:20 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190526182220.hgajlcyssujjkmiu@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="psc5odxto6fmnb22"
Content-Disposition: inline
In-Reply-To: <20190525162323.20216-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--psc5odxto6fmnb22
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:23:17PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a SPDIF controller with an increase of the fifo
> size and a sligher difference in memory mapping compare to H3/A64.
>
> This make it not compatible with the previous generation.
>
> Introduce a specific bindings for H6 SoC.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.tx=
t b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> index 0c64a209c2e9..c0fbb50a4df9 100644
> --- a/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> +++ b/Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
> @@ -7,10 +7,11 @@ For now only playback is supported.
>
>  Required properties:
>
> -  - compatible		: should be one of the following:
> +  - compatible		: Should be one of the following:
>      - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
>      - "allwinner,sun6i-a31-spdif": for the Allwinner A31 SoC
>      - "allwinner,sun8i-h3-spdif": for the Allwinner H3 SoC
> +    - "allwinner,sun50i-h6-spdif": for the allwinner H6 SoC

This won't apply anymore on top of next, we've moved to a YAML
schemas.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--psc5odxto6fmnb22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrZXAAKCRDj7w1vZxhR
xehgAQDOcuI0MFI4WlSZ6gB352Ad8vsUL9N1MElpyvk09ZwjRQEAt9hBwX5dJWpV
oqCVDFu0/sZMMNzIZydtd7mLfyUf8AU=
=Vygo
-----END PGP SIGNATURE-----

--psc5odxto6fmnb22--
