Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C028EC04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F69820863
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CYo9Ys7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEIAoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:44:19 -0400
Received: from ozlabs.org ([203.11.71.1]:52175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIAoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:44:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44zvjq2vPlz9s9T;
        Thu,  9 May 2019 10:44:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557362656;
        bh=E5PK3FIJAaUYXh/Qems45knj53ul5dnBkP64mctbQQ4=;
        h=Date:From:To:Cc:Subject:From;
        b=CYo9Ys7u/h0sJJozCmzQi15g8eHz58nxiX5HVyq2KKgMP5Uazvuhmq0eMYxFcS+0Z
         GD8Heu35p8fn4mpKa7DXK7Qr/NArW4uECoX2o+LdS9Pwivui3xBLNzvFSpa68D6jRE
         tgm8gQGMsFPwv6Yclv6ILZ/X0nR1EJ3X4B4/ip1AC2J2TCX4ol0s85YlkvkNotq2Uh
         v01gdop08KLGpJFH/bkt9gl0kfsFCxB/FRAWj1rZ8vb/8GQGzv9bH8HIlis27yzjoR
         WvkkqO3iJ76nfbcT1jAV3jKhhplmW81rWuP6i5YxJhjC8kA7HPhHI28mLQc+p8et/2
         8Vm2KVaAazuQQ==
Date:   Thu, 9 May 2019 10:44:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Kitt <steve@sk2.org>, Ingo Molnar <mingo@kernel.org>,
        Changbin Du <changbin.du@gmail.com>
Subject: linux-next: manual merge of the jc_docs tree with Linus' tree
Message-ID: <20190509104409.68446da2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/y.FCpf7A_lHx=q1IALCGru4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y.FCpf7A_lHx=q1IALCGru4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/x86/x86_64/mm.txt

between commit:

  89502a019790 ("x86/mm: Fix the 56-bit addresses memory map in Documentati=
on/x86/x86_64/mm.txt")

from Linus' tree and commit:

  b88679d2f2b9 ("Documentation: x86: convert x86_64/mm.txt to reST")

from the jc_docs tree.

I fixed it up (I deleted the file and added teh following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 9 May 2019 10:39:31 +1000
Subject: [PATCH] Documentation: x86: update for "x86/mm: Fix the 56-bit
 addresses memory map in Documentation/x86/x86_64/mm.txt"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/x86/x86_64/mm.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.=
rst
index 52020577b8de..267fc4808945 100644
--- a/Documentation/x86/x86_64/mm.rst
+++ b/Documentation/x86/x86_64/mm.rst
@@ -78,7 +78,7 @@ Complete virtual memory map with 5-level page tables
 .. note::
=20
  - With 56-bit addresses, user-space memory gets expanded by a factor of 5=
12x,
-   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PT st=
arting
+   from 0.125 PB to 64 PB. All kernel mappings shift down to the -64 PB st=
arting
    offset and many of the regions expand to support the much larger physic=
al
    memory supported.
=20
@@ -91,7 +91,7 @@ Complete virtual memory map with 5-level page tables
    0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space=
 virtual memory, different per mm
   __________________|____________|__________________|_________|___________=
________________________________________________
                     |            |                  |         |
-   0000800000000000 |  +64    PB | ffff7fffffffffff | ~16K PB | ... huge, =
still almost 64 bits wide hole of non-canonical
+   0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, =
still almost 64 bits wide hole of non-canonical
                     |            |                  |         |     virtua=
l memory addresses up to the -64 PB
                     |            |                  |         |     starti=
ng offset of kernel mappings.
   __________________|____________|__________________|_________|___________=
________________________________________________
@@ -107,7 +107,7 @@ Complete virtual memory map with 5-level page tables
    ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused=
 hole
    ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual me=
mory map (vmemmap_base)
    ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused=
 hole
-   ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shad=
ow memory
+   ffdf000000000000 |   -8.25 PB | fffffbffffffffff |   ~8 PB | KASAN shad=
ow memory
   __________________|____________|__________________|_________|___________=
_________________________________________________
                                                               |
                                                               | Identical =
layout to the 47-bit one from here on:
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/y.FCpf7A_lHx=q1IALCGru4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTd9kACgkQAVBC80lX
0GxfGAf7BBWJrE0RI4QacHN00po1z2E42QcpgQ+VqkgLIyMxjjU/CD+TUfalLoLR
gsOH1/U5jhxsltyf4V04CGoBCGHMK3557doSJDL9b8MGXLgtT4mAsPgT0twQ10TA
teYdpHvgdJNimsQCuuCc08Xj7cdGCQk9yQ4aOvQ1D6MjW9GtNkjSdJoSwthQlgtx
mvoeJc08tAi6lfz3Ggv+4S5/PsMjuVIOIrbqC97GNmjovHVRHg2eZYAgCbfaEbfU
9E5zknJHxT4alxlYql5SZd6hiP8WrLsuniHkqXhZC/1L17moV/y+ZfT9lDGfGCZi
Jixvn+LIsR4PSX2z4nVUCaixqRmN4w==
=MxAi
-----END PGP SIGNATURE-----

--Sig_/y.FCpf7A_lHx=q1IALCGru4--
