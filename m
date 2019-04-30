Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CD2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39312177B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iV5EvBjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfD3K7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:59:44 -0400
Received: from ozlabs.org ([203.11.71.1]:43365 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfD3K7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:59:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tdp5638Pz9s3Z;
        Tue, 30 Apr 2019 20:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556621981;
        bh=blTdW5TEDppyIUbFp6sLUFFYrQtH+ZJJ2xzzzTVvEpM=;
        h=Date:From:To:Cc:Subject:From;
        b=iV5EvBjxU9RtrqqPM0BjwhrYbSfw42IB2EdOqB1N7/Ao2DBFX2nBccJeZ0g2PkU5X
         GbG89ou/hEXp5VVYEWjirHSp+k7m09Mrhi+9KCbX8bRXrP9MTDJfIqR23yiXNOmmdE
         umYUkjDWxCzKK6TeyckgFXVYvRwdygV9Ejt6p9l3Ojp50CUeq91vegBlUZxowS7V3U
         l7+XKO5UZbd4tUg0vKvA3Q0qGv2lp2VqZVwdwKwMK19OKFiEDMnOIN5Zv0cQjTlfXZ
         S4Dr4xRmwgWPZOJ5qPWidu0v2DVYbDtGLKkDv2QUvNzfLOdkbnirCB3RQk5S59pOT9
         EPGbugX5Wg6Ow==
Date:   Tue, 30 Apr 2019 20:59:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: linux-next: Fixes tags need some work in the kvm-ppc tree
Message-ID: <20190430205940.299f9a9f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=n2HWzeff/3hG+TOJTOh5Kp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=n2HWzeff/3hG+TOJTOh5Kp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

In commit

  2001825efcea ("KVM: PPC: Book3S HV: Avoid lockdep debugging in TCE realmo=
de handlers")

Fixes tag

  Fixes: d3695aa4f452 ("KVM: PPC: Add support for multiple-TCE hcalls", 201=
6-02-15)

has these problem(s):

  - the date at the end of the fixes tag is unexpected

In commit

  3309bec85e60 ("KVM: PPC: Book3S HV: Fix lockdep warning when entering the=
 guest")

Fixes tag

  Fixes: 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing for si=
gnals on guest entry", 2017-06-26)

has these problem(s):

  - the date at the end of the fixes tag is unexpected

In commit

  345077c8e172 ("KVM: PPC: Book3S: Protect memslots while validating user a=
ddress")

Fixes tag

  Fixes: 42de7b9e2167 ("KVM: PPC: Validate TCEs against preregistered memor=
y page sizes", 2018-09-10)

has these problem(s):

  - the date at the end of the fixes tag is unexpected

Plese just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/=n2HWzeff/3hG+TOJTOh5Kp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzIKpwACgkQAVBC80lX
0Gwp9Af+Ni1gDcCHo8rt5XN0NMkxPuKZxJCRjAaU49Dxhd+pJfHdzgp+GbBUxnxM
GT4GJade7edtJQTZDHYU1qJJFIrJYs1aoE/msextT3T/S7lVBG6XwG1HybMFG1X9
0nfqPxI7XrsVga4gynVM7yVU+JlCUipfo8myIjO3e4CF29gRHjDtmhHlXF9DopAd
JGOcfPNZnqFRExw4dewrRkWXBaAED1EFwYXK50g/+lyuKaHQ+6NFQHs6uxXdQgle
K03YQ9pFZ0JHD3Z/ofT2da0XoGO4n22tUhGQDcy47pdmi/t/dvEA4W0lY2hrb76O
UfjtV7FRtiW/yv9zd8cukpjFK/bI2g==
=PvFq
-----END PGP SIGNATURE-----

--Sig_/=n2HWzeff/3hG+TOJTOh5Kp--
