Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45343C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CACC2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Po7QBkCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGHXYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:24:17 -0400
Received: from ozlabs.org ([203.11.71.1]:59139 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfGHXYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:24:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jM3K6SG8z9sML;
        Tue,  9 Jul 2019 09:24:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562628254;
        bh=9q2q6GD+GeSgctNwaXh9ysMWCgphNPB4JALj5ThiUWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Po7QBkCzd4bUGYRMyeT/vJ9W+cJmjvPO0ON/dF5J2eTByq2dWufEmRODkP0hpSHhZ
         gQGdikjikeXeWObYRELC8eSRkKaTydAfW5R39ccn+ha6hyzrexzR5eB2ORxYYC16+A
         pauN3RBfHrjc1T9fM/EC9i1hOt6qRxZitXwP4pTJUi8vT99FyuiNgT922McIqsuWZc
         EjYnQnxG4VZav4PqrUSE+vFaO8kcUV0v0orV2/gQDuDzUIm98whdzF41Lmebgjz3FC
         kwj/4RSsh/75zJEOmT7OH3PSRBY0ReDSzEwfYWwVR1mQ+GlfvKojGN2Jm5SSpqMEg7
         LS8mhnONRVSDA==
Date:   Tue, 9 Jul 2019 09:24:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: linux-next: manual merge of the imx-drm tree with the v4l-vdb
 tree
Message-ID: <20190709092412.2e736df3@canb.auug.org.au>
In-Reply-To: <20190617133629.7c276a67@canb.auug.org.au>
References: <20190617133629.7c276a67@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.XcDa6k7BGKAKdTe5Thyp8Z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.XcDa6k7BGKAKdTe5Thyp8Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 17 Jun 2019 13:36:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the imx-drm tree got a conflict in:
>=20
>   drivers/staging/media/imx/imx-ic-prpencvf.c
>=20
> between commits:
>=20
>   6d01b7ff5233 ("media: staging/imx: Switch to sync registration for IPU =
subdevs")
>   34ff38745b16 ("media: staging/imx: Pass device to alloc/free_dma_buf")
>=20
> from the v4l-vdb tree and commit:
>=20
>   f208b26e61df ("gpu: ipu-v3: ipu-ic: Fully describe colorspace conversio=
ns")
>=20
> from the imx-drm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/staging/media/imx/imx-ic-prpencvf.c
> index 82bba68c554e,f2fe3c11c70e..000000000000
> --- a/drivers/staging/media/imx/imx-ic-prpencvf.c
> +++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
> @@@ -460,7 -465,18 +461,18 @@@ static int prp_setup_rotation(struct pr
>   	incc =3D priv->cc[PRPENCVF_SINK_PAD];
>   	outcc =3D vdev->cc;
>  =20
> + 	ret =3D ipu_ic_calc_csc(&csc,
> + 			      infmt->ycbcr_enc, infmt->quantization,
> + 			      incc->cs,
> + 			      outfmt->ycbcr_enc, outfmt->quantization,
> + 			      outcc->cs);
> + 	if (ret) {
> + 		v4l2_err(&ic_priv->sd, "ipu_ic_calc_csc failed, %d\n",
> + 			 ret);
> + 		return ret;
> + 	}
> +=20
>  -	ret =3D imx_media_alloc_dma_buf(priv->md, &priv->rot_buf[0],
>  +	ret =3D imx_media_alloc_dma_buf(ic_priv->ipu_dev, &priv->rot_buf[0],
>   				      outfmt->sizeimage);
>   	if (ret) {
>   		v4l2_err(&ic_priv->sd, "failed to alloc rot_buf[0], %d\n", ret);

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/.XcDa6k7BGKAKdTe5Thyp8Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j0JwACgkQAVBC80lX
0Gwx7wgAnFkLWTK4Nzj4pVtVnsbP0mkhluubP1MIU55Wu/Drdnf01+1WN1i/PBlc
UKQ6IayHRY3A4avngwrwtAdhiDM32dZs1UCFkYmOjyaZKEI9MucKIXh3kF0GLctV
Vra+I+RCF6R0nbqv7SA1esl0NO7pV9tDYXZaOQLD3nH786oI8/wDL3zSStQ35gEf
VLp2g0owysIxEK55jAyH4Pzz8GFZ7o5QG6arTFU3QSq32JKr7NzPbDpKQib6pZQF
wNEDwUUG+yP/eNOAXWEXUQfL5D4GIejSel7nhjuC7iF17Pqrih8dtgurcWo0LU3w
LCIUxRlD4OVYynTgrKNXQ3YjBUgkzA==
=T10t
-----END PGP SIGNATURE-----

--Sig_/.XcDa6k7BGKAKdTe5Thyp8Z--
