Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49654C282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F019259BC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C/O4aVKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFCAwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 20:52:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57929 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCAwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 20:52:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HGjp5W4zz9s1c;
        Mon,  3 Jun 2019 10:52:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559523151;
        bh=JgROwtu0J3Be8b1ebo2VtaBP+IwQ0o2cMa1dIPP2Ylg=;
        h=Date:From:To:Cc:Subject:From;
        b=C/O4aVKeJqE555m34Ij8HK82n8s0I37h2WgpxcDbtJLduUjwV3xW9qFQi8y6gCh76
         iv11naROWYgq9FJJqSqH8IK8aQJTYikN/y5D9/M8U4ipNTGroRButdlkxX8FIeSAse
         IqelpiunbL1I1Vf/gBi6aKPG8/h1rMAsDtpxbHBswFjxQ9+Vxo1Aw5QIZ2Ee8+jmgy
         M1GgSpRNQrJp4GCYgmggJUYebScNBMwc1G+1WXOnfkek5LLv9JB/4GU/WmSY3NDTdw
         xirioVdjJaR9sS1Q167IoJNBVxNBUO8v2RFTRUCsk77fte/koHXGKB+AKsN2BZUmOZ
         mvECKUp0EUAKA==
Date:   Mon, 3 Jun 2019 10:52:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>
Subject: linux-next: manual merge of the crypto tree with Linus' tree
Message-ID: <20190603105221.44e5bf16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P7kxKd8cxCDnKvEUNQEvqgt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P7kxKd8cxCDnKvEUNQEvqgt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

Today's linux-next merge of the crypto tree got a conflict in:

  crypto/crypto_wq.c

between commit:

  2874c5fd2842 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 152")

from Linus' tree and commit:

  3e56e168638b ("crypto: cryptd - move kcrypto_wq into cryptd")

from the crypto tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/P7kxKd8cxCDnKvEUNQEvqgt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz0b0UACgkQAVBC80lX
0GyJFAf8CMAi51jWQxhk6UgyFU3r5H5fjO3psXVEwcEFrkYxf6jKobG5mh4+xulm
+V3QMHO/lx3qkAfm3EkeAWtJ7U2YIrZpmVjbWcFvZ2QHqOkXbehTtWLj8ZDF/ATp
8Hnwg3mu8636DzCsGiMQ2pBQhW8uc0j57YAYqN+xdi2QjnVpQqg6Bla/u5lzXhnc
VpnqY4jAzExMMJe1T9Ofl2aYNuvYhVskcmyfPG276INeQF11ZD6NgOh5UuBObvCH
h3nCZe4uOI4V9KiNtquPlKHOdKWk4QsX6h15+z6YrkHIT0oPtczJGaIuRa1wb1Qy
qmCr0SQ1lAH2yTGVK+TNH73+muaziA==
=KRyQ
-----END PGP SIGNATURE-----

--Sig_/P7kxKd8cxCDnKvEUNQEvqgt--
