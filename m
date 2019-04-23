Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEE2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D87208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DiJXLQG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDWVZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:25:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfDWVZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:25:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pc1j6QKZz9sNB;
        Wed, 24 Apr 2019 07:25:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556054746;
        bh=ZKyQBLm2ViqH5pwhb6BMs4xbFdM1ouY15P3rQ807ly8=;
        h=Date:From:To:Cc:Subject:From;
        b=DiJXLQG1gF3UU1VoDXNlHErr9NiB65m4b0yJw9E8N5e9MVjWYOJu78zmouxtQoFWV
         LZrEYscYZG/r76mbC8p/csc579jcQBoF92CsMSBmCSL3Hu2jPrhVyMCTtq6dVnYCuD
         6mddqqJGPIKG3ripuuyAQI3feeKFy9YF8+UU4gJsVDW8/y2+SZIT3D7jc6HpRTWvzi
         nFbOSLGfPOgR8WPAwqIo3VJcaSmpFVCS2GtgV3gnQK+RyD12BwilZWz30gVKOuJRmK
         Xi3a7GjwYs4hJK0nffvVQMHq00SsYxMzRf4DQOthOQCupEjpIPy2pZJClbwGzkRaGp
         7I255dQq2jBtg==
Date:   Wed, 24 Apr 2019 07:25:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: linux-next: Fixes tag needs some work in the rockchip tree
Message-ID: <20190424072539.51aa27e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bb1/XjE._+6r=GsN++GsiZ="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bb1/XjE._+6r=GsN++GsiZ=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

In commit

  89c1f66ae88a ("arm64: dts: rockchip: fix IO domain voltage setting of API=
O5 on rockpro64")

Fixes tag

  Fixes: e4f3fb4909 ("arm64: dts: rockchip: add initial dts support for Roc=
kpro64")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Bb1/XjE._+6r=GsN++GsiZ=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/gtMACgkQAVBC80lX
0GwZzwf/bm/Nd0w/H4mBDMp1ghoQwah0rhbVWDAQ5ZNLVohxbHPrh32BepEYJva4
ZYr0i+JGWAOEBMkFCzB94Q+tk0qgxXAt+nc4kzrX+iyq8UAYC6NdnvhNolRBrjig
Ap1uKnlN4dRO2LUEOQAscvV72hQtdLTJdvbbA0iBuXvMvlgqdCB/qF2rQC4CgpRj
PI9mTJHVpf2aZmwCp8oN38bGn/7m5soZz2shy3i7tWPlW2Py4hJIILjB9TuWCFw4
gqpr3axTZ4mhUH7QRneVA6GaKyvwfMUlDuDWLS46euhrux+RihOYdSiDUkCyrOBK
ZobPRF2GTfMiesPR8/Q5WJ7KNrv20g==
=nOLL
-----END PGP SIGNATURE-----

--Sig_/Bb1/XjE._+6r=GsN++GsiZ=--
