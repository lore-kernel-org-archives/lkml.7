Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B7C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D0D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rowiavIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfGKVfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:35:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44741 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfGKVfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:35:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45l8VF5Vllz9sMQ;
        Fri, 12 Jul 2019 07:35:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562880917;
        bh=Ox806JqLC4KGcGiKtSCTa+hWHfHKXpoAAPVesUdxloE=;
        h=Date:From:To:Cc:Subject:From;
        b=rowiavIFbDxtbIMiuVQuw3gHNrCdCkAM/UWxR3IursQHi3LbfLri7JclNVBc8Lln9
         LA54SckQhCulT4tAYUbtpN9EH/r66mH874yDMZu99Sv1iL24xidLff039xRgZ5oBuJ
         wkLqPh6537GSP/RnKWm0nJZK+3ZIgrYf4yoMERJs7+M3ubIf+2Uyp6ryJOnANWzBLT
         bLtQ+ATu1kg4YUZQXTWrUDXav3K3j4r6sx+ZBsFPD8rAFvzfKlucgegrz2nx4ItIBf
         CNdVdLcYf7lVhH4RJBRRW3soiyVpbZjnl/yQWfHL3Zy83DAxe6EdUoZlZsOger0YfJ
         fBL3n6709dLgw==
Date:   Fri, 12 Jul 2019 07:35:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20190712073511.53bd6665@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W6E50f6AvBoAnPffVgCDwMG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W6E50f6AvBoAnPffVgCDwMG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8f3858763d33 ("nvme: fix NULL deref for fabrics options")

Fixes tag

  Fixes: 958f2a0f8 ("nvme-tcp: set the STABLE_WRITES flag when data digests

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also do not
include blank lines among the tags.

--=20
Cheers,
Stephen Rothwell

--Sig_/W6E50f6AvBoAnPffVgCDwMG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0nq48ACgkQAVBC80lX
0GzNggf/YfwkoBjwGpdYd8/TYPaH2rF6OcwLw3yiqESsb7Z2TtBmUiHgZFhMYrjU
XDd39iA3oqypBPLxn4Qx9HUEHY9y9vEWxU1lhZn50raORg4jWuWRZaGrZFKT4vVq
aiDrrsH0n2CprBQ5m7RV5lLek+RG6FbsMxDEPp1qUg7Jt/GeIxQ41XAj+FG9YMIA
mLxHCyEITlP41Bny9nFFHPXIm+YRFl6XVx8YNQUxY1NPwRBZbNaPPwu+/Uszbb4f
XZniBQZ7dltDdCaatrjrPby3h7gXwTQVIGZprdZ1xCH/t4fSSfASqUTT/GZZV2rK
ZiRc4Q0h4VqmrZmhrkhgCSsKM86crg==
=8IcY
-----END PGP SIGNATURE-----

--Sig_/W6E50f6AvBoAnPffVgCDwMG--
