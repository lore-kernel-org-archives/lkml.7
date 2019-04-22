Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE1820693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QZJaTnPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfDVU5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:57:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfDVU5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:57:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44nzRP0qKMz9s3Z;
        Tue, 23 Apr 2019 06:57:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555966641;
        bh=O8xO8xOzqvGpu6E+PtD1zfZFqznO9aWjyhZ6DUIbhNs=;
        h=Date:From:To:Cc:Subject:From;
        b=QZJaTnPZr/YhNvo2LX7c69tWyeDC9ewHiW33ZCr42LL1JzOk54JiQNGGzKoBIkLuS
         3Qn6CA94QITNh7ZYtp4gnQOW3XFMlVvI+hZ+LLXHInT/CBXJEtuXQWQ5hVmRlA1/2e
         qBS3CUO0A9pW/njjsVVDYJBrJW62BiQ6X9gjYFh211p7CIrHYKB35x6YUf55syRQqN
         P2OKJAj5uEwvx3JSUfq9Ac3ThIK8xPfi3l/2qAmw91SKXYgzGIerl6gJEseXggvm/w
         vuOFWT9ozzUSE+8i7LyOu4b/AsGb2MGzmFYtZvuAR1Tqaqggttf1P4heokBcbXRI/O
         jp7tER6UClrAg==
Date:   Tue, 23 Apr 2019 06:57:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: linux-next: Fixes tag needs some work in the rdma-fixes tree
Message-ID: <20190423065712.7d0556b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ediXCgdp=3VX2QzEgGD/S41"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ediXCgdp=3VX2QzEgGD/S41
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5efda3b6b122 ("IB/mlx5: Fix scatter to CQE in DCT QP creation")

Fixes tag

  Fixes: 5d6ff1babe ("IB/mlx5: Support scatter to CQE for DC transport type=
")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/ediXCgdp=3VX2QzEgGD/S41
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+KqgACgkQAVBC80lX
0GwQxAf+JJ5wkBp7Q6O3j/mBPifO34ghfG60lN666idz/o6ToG4fxKvVnaviYD+Z
CWfxxQksw/2dvWZl1M9jkb1pU5bBNZou8LWc3u0/Z0417wCdZvWZjC8Zsuu+PORC
5H+BwZvCH5fLjN336Faek0UyBbMuFtK8s7whbiJq64X8nh0SmFEwcqbtIEnBC6Fp
3fECQY0uKOk2oNwDqbZXhzFyX5QKLmnKEcTF9ToPfgvM0R/hbKKPGIFGs57knNGt
TPszK2Y4NcjxiI1KcYuhrcjfW7vXCaulLqq1IGJ0kR4nX/FBmG4e7onAhbrBifAq
4FNWOxVmg0Yq8wlMgCKsObFQPgkdbg==
=Hz1f
-----END PGP SIGNATURE-----

--Sig_/ediXCgdp=3VX2QzEgGD/S41--
