Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04079C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EF420652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kMeLo9CM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfCEW1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:27:42 -0500
Received: from ozlabs.org ([203.11.71.1]:50667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfCEW1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:27:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44DWjj24mlz9sB3;
        Wed,  6 Mar 2019 09:27:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551824859;
        bh=UReefl31BmoyV2LNteDv7BZkJsQ933ST0NPuNIupmAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMeLo9CMUvSgC3eTCn86mciGoMqGRJL0GNA0JRpCqbtYSp1QQEveG6+sKcLCUL06W
         WnirWRiLCRQNQ1SanNhEzx/Gn7Dj0CFysqHC+qs4LcOCN4EubPCCDbJ2S9CcU/hnWp
         DPWniwQi2izNvDYvUPDs9Ld/aRFKF39K/lxDs5B9A/1TbEN6/uquoscxWHECLLRBjl
         YmCMD8EPOPg3Hho1ekCyyoQ3WvOq+OfB5pI0jzHj61mbJ2SUeyhLONhihOTpIbVT5z
         8ezLLuJg5CqKZAiWMBy3eem49ULLuOe+7RPhN/xYs5xTDLp/9OthyvbT1iH/3rvhs4
         JM6GoZNghNyzA==
Date:   Wed, 6 Mar 2019 09:27:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: linux-next: manual merge of the regulator tree with the arm-soc
 tree
Message-ID: <20190306092714.23cf72d6@canb.auug.org.au>
In-Reply-To: <20190218125627.003fc22c@canb.auug.org.au>
References: <20190218125627.003fc22c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zyDoips50+zG4pgA22y7AE4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zyDoips50+zG4pgA22y7AE4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Feb 2019 12:56:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the regulator tree got a conflict in:
>=20
>   arch/arm/mach-pxa/raumfeld.c
>=20
> between commit:
>=20
>   0f884f8a090e ("ARM: pxa: remove raumfeld board files and defconfig")
>=20
> from the arm-soc tree and commit:
>=20
>   01dc79cd6fe7 ("regulator: fixed/gpio: Pull inversion/OD into gpiolib")
>=20
> from the regulator tree.
>=20
> I fixed it up (the former removed the file, so I did that) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is now a conflict between Linus' tree and the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/zyDoips50+zG4pgA22y7AE4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx+98IACgkQAVBC80lX
0GwSHQf/en4eIkxCGL1kDVBrGK2ANdvzi4G9duJ7LfI8yznBHU0Q6ts91DjdM/gO
UwXwaWgcWpVYZo8o3V3tX6ByZCgJOho8h5MdY+mgRHsiOKjibWy0kXFj37gcKFM8
9JJ52uVe9KstcpvPJF+9aETJBJrkfsOu5fv2yXZfgc6k0fHUfmWfph1coaSKWctD
LczcOqGiTYCXyNw3so082ndI0qnOs4eM9cJ6EwZ8suEPNtTtJe7CeK34cmUGc3o0
uRJRPJ6x5UOgkPmM/2lx7caqI8UTzoVi7bWyN05AyxTRfFWYPhYHk5i5w3w/hbh3
Xb8SasdRsz0LL745TA99USUPgyv2dg==
=TFaY
-----END PGP SIGNATURE-----

--Sig_/zyDoips50+zG4pgA22y7AE4--
