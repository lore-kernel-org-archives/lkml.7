Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD0C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A9C20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 05:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kNgsyP5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDIFWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:22:30 -0400
Received: from ozlabs.org ([203.11.71.1]:43343 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfDIFWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 01:22:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dbJg28m2z9sP8;
        Tue,  9 Apr 2019 15:22:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554787347;
        bh=vBFjbUqi5RIaGmyq2uqRMxwyKXnovxOP+Vy5X835MiA=;
        h=Date:From:To:Cc:Subject:From;
        b=kNgsyP5JNrp7BcVLKL6mfi2QJJM1BGof8kdKwM0sZuCGrgTWLNVYNhxVtQ6SSSoeK
         JsFSOJ+QbY7P4vU7SRyXDOPz1GT21kwP9h4Bj1MQQKraU1iFJON/FOgyr9Y4SPTPyQ
         MJUjHI263L8f60SG40l1Ei/TbfCPnxJB2ePRKqra48uowoEZnQWyDEL5fS19lqMTp4
         pJ/iony09o4l9YZHX8jsa74YD1vECuSsSY4Lh3ilBkHBMh4j4PoK+vB+XFF6ZTB4IT
         j21EGI+BCzw1TJImVuy3DX1wW55I3dEq9mrFMLP7/nRtoOHyKZt6qXlBaGGQdTIwvi
         eFzfjzf+mBMuQ==
Date:   Tue, 9 Apr 2019 15:22:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keerthy <j-keerthy@ti.com>
Subject: linux-next: manual merge of the rtc tree with the omap tree
Message-ID: <20190409152226.5fecccd1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IIXaJ5r=mv4x_tHbswY/UGJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IIXaJ5r=mv4x_tHbswY/UGJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rtc tree got a conflict in:

  drivers/rtc/rtc-omap.c

between commit:

  6256f7f7f217 ("rtc: OMAP: Add support for rtc-only mode")

from the omap tree and commit:

  35118b7a4ea0 ("rtc: omap: let the core handle range")

from the rtc tree.

I fixed it up (I used the latter resolution around tm2bcd() changes) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/IIXaJ5r=mv4x_tHbswY/UGJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlysLBIACgkQAVBC80lX
0GxMygf/cmV0uz/fSC/lh0Ddj4K3RTH8cg9alDqqG08JNV0EV/NdlbzLC1RxViPS
yrDIjDMtvMlyEofVBtxhGntPaphGMV1lKQGwyGWqF+jEk8qvL4sJGD+G1oraN8/H
mHaq/Epiaklnwl4iZK1euWH9t8jYUQMWUlBUh0kgp0INd7qvgbJxiZqGKMC7VT97
bcwhZOn8Z2APmdtZMxrhAZ02fac7t26V3K8WgdI340MLlrj35dbzVuPQnDjqbpJT
4P3kJA7PJwoRN++kXk9aGByYlcY5kHHvLDkkYwPaaP5SxZUehqgzDMf/KdbFbZEa
nRhb63hl2NnMSisjYbzl+tdfuiQXCQ==
=w1Am
-----END PGP SIGNATURE-----

--Sig_/IIXaJ5r=mv4x_tHbswY/UGJ--
