Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A12C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3465420863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="a3vSsOwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKZUcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:32:22 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZUcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:32:22 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47MwYv2JRlz9sPK;
        Wed, 27 Nov 2019 07:32:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574800339;
        bh=6SNQ3yLGzbsYmtjjfWs7YANdjvfumHmOFLX7dL70xxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a3vSsOwvu4f3uDNGfQRv3sOMsFBCcDSal9VDRIGQtYdRrqx8+bI+r8cb2aiYI4Gs8
         N5lGqIMIw7BbD70cuCVFC1iXVW5036f4loBEhfTvkzJKmVwGxcif72KeRGWSW6lqFE
         9wvCBEzl9d+1yrDSlhHWdxQIKyVePpgNfL6TB5MLLwJ9prhk09ZHTZW8UULceKkikp
         hkb0usdH66Uy1jHflJtIGVa0a0ZRxRnt8ZKSMKM5drvX4K0xEs1HuO18qCXscXqgMX
         /fBTgWULhluMZlr/IqjV1GayyGxg4xBVYzXJQk8U7JReWsUR2I0BGGbauiFhDV+6qP
         olVXh+cDaWJuQ==
Date:   Wed, 27 Nov 2019 07:32:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: linux-next: manual merge of the tpmdd tree with the kbuild tree
Message-ID: <20191127073218.7b7a61fd@canb.auug.org.au>
In-Reply-To: <20191118123944.5fbeec1e@canb.auug.org.au>
References: <20191118123944.5fbeec1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CrMV9egeY=ra5n=o53sslOU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CrMV9egeY=ra5n=o53sslOU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 18 Nov 2019 12:39:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the tpmdd tree got a conflict in:
>=20
>   include/Kbuild
>=20
> between commit:
>=20
>   fcbb8461fd23 ("kbuild: remove header compile test")
>=20
> from the kbuild tree and commit:
>=20
>   47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
>=20
> from the tpmdd tree.
>=20
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CrMV9egeY=ra5n=o53sslOU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3di9IACgkQAVBC80lX
0GyKQQf+MmirTByG3ZmFxEFBdT4ExGVxyw9ZX+hJKKLoOCiTDiuPoPX/cKJSmrr5
tVX7GNkef4dkX42osLeAkepMWPjAy5wVE1KuZWrIuhzb2toEc+GUIwe2zGMPLQUw
vBQdOk0HqM1CwqC6nfLiVV/BO5CrS/IGrW8p/ZAVyxBKEuVxhGGzLvKUqOUGX/Xn
Jiya56y7kkgScfCH4LZDAYPwDjmsOnh68Q2sLZ7TEimxdj7EVDfqxXLPhqj1IteC
EDaXPzs8fvUvFvKgXB4jxxlaQ80tmdK0jHOfey1YNcTINFCyE09Kghe+nLd/5Yvt
e/0VRLaSg7zZOkwsu+omgpubR3a9PQ==
=RWTR
-----END PGP SIGNATURE-----

--Sig_/CrMV9egeY=ra5n=o53sslOU--
