Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434FC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25F22075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 18:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfEZSYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 14:24:21 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51667 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfEZSYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 14:24:21 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 5B9BA200009;
        Sun, 26 May 2019 18:24:11 +0000 (UTC)
Date:   Sun, 26 May 2019 20:24:10 +0200
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Message-ID: <20190526182410.soqb6bne6w66d5j6@flea>
References: <20190525162323.20216-1-peron.clem@gmail.com>
 <20190525162323.20216-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncwtv45aqoqucxoa"
Content-Disposition: inline
In-Reply-To: <20190525162323.20216-4-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ncwtv45aqoqucxoa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2019 at 06:23:19PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a different bit to flush the TX FIFO.
>
> Add a quirks to prepare introduction of H6 SoC.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
> index b6c66a62e915..8317bbee0712 100644
> --- a/sound/soc/sunxi/sun4i-spdif.c
> +++ b/sound/soc/sunxi/sun4i-spdif.c
> @@ -166,10 +166,12 @@
>   *
>   * @reg_dac_tx_data: TX FIFO offset for DMA config.
>   * @has_reset: SoC needs reset deasserted.
> + * @reg_fctl_ftx: TX FIFO flush bitmask.

It's a bit weird to use the same prefix for a register offset
(reg_dac_tx_data) and a value (reg_fctl_ftx).

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ncwtv45aqoqucxoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOrZygAKCRDj7w1vZxhR
xX2iAP4vmqh1nSGLNbrJR8v0vBh2+l0fQX6kqx83+rzmZQkZAwEA9wYOzTE6aQsj
ncPb9kzAxB6nwlo5NuAAcwZBIUQ9rA4=
=uFpz
-----END PGP SIGNATURE-----

--ncwtv45aqoqucxoa--
