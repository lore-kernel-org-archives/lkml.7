Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C549C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95A820673
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="U4TT85b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfGHBuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:50:37 -0400
Received: from ozlabs.org ([203.11.71.1]:52411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfGHBug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:50:36 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hpLd0ftbz9s3l;
        Mon,  8 Jul 2019 11:50:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562550633;
        bh=lYQHy7yGCzhmW+w0ao+r9/z+hFOQ8p8iaMb1rDoa6Mk=;
        h=Date:From:To:Cc:Subject:From;
        b=U4TT85b34zt4YOkYJEgPPfym8BYUmL5IsRVck+GWU+KX60UFEUIwQyAchWy4WRi5S
         aCptPUl9KmyhdgN+Pn1BsjU/tiD22yjS0qRtcJhvqrBe3QS/08IVD9+qnbpwObOt7y
         244e6Lv7DykLJ52/lGbL7WMnVD8zGBS2ePKUK9998nyQnECJq8kcaTH/DYfOG411CZ
         MGqACmOFo+snCIbBBrtSszMmR/Hfy1jdhWuVbu/II9AyBRnMStMD+9K/QPKNo9leOV
         cT8Rcqjehm0PBvf+LxrUS2vbCrN1/edY+LnDs4VUoD0FXEIwDa3Pmj7CVS+E1WgmW1
         TpoSdtgNhCb2Q==
Date:   Mon, 8 Jul 2019 11:50:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the vfs tree
Message-ID: <20190708115032.098e7302@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1+95s754x4svMic9tqeA.TJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1+95s754x4svMic9tqeA.TJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/filesystems/vfs.txt

between commit:

  51eae7431ded ("vfs: Kill mount_single()")

from the vfs tree and commit:

  af96c1e304f7 ("docs: filesystems: vfs: Convert vfs.txt to RST")

from the jc_docs tree.

I fixed it up (I removed the file and added the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 8 Jul 2019 11:48:39 +1000
Subject: [PATCH] docs: filesystems: vfs: update for "vfs: Kill mount_single=
()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/filesystems/vfs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/=
vfs.rst
index 0f85ab21c2ca..a65ee69f02d1 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -195,8 +195,8 @@ and provides a fill_super() callback instead.  The gene=
ric variants are:
 ``mount_nodev``
 	mount a filesystem that is not backed by a device
=20
-``mount_single``
-	mount a filesystem which shares the instance between all mounts
+``vfs_get_super``
+	mount a filesystem with one of a number of superblock sharing options.
=20
 A fill_super() callback implementation has the following arguments:
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/1+95s754x4svMic9tqeA.TJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ioWgACgkQAVBC80lX
0GzlcwgAgjWBMPJqWoNFcp/vBbjIe2ZQPFjL86Q23h6Rb/OfOYNAsb05OrmQ2FoI
I8JgmwFLijey9cE9gRXbDVI3IsLi0rrD3+ePh+QXVkpfLLrIIEPwsIB7PTRuheAE
iV2gXqdza3RySb8Bu5eCw4djS5Y4q9sORjWNRLfc19JSQcFSkzcOyFk2Y5cKxyQo
2zkjzfE+y7dVu/Cq3IN1AJ0nQ7rAH4yjpU4xEHBNfy4/K3yVTvSuAuv105YsdAAl
ewKCA3MzuoNbjS+VTQUIso1EhLJutt7tcxK1aaEfTizcmLIV4hhgv+MsNppKWzuZ
Z1NFBt99Pa9jbkIlHr/k3Szcb4FbkA==
=87mw
-----END PGP SIGNATURE-----

--Sig_/1+95s754x4svMic9tqeA.TJ--
