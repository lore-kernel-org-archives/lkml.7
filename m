Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D06920850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OQo/qgu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDIXed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:34:33 -0400
Received: from ozlabs.org ([203.11.71.1]:44289 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfDIXed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:34:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44f3Xk0PkGz9sRH;
        Wed, 10 Apr 2019 09:34:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554852870;
        bh=R5hNgvHOR4nd+b8LQkXG7FPZAzO0AWYpDYaN0N8EaN0=;
        h=Date:From:To:Cc:Subject:From;
        b=OQo/qgu5BDtdKpgKIWZXPEoc5DXx+GuZh0lyKhlU8I/gVVmUkn40cVA8wh1S39FW9
         SXGcfrKJh9/2wg3rWyAoWvasf5DVCbQevNwuMYClTqwIJfo0xSTIOkhvdGyvxmAVZu
         Lm69YvNvd09YPTztNXHfm6nHrzSnA/n/ny5DFl1KOUsNh5VvAIcOdomgyGpNnlZfHs
         B2OjiuAc0deoZcshCKZn1qGs95mZpNDuUxfJ9DapQ9eWSc/x6kXsbxrlg5tZFCfxuB
         KTkgf+zdafPnB/h+DDlQdWfeLLVqKZCoREKImIQYxcQeAYHhvHX/Y4m2TV9DG9YiW7
         osPv2AzRvyUBQ==
Date:   Wed, 10 Apr 2019 09:34:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: manual merge of the printk tree with Linus' tree
Message-ID: <20190410093429.095c8975@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/gimwf1eMZvYjGfuTZl5Qt=f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gimwf1eMZvYjGfuTZl5Qt=f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the printk tree got a conflict in:

  mm/memblock.c

between commit:

  26fb3dae0a1e ("memblock: drop memblock_alloc_*_nopanic() variants")

from Linus' tree and commit:

  d75f773c86a2 ("treewide: Switch printk users from %pf and %pF to %ps and =
%pS, respectively")

from the printk tree.

I fixed it up (the former removed the code changed by part of the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/gimwf1eMZvYjGfuTZl5Qt=f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlytLAUACgkQAVBC80lX
0GyOrQgAgdKkTUNGAVzqQ6hevkkvY1uLF915JniPe35gp0n+OKEWPX1LY/R2fxPj
Hq/esVJnuwz3Sx/hP7aajNUed0TUPw5xtvCsHf695HizP+iqGd/vhfiAwAdkV3IZ
XkqUGJD90tddcZXpjAPHiViUm74rGrmZpah900eg9aoNqIQ0MoxQEYbWYQ3wrVoa
kKK5yZCLdX8vBKmnA8LN6udU1ijA11tdpMjGXaBWJX1Yt6C57MW028MjnHPHXSNd
gsHt+Ymx9DQbJiHc+kSCsh4ngV6H/Nqay2hacR9EyLb2vfljKNyxPz90yyJr1IK6
cbdjr4bsRiOXe2YqKSamx5znc53H/w==
=v2mZ
-----END PGP SIGNATURE-----

--Sig_/gimwf1eMZvYjGfuTZl5Qt=f--
