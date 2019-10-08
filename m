Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A58BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEB2217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbfJHHLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:11:13 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58493 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJHHLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:11:13 -0400
Received: from aptenodytes (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E05E0200002;
        Tue,  8 Oct 2019 07:11:09 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:11:09 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     hariprasadKelamhariprasad.kelam@gmail.com
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: sunxi: make use of
 devm_platform_ioremap_resource
Message-ID: <20191008071109.GD23055@aptenodytes>
References: <1570517975-32648-1-git-send-email-hariprasad.kelam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Content-Disposition: inline
In-Reply-To: <1570517975-32648-1-git-send-email-hariprasad.kelam@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 08 Oct 19, 12:29, hariprasadKelamhariprasad.kelam@gmail.com wrote:
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>=20
> fix below issue reported by coccicheck
> drivers/staging//media/sunxi/cedrus/cedrus_hw.c:229:1-10: WARNING: Use
> devm_platform_ioremap_resource for dev -> base

Looks good, thanks!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_hw.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index a942cd9..f19b87c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -146,7 +146,6 @@ static irqreturn_t cedrus_irq(int irq, void *data)
>  int cedrus_hw_probe(struct cedrus_dev *dev)
>  {
>  	const struct cedrus_variant *variant;
> -	struct resource *res;
>  	int irq_dec;
>  	int ret;
> =20
> @@ -225,8 +224,7 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
>  		goto err_sram;
>  	}
> =20
> -	res =3D platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
> -	dev->base =3D devm_ioremap_resource(dev->dev, res);
> +	dev->base =3D devm_platform_ioremap_resource(dev->pdev, 0);
>  	if (IS_ERR(dev->base)) {
>  		dev_err(dev->dev, "Failed to map registers\n");
> =20
> --=20
> 2.7.4
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl2cNo0ACgkQ3cLmz3+f
v9H5sAf8C7Uow7w//L27ktNGLif8j95G9G9t0VsDSaxkt1+mvVKX7sTuLkN70DJ6
RBrq+VmAsmJXfqozopp8eiJ1Rtz+/mp0THke9VwyCyQgiL1VxhUqxCJXV27PG3WZ
UQpHQv4FleeFrCZ7pi2kdH2zxfd0WI/S1lKZgAe9BDwNdpIh+8T7ImHZlkinukab
oMCypnTwYMyjNPmQ2vTDtDtU4xodqPxgOLqHfW1LFdOKyPvP4IvAB95DGo4mAUpi
q5lv+lNpI4YrDrTWx0alDWgV6wYq7VBsw8T9Kns7oPThD5klAri4jjwyoYHSO3kg
urgpt39rFja0auiqwwj5Puko+mlVgA==
=l23+
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
