Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B525C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 22:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB5824649
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 22:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nsI3B8/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfFBWXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 18:23:54 -0400
Received: from ozlabs.org ([203.11.71.1]:37353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFBWXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 18:23:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HCQC3mWzz9s4V;
        Mon,  3 Jun 2019 08:23:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559514231;
        bh=3GmzyEWKR6sT0GjlQg3ibQ7graV3HFHeepqykw+PUCk=;
        h=Date:From:To:Cc:Subject:From;
        b=nsI3B8/krcQ/u1cTL5krKUU0Y2VWIhtjyynbNWfB8+fz6g9NWjKGyo03+KXlUohRJ
         tXvcJYqYauh7i1FVeq6KkRB6J1OIig7QXJdJD213aAVk2OzznhvZVRMBFZsGcv2CQy
         1jqT4yv+K62eBHBiljADmkix1UN94Xg35/c5GTiW2e3dEoJL1FIoKkFnwukc3XyT5k
         sQjNYEAPFxMZDGf8qtwrYbPOnolSjBVluTWB7MaSTr+jH8jrQAs7hg3lp6eMHYQTMt
         Gk6mLuqrEggRl2jnnaA9RdlyXNWNLj/1hySuwQNzjxtmwwdfLgwLP1ku/1kI4Tq9Bk
         GentwIGJbdwtQ==
Date:   Mon, 3 Jun 2019 08:23:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: unable to fetch the mvebu tree
Message-ID: <20190603082346.7bd1d7a4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lo5m9qPDu4oiX33meWAzxx2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lo5m9qPDu4oiX33meWAzxx2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Tyring to fetch the mvebu tree
(git://git.infradead.org/linux-mvebu.git#for-next) for the past several
days produces this error message:

fatal: Couldn't find remote ref refs/heads/for-next

--=20
Cheers,
Stephen Rothwell

--Sig_/lo5m9qPDu4oiX33meWAzxx2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0THIACgkQAVBC80lX
0Gwsmgf/V9gzhu05NqlOLJkYaYO9nMmyYG530vlRb7UFezZH/01F88EoDHRkPZyX
/vSJV0KJZIII+hQYMpu0yTN2+RQZekxFgyA2cGrW/hqrtu6t4ZU8iJn7jpIUZx3u
BBKKozRC8CkmUvY1tLA338/ynwqtKilIwDzQBJjxcEF/ACeS7lkOqImkozGDVHiQ
+CKDvBkfMCEqNb4Nj5BWcW1MVlFNUBd+8poHvomGY9H47VgNoxx/qDn5EBXPiICX
lfUInXWb1Hfs5X+ZHF476VgJE7GeHeMFhAXp3bdDtjch9cBhjHCP4PHJ0dQxVIsd
BjNDhSQtBECbo4DapXK7m7A3pOIPEg==
=7xX9
-----END PGP SIGNATURE-----

--Sig_/lo5m9qPDu4oiX33meWAzxx2--
