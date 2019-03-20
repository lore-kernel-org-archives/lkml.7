Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C099C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF54218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IzK+5uCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCTUss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:48:48 -0400
Received: from ozlabs.org ([203.11.71.1]:47917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfCTUss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:48:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Phpj3CZrz9sR2;
        Thu, 21 Mar 2019 07:48:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553114925;
        bh=iUtB2KeUJAfo0L/rqM10Gf3WEmbITgmTpJtu73E3MnQ=;
        h=Date:From:To:Cc:Subject:From;
        b=IzK+5uCK9e99jhlg6uPuuxWC5idIflByij1l2udybqGOpas0stlPe2zT9oLJQA8r8
         HHUrCSOkP/DLdzfm7ilLyaHBdTNQJzAvEiSXLUqf7TeVuyeetW7y5f9GiAV2mdtTlc
         8HV/toqxK61NMlOx9H1P2ACZUR2q43kdl65iwwG+3Ru7bOPV3MD0yh+/XPqi7VOpYT
         P3vqadwzY15K1vTsWHgwrPFTAtWdpmcRuKVO6zXGY87fYrckyVQnPkGvv5i+6drTVA
         nWxVlP0YEKKzN8U5mbOsTKk3meuL0VwcHPDwEvyMKt3ay0Ufvcc3Oxae2xZTurYs1D
         ZjFR/mjaNwcGg==
Date:   Thu, 21 Mar 2019 07:48:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.ibm.com>
Subject: linux-next: Fixes tag needs some work in the hwmon-fixes tree
Message-ID: <20190321074837.455ce23c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ldfzovifLuA+5x5wTb0r.=="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ldfzovifLuA+5x5wTb0r.==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

In commit

  9940b52b73e4 ("hwmon: (occ) Fix power sensor indexing")

Fixes tag

  Fixes: 54076cb ("hwmon (occ): Add sensor attributes and register ...")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ldfzovifLuA+5x5wTb0r.==
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlySpyUACgkQAVBC80lX
0GwdxAgApA07TST/GYz44x6VzeKT86zGIYlCqDnF/vIDd9o/8eiab8lEWtai6HJ2
4gCUSEVA1KLTFnxiQXHdyp1fuSoMRjph0EcF3fl+jMMe8DanSU3ryQ8D7c6WNhGC
Pjdo03oUv6sn3gNYXLAFEgwvFReVhbfqFvZZSUuyljuUAnqaoiA/PY4S0+IdYkiE
QkbagHSSPbsyj31i8jFpBZryU7wGiP6K3MHhXoV8PgD9etLMz1NlTP1CQB8Rxtce
qQarZCn1gIdwbH2LN6ZfVcR7psuPa/VG+1dyNO6xkQvuRQRd64jF27N1Y+UvSrSY
6sIeIAF866X9/ADR3pGcJ5gbN5mt2Q==
=w2kI
-----END PGP SIGNATURE-----

--Sig_/ldfzovifLuA+5x5wTb0r.==--
