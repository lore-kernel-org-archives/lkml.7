Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8587C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QNxx3vYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfEWVf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:35:26 -0400
Received: from ozlabs.org ([203.11.71.1]:40067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387709AbfEWVf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:35:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4592px69Swz9sBV;
        Fri, 24 May 2019 07:35:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558647323;
        bh=V9CWqt15qKrQ5lrLuP8s80EOI0H4y2fUjPfVSlouJfY=;
        h=Date:From:To:Cc:Subject:From;
        b=QNxx3vYMTt2Tx7GipxT79cosKK0gjK8nm92guND93K9eYVJATAkMx41hudWPs5tCD
         8QzkH6J48nM+/WU9C/BE2j6gRjSZ+8gDCZzv0rJzHbJMiBBHZyjBdFzhmYoviPIXkO
         XfarsCne2dP27U3wvxI69F6nnbXLuBld4heyqfLY6y7LX4320wLHwoE+JCjlk5PQPw
         4EMQPb2ReL9iSmYJXHO/XZM64v0i5zgq2rKuPXfupEhIdI6KEs2sHk3+7JET4DaMnj
         8+nYNj4yqbUUn7V08Jn1zGW92JjFXoZRB0ZCGPIApblfetjRgp0ct+jLghgw9d0LUW
         TVu4d18jJ2qdQ==
Date:   Fri, 24 May 2019 07:35:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Raju Rangoju <rajur@chelsio.com>
Subject: linux-next: Fixes tag needs some work in the net tree
Message-ID: <20190524073514.3268aca5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kRdE4Ta3LViRT=kTfWkTf8n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kRdE4Ta3LViRT=kTfWkTf8n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b5730061d105 ("cxgb4: offload VLAN flows regardless of VLAN ethtype")

Fixes tag

  Fixes: ad9af3e09c (cxgb4: add tc flower match support for vlan)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/kRdE4Ta3LViRT=kTfWkTf8n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznEhIACgkQAVBC80lX
0GzI1wgAnQDk1wDw/CMHmhlyRTVeKRVfbq7l6LGUlVa5L1RgFYXtsb1QhUt+xJ+z
nxgKtp65pcbZ0SI7PBVTnVa08mCxxeomsW0ghb8aOTu4YCq/Ovvay+QDvX6HDk4g
sZUdqrsbm2/bHypyT1/h/RkLv3TCzWLrYtsUNV5OhQloSiuLm0TljDwU6YcWWbnO
mrcqE9V6khYYKCKvf2SzCJc6VLzxjH+LcKecLKGUSNG9ow+xOlRAYmDwVYjE6k3c
ufO9BSUPQtjuqRcezkxib9Ms8MQSlaJQjA8VchHgc5UNjxcJ6Mh96iKtf4IP5/k8
Hc/b9Mi7tNuUFyXYsB+xyn8Xprenqg==
=/gOf
-----END PGP SIGNATURE-----

--Sig_/kRdE4Ta3LViRT=kTfWkTf8n--
