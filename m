Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CAC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD972146E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BHLHADn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfEZKfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 06:35:15 -0400
Received: from ozlabs.org ([203.11.71.1]:59679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfEZKfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 06:35:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Bc1r0WqTz9s9N;
        Sun, 26 May 2019 20:35:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558866912;
        bh=DnNXuT/E0GJRQs92JlY2gE9GN3zCl/CPDbVIrQAH6+8=;
        h=Date:From:To:Cc:Subject:From;
        b=BHLHADn/w8oCn5f9ow/N3YARo80WhrWsmCglxnTNwTnID4Igqf7XXU++IC/kNAz3g
         ZMl4K4W/qdANhu0i/xRO8WCUohVNfHM/c0t347U62vyzGeQiT7/kTnGF4uJzXsvp/5
         cbriVwU0emcnPvS8JIcPVr0h3Zj7egk/QFPIaGwGo98CuhsMT6zjpSRPc04UqjEGun
         M/I0e2XhOBbuzC1i6/GK8KBga64Gi9tno684it8sDUATwAjq9pTTydsNnQwGyMVico
         Ot/5x/VC+15Tm7OVi4lhWD4BfLXDmLfdwmXgjaEMB0p04yGHAvqbcJ6XFeQmT/2vge
         ZIi/bRq8ZjNpg==
Date:   Sun, 26 May 2019 20:35:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: linux-next: Fixes tag needs some work in the clk tree
Message-ID: <20190526203503.174d0d80@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3oRiTfHo_l//pMeWmoC70a3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3oRiTfHo_l//pMeWmoC70a3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b3fddd5b100e ("clk: imx: imx8mm: fix int pll clk gate")

Fixes tag

  Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/3oRiTfHo_l//pMeWmoC70a3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzqa9cACgkQAVBC80lX
0Gy7Pgf/SpxBmyJz4pO5N5hIl98MKbG2oP+938MrCAv1b/I8vQNK7lmDUAA1A8Ue
XzPndx5l0USn1jpXs3AWJIsu2HgXIKuELexzrGwH2JstMmueoT6sMhBXuTiwPMd/
RDe1SEieyiV/5c0yLfbJeJqe8dSdSk2so+3pE6SvvXwXi62hcRyCdaqleanlcldS
1M8/rDIS2BEaXXGRSbN2n+6IsK/IhVaGjGXs6Xp3/XeehEt5jrcK9cfYip2XqlP/
ykvY3OC5T1/ZhatUt6h2pdxWEbuVX3jO6n0vavIlGCR2bf/W399yMqPZ2VkvA9uF
ZAJ7O+yqhNLsbgtXaP5IRlkJN9TYaA==
=1maZ
-----END PGP SIGNATURE-----

--Sig_/3oRiTfHo_l//pMeWmoC70a3--
