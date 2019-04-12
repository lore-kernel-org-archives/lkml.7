Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F0CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37F020869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sStHq6af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDLEtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:49:25 -0400
Received: from ozlabs.org ([203.11.71.1]:34239 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfDLEtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:49:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44gQR60FJFz9s55;
        Fri, 12 Apr 2019 14:49:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555044562;
        bh=4ROZz66TCwprqdEGczlv7RNfxf2WM6TUZvJnNrUVLuY=;
        h=Date:From:To:Cc:Subject:From;
        b=sStHq6af4yfWtdYsqBCk64siiFvkyZyeV68xuTRVPJ1JAw0zRm85kSERVfz2wXfR6
         L8ka/6rXoO5XcO912tFKWvEzvszFHiDMAWtj65HtXyZ/8xtHzKRRq/Lp4kdNS5wXHC
         SLX33avXbxuHe9mR2JP6BBvyhXFK18njG0tfOaNnNiNIZytSEHnRScixNNOTIvOOM7
         DBUvUBy6ruJHEtN7Z47nt5h7SALa9+EUSgoAt35Q/8A3vr0iHchBU62dq/SYz/K/gS
         nWpzgMj9Y4Cu74T+0LYfGOqf0fLJEF7ZAF83pPeZ6wBMsnhRgjJfJT8KvjrHdUjIVu
         y8k5Sxrc2ddrw==
Date:   Fri, 12 Apr 2019 14:49:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Yang <decatf@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Subject: linux-next: manual merge of the staging tree with the imx-mxs tree
Message-ID: <20190412144921.3a152478@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a9VId0sWDIARXq36H946r=_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a9VId0sWDIARXq36H946r=_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.txt

between commit:

  189733b0a7e4 ("dt-bindings: Add vendor prefix for Rakuten Kobo, Inc.")

from the imx-mxs tree and commit:

  2e5cee6c7622 ("dt-bindings: Add vendor prefix for Kionix, Inc.")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/vendor-prefixes.txt
index 5f2b185a04e6,93753f447c20..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@@ -211,7 -210,7 +211,8 @@@ kiebackpeter    Kieback & Peter Gmb
  kinetic Kinetic Technologies
  kingdisplay	King & Display Technology Co., Ltd.
  kingnovel	Kingnovel Technology Co., Ltd.
+ kionix	Kionix, Inc.
 +kobo	Rakuten Kobo Inc.
  koe	Kaohsiung Opto-Electronics Inc.
  kosagi	Sutajio Ko-Usagi PTE Ltd.
  kyo	Kyocera Corporation

--Sig_/a9VId0sWDIARXq36H946r=_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlywGNEACgkQAVBC80lX
0GxX0Qf/RyeVmwoWjw/cwDhEpO/ExAPZYuImXDgfxo1mjw/EuqR7CPh9oJI38SNm
SkVTxDToJPzWk7TdjsergbLqaaKohVpyB7S5ZhOjOvDxytmWaWAaZicASlztDhhY
FvYhfHSfeRb+FmQA1kG4Bo/iDgN9p1PFzeH7/oLciHvTjbovimJn0C/psHo822e7
pXEYGr+k0yYvuxR6GImtQMvYLJHpSRkzILp81TwVxzdmmjgiyzvEg+8O+fSLcOHg
CelSksLoRNCa5t9nH8MHJdwiGjo3fj6JISpQBjz/jqcpExtm5kU4FkNWs+XIO+On
0vmC1Nd4M5JmyxkzqHMDpooGLsbXPw==
=oDxS
-----END PGP SIGNATURE-----

--Sig_/a9VId0sWDIARXq36H946r=_--
