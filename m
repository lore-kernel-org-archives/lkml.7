Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720EC20880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IQHO4m6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfDOVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:23:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfDOVXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:23:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jhM82pH0z9s55;
        Tue, 16 Apr 2019 07:23:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555363428;
        bh=fpnOuQ+rI9uM/GMu0CnEoy801EHB4y6gD3WyKL2nl7A=;
        h=Date:From:To:Cc:Subject:From;
        b=IQHO4m6t4WlKJ/3x0O/dBU0L9xexzmMJ9858EfIODqz73mA+A0EjGLYsvuNru1PHf
         8PYfJ2sO5MRon2TzR+RzUujiuN4OIW2INFXGW2YCUtaX7qSdrbB34m0YNqM6xciNef
         o/qXwVm8v6Lpn9hh96l3p+WMxxBL1HApHI6+M9icXgWoMkJmzlzpEwqNUUVy+1qxO5
         s/fS3nieJYjznvxPeNbjdOX6rThivoG/D2uPCh00lfrrvZiFd6vg1a2/XbinF+pKlg
         ojLwV3foj5mPbInWQXF8xiY29CePksmKanLACXBFoHG6Tv6t+eatcCR12M8YAVkeB6
         itpeqr9m71qog==
Date:   Tue, 16 Apr 2019 07:23:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the crypto tree
Message-ID: <20190416072342.739863fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ool2hkG9X7ID6towcfBR+ki"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ool2hkG9X7ID6towcfBR+ki
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

In commit

  2e53582d158e ("crypto: mxc-scc - Remove broken driver")

Fixes tag

  Fixes: d293b640ebd ("crypto: mxc-scc - add basic driver for the...")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Ool2hkG9X7ID6towcfBR+ki
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly09l4ACgkQAVBC80lX
0GwNhQf/eBe5yA87ymp4gH6AjgNh8CiDDkmIiUWofYlc5QH3gFzwcsHNTOdyRotd
umzVoJ1fEi7v4tNuDjT5Cae8EAYWLRCZ+C10EsdG4+XqH/3tMS+F0cbyZxY06dYj
ut/oRSYMSmY09pnHJq4MonmgEi0ysIrH+UDtgrssg3zzoiQhropkXOpaki8vp5Ks
/k3zmseS7jwaKWdoUTOo/Z0HRD18j25/dajhXQMeW9Sra2GSL/Ps2+cV9lGKp6FS
k3bN/vIOkkCJb8Cie+LptjBNIjMz1j6K2XK/Q5pNKKxQ5/LfQ224d143s+LgrbBh
P5OcnlXfZ31JwCr7Qf1YTm52gam6mg==
=DAxh
-----END PGP SIGNATURE-----

--Sig_/Ool2hkG9X7ID6towcfBR+ki--
