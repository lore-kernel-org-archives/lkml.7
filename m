Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2847C04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36BC25A4B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 00:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JRSJhPLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFDAyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 20:54:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60137 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfFDAyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 20:54:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HtjR1w6dz9s6w;
        Tue,  4 Jun 2019 10:54:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559609659;
        bh=29Af5Da3Gy9HkvXtsrJqHRst1Vyy8QIp5xkkLN5QRro=;
        h=Date:From:To:Cc:Subject:From;
        b=JRSJhPLnMgPZMHpKhjCR8wUtl35ScCGyV5h1aHqk1Od2Fqfj7mbSnX9gI9tseyLOZ
         4qwcFbSfCjEl9hm1+yLxZox73SiCtdH72LM0uO+lfUx/Gg/Q1VtGZb1/EL6qEYSngN
         rDA2L9xehm/tpwOmLajGBfQ7OBIAuru0ZGP7Zdc/g+OWMWY9DF2UXeqJ3CcWjtBwVv
         /i6DclixJLjr0gfDr7mpBhMFEGgWwb28n3L9JvUMWb9/6o32QdBMtdtlKSjiZRNi87
         UMIWLFQH4ETrKWWND0YTm7LuldmMlZXnHrtBJyg0QRGhHJFPC9/kvoPQ0WCFDE0nI5
         37sq5mKNVN8Og==
Date:   Tue, 4 Jun 2019 10:54:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the nand tree with Linus' tree
Message-ID: <20190604105418.58da18b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nVE9Xfja1ymcpznMa6jaV1r"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nVE9Xfja1ymcpznMa6jaV1r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt

between commit:

  a5f2246fb913 ("dt: bindings: mtd: replace references to nand.txt with nan=
d-controller.yaml")

from Linus' tree and commit:

  33cc5bd0b87a ("dt-bindings: mtd: brcmnand: Make nand-ecc-strength and nan=
d-ecc-step-size optional")

from the nand tree.

I fixed it up (the latter included the changes from the former, so I
just used that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nVE9Xfja1ymcpznMa6jaV1r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1wToACgkQAVBC80lX
0GyL7gf+NmJyIgxpzBKZ26V9d83sLzSIb6qeJXc0Xmp0nDOznqTlqXboyJzSaGQ4
7P7DLWPqEzwizk7VCHgU6DD8bRy8fe1Z3yaXq0y+p3IxDH0m2JOP7JEg4V/Shn7M
PgmecUFYCXi+lNXB8GhMWWWarP7qDZQZc95wIC6aD3rR/XxU6IB69NJ64kTgMHGg
BvmEuOciX77oi2pE9hl+3rMwd+6YOYTMTStyeYEslRlLPcHYLhL0E7dyYhvZyRfP
J5KHz7R7aI8PTfoO6i9HEahe8iKS46G+zxayMNNFC3akz3kixyL0/hB1sUkXHtkB
2ORP1xhi/2eInXyquoAuJM9cYsQeMA==
=i+6a
-----END PGP SIGNATURE-----

--Sig_/nVE9Xfja1ymcpznMa6jaV1r--
