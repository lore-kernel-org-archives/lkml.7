Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365ECC04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C421479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bScaIWcj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfEUAvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:51:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47267 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfEUAvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:51:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457HK35YNjz9s9T;
        Tue, 21 May 2019 10:51:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558399913;
        bh=mrT1NhYLTGm56w+283Q/Y/Bq4w6pdDYqc2RQ0JCklGU=;
        h=Date:From:To:Cc:Subject:From;
        b=bScaIWcjdzoAWs5HQl4+uIfctMX2CdWm3FrdE2Qa7dJ5FIWE+06ez5290MiCTI3EA
         b7KPVQADb9D3Ua5D7AmlB5Hy3+u3RfsgoKXaS/zBHO3vESkg2TAe3lZ6Cu7AAxW//S
         uWd9s5j7gg68GRInZLSm4zLWdvIRVX2eMGXG/TM4vLsAawzJWazyiMQZ+8pZTyd0UE
         PNd+rjTIcOZK9tGoTo1JbzPSdX+PvLHbuds72M+55X16EhiyuE4oj9ypK4r5U4lAQp
         VjYkKaBtuzGZ9xcO3kBXAxHjMGqfY2QceFEbhRbufDnqbPcDXI6+jhkMbGCHZVB4Oe
         wkmhByWTJeU6A==
Date:   Tue, 21 May 2019 10:51:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20190521105151.51ffa942@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G6L+=B.XzszjFbhvzmL2hFN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G6L+=B.XzszjFbhvzmL2hFN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.txt

between commit:

  8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")

from Linus' tree and commits:

  b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
  b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9700R=
TWV43TR-01B")
  fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronics")

from the drm-misc tree.

I fixed it up (I deleted the file and added the patch below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 21 May 2019 10:48:36 +1000
Subject: [PATCH] dt-bindings: fix up for vendor prefixes file conversion

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 83ca4816a78b..749e3c3843d0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -287,6 +287,8 @@ patternProperties:
     description: Everest Semiconductor Co. Ltd.
   "^everspin,.*":
     description: Everspin Technologies, Inc.
+  "^evervision,.*":
+    description: Evervision Electronics Co. Ltd.
   "^exar,.*":
     description: Exar Corporation
   "^excito,.*":
@@ -851,6 +853,8 @@ patternProperties:
     description: Shenzhen Techstar Electronics Co., Ltd.
   "^terasic,.*":
     description: Terasic Inc.
+  "^tfc,.*":
+    description: Three Five Corp
   "^thine,.*":
     description: THine Electronics, Inc.
   "^ti,.*":
@@ -925,6 +929,8 @@ patternProperties:
     description: Voipac Technologies s.r.o.
   "^vot,.*":
     description: Vision Optical Technology Co., Ltd.
+  "^vxt,.*"
+    description: VXT Ltd
   "^wd,.*":
     description: Western Digital Corp.
   "^wetek,.*":
--=20
2.20.1

--Sig_/G6L+=B.XzszjFbhvzmL2hFN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzjS6cACgkQAVBC80lX
0GxxWAf/U1Bd2c5IorrbBJ3GkYu19Jh6K5qnUcxJYTTKlhemqW0P9KsDtQe2fvsH
EUIsYjeHhlAUsohXmD7LMada75LSwqESAWY2nO9hCyOk4Mf6VU68oiEOGg+PI1s5
Ex8sCpW5SmJj4NUnOBVCFuQLde/8baqC/l7PN6NQ/aetKRSXvw51OK2JzbWrmqFQ
f9/sGKu2HUBbsbkZhbs2FZt+ZfMQlA3RtKn8Kt4R/h0joo1gkVvztAO+PsOYhZL0
HIMpwg4o972YQYhLdUjqX088+mFQ2ck4d9iazQxcycIhVRgQl6EcAuWr3AzA5UcW
Ii58xvlIbU1Uqb2AtEAocPkXyup2lQ==
=C1+W
-----END PGP SIGNATURE-----

--Sig_/G6L+=B.XzszjFbhvzmL2hFN--
