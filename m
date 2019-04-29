Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB8C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4EA2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qwffatbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfD2WNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:13:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729418AbfD2WNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:13:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tJpN53Lzz9sB8;
        Tue, 30 Apr 2019 08:13:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556576029;
        bh=JohJsfj3PTYRmS+9/9zJbwJfmi37M2byawEZFQG5jl8=;
        h=Date:From:To:Cc:Subject:From;
        b=qwffatbEmBWPEs/zpyHBqXltw9cJNRgM5G1kUgtzMIxvW91zRrwBZKwF2Rl12fgEd
         nu+yAg0BmycrcIZwE5RQwovT6rso6S27IZWskV+VDMXvSJHY1azOcgq++s91Kl8363
         K+1rgtM9wuAKs/mQmLhcSUpyRLEOJEiWtpXDpT4vs+V4edFcrE1+uhYg5NsnF0Q7uQ
         +zFwIimeSYyE2b3uV724DdZyFYdHpJIw8gJ6aB78On20df7RA/rEHdDvIQeLzCiI4a
         YCj6eD9RgOECaulb7fTIHFiC+H9KxVtovqCWvftdh4ekeW5QroClBzfgPZVZMwrr8L
         w+kYaNKtcdzXw==
Date:   Tue, 30 Apr 2019 08:13:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: manual merge of the rdma-fixes tree with Linus' tree
Message-ID: <20190430081346.3196b60f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aGqEJja6r4eSE9GIBbFg4sy"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aGqEJja6r4eSE9GIBbFg4sy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma-fixes tree got a conflict in:

  drivers/infiniband/core/uverbs_main.c

between commit:

  6a5c5d26c4c6 ("rdma: fix build errors on s390 and MIPS due to bad ZERO_PA=
GE use")

from Linus' tree and commit:

  d79a26b99f5f ("RDMA/uverbs: Fix compilation error on s390 and mips platfo=
rms")

from the rdma-fixes tree.

I fixed it up (I just used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/aGqEJja6r4eSE9GIBbFg4sy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHdxoACgkQAVBC80lX
0GwG3Af/a5q4L1kD5ptbcU8ulRUg1b6T7gFVsjTSYvloLMDOMxABY+duRjRaipTe
FQl2rELZkLkt/7wXWv5NtRJgaBTLQ4Q+zV8liInIsypEOCjK5VWenuPzwxw3bJQ8
WsqEObsNpBKTFJeqxSrgELc/mxHP4sn6Mt/c6silZ0FPodzCl4JSEFwWSm7HNzK/
4SHP672W926uo4woPwUq1oRxmQnk0LHEMyPxJZ48wV/Z3U0F4vGYMfvQeJfYtCrW
fPidonA254Mfg9TxwdOej3h9OZpu+yr7GRXJwfo1gvLn7ggtU4xQD83Cr41rclwf
5FzB5nJ0z1DHrrwaJZfNk7eN4pGH8g==
=oXyz
-----END PGP SIGNATURE-----

--Sig_/aGqEJja6r4eSE9GIBbFg4sy--
