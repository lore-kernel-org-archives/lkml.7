Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE66C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8FB20874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 21:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="B/qRcf5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407039AbfFKVnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:43:52 -0400
Received: from ozlabs.org ([203.11.71.1]:50351 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387764AbfFKVnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:43:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Nk5x1XxRz9s6w;
        Wed, 12 Jun 2019 07:43:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560289430;
        bh=vR5G2PkEdx54l7qTKjqKlDqGmK5wzFj5OnrDN/P1DAA=;
        h=Date:From:To:Cc:Subject:From;
        b=B/qRcf5ePowZm6hnvOO6GZQmDCqkDFYRZqxDOoZNyr2Q1Bsxjd80R0M3vGbSHm4Qr
         SNOy/oVpbRg3nMY48nHJHSJAF0aiM1MF7OFriig5yz/RGGQ5S0Bly8WJ+Z3awZs8Y7
         xTbR9T/eBhZ5Qj2PMgsu0Lu/OJ2mBZkBbtWzvGYytUVH4M9SkDqscs1voLzdSWtnXr
         jyU67ECy8A0ZkN76Mc0V85D6DiQMryPS2tA6D97NTh2O/Ug28mL8pi2O9ANqvUa/hZ
         luhvAilxvQvdPPl45tL+S7mrVFNHPafWwjAqu4tjCP0pSrqrjvVLpHzqanaI4okCpi
         8CrRYQWLJO9NA==
Date:   Wed, 12 Jun 2019 07:43:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: linux-next: Fixes tag needs some work in the drivers-x86 tree
Message-ID: <20190612074348.664fe003@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XREcIEPxcpzFuWZa3Rjbk+J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XREcIEPxcpzFuWZa3Rjbk+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  097d45dd45d8 ("Platform: OLPC: Fix olpc_xo175_ec_cmd() return value")

Fixes tag

  Fixes: commit 0c3d931b3ab9 ("Platform: OLPC: Add XO-1.75 EC driver")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/XREcIEPxcpzFuWZa3Rjbk+J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0AIJQACgkQAVBC80lX
0Gw7RQf/USof1eFTJz4WtQd8DME5BRG4w2g2ZNWjHqAqT4d3n5PIet5uRpXXTHGw
wbBgaWj40OwvaV4k+t1FMJ6t9VxNouLqiH9zQMfYM1ZoKmY2LCTAj7HCWGxF/Jd+
K0fZDAE5NzWc9538BlnGfrEU7vBcw2FC7VKat1RK8YiWKlCKShwuEXy//hcDympU
Q2gXyxDZ75ZZdsNL5KVZ+CqXvIAZs4YR2QXREu2Bi8jOY+Hyah1cuqAXGoGmSPDe
7Hijqo8Owr5V0kFAgD2iYuTe/Y/773402sbTRbrHmMjLsWYLaudNby8jPgCclIJk
3+EWgtx7QbG8Qe4w3y2dDcfJ+AmCrg==
=+EHm
-----END PGP SIGNATURE-----

--Sig_/XREcIEPxcpzFuWZa3Rjbk+J--
