Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A768C606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7275920693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XTgArhZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfGHXuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:50:12 -0400
Received: from ozlabs.org ([203.11.71.1]:48155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfGHXuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:50:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMdC1856z9s7T;
        Tue,  9 Jul 2019 09:50:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562629807;
        bh=eoAHNvh4V/wTwBJy6TZa1lDcIu19bw0Ljm1X6NPZZQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XTgArhZhm6XEijTZ3WAEu2bFQYk/WlyiemnNGv0J+o5c/JY4qNWeiM++QSJW8f+Cj
         97scMo7Hd9dD8si/hwX5kJm7BZyFsG8idpFVJDAQjnlkqgBz7DiZ1XhjFbQZLpzmj0
         8HPzlLIcLABOfoQ1a5mEfI5RYL1nBWnVzAl9sz04e1IO5v4BEknf3Xf+fGYa8uNf1+
         scSPCFEiQeZVRayf2K8ZcRqlr7eFY7gyZMzY0WrIRYJe89BeZXxqRLoXi894ejmr7v
         fZhzYNoTAaUYivX8A1grhNulgdoHl1Npd1yQqhMOnESuKSG4vV9SeFN6CmCp876hBx
         D4SNwAGQ8FIQw==
Date:   Tue, 9 Jul 2019 09:50:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 char-misc.current tree
Message-ID: <20190709095005.32bbf42d@canb.auug.org.au>
In-Reply-To: <20190620111128.7599af5a@canb.auug.org.au>
References: <20190620111128.7599af5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cyJYvR=/CL.oAcOamLJMdT1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cyJYvR=/CL.oAcOamLJMdT1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jun 2019 11:11:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the jc_docs tree got a conflict in:
>=20
>   Documentation/fb/fbcon.rst
>=20
> between commit:
>=20
>   fce677d7e8f0 ("docs: fb: Add TER16x32 to the available font names")
>=20
> from the char-misc.current tree and commit:
>=20
>   ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
>=20
> from the jc_docs tree.
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
> diff --cc Documentation/fb/fbcon.rst
> index 5a865437b33f,cfb9f7c38f18..000000000000
> --- a/Documentation/fb/fbcon.rst
> +++ b/Documentation/fb/fbcon.rst
> @@@ -77,12 -80,12 +80,12 @@@ C. Boot option
>  =20
>   1. fbcon=3Dfont:<name>
>  =20
> -         Select the initial font to use. The value 'name' can be any of =
the
> -         compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
> -         PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VG=
A8x8.
> + 	Select the initial font to use. The value 'name' can be any of the
> + 	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
>  -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
> ++	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
>  =20
>   	Note, not all drivers can handle font with widths not divisible by 8,
> -         such as vga16fb.
> + 	such as vga16fb.
>  =20
>   2. fbcon=3Dscrollback:<value>[k]
>  =20

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

This is now a conflict between the jc_docs tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/cyJYvR=/CL.oAcOamLJMdT1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j1q0ACgkQAVBC80lX
0GxQSggAhfamN+W25THsw1baxDoOm/eQaObLh1ZWak5sLHOWNTd5MuqCY5CJ7ACM
7OOvBXbtEjUYLqJRN2ov9JgWkzMG3ajapqH4HI6uHW81O64A4oN9PWvCV19lKBf/
jRmVPMHnJi2lqzFin1P8UilnGl5jFKyKYzl6lRH4+O5FpWZfGpMxSdsYt/Ewm7SJ
vmxXkHumoOPWTaxPbueQIYK2yQ2Ked31pAG51WNNTnfnrSymh6osEuClM4m0mWZy
dkI2lVuQpYBIAcN3WpQODGGNqJRd2jXukHZdAZ5LA2+iCEw0TwE1oouCTATLwg5x
Tlu5evUMVNin1/csL1xt4c8DkbW+lQ==
=9ZWx
-----END PGP SIGNATURE-----

--Sig_/cyJYvR=/CL.oAcOamLJMdT1--
