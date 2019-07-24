Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7064C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4052238C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 03:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="sAV4UrdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfGXDC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 23:02:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36787 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGXDC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 23:02:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45tgBj2z07z9sBZ;
        Wed, 24 Jul 2019 13:02:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563937374;
        bh=1LiqNVdelzlT4P+spQ3/ccHN0uQeFU0Ww5WLBKlkPZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=sAV4UrdYEm+wsf+7H5ItxAgjkp9IkIxZuJ18fUv/e4FWRoF0s3JBQGEa9Ee98KffK
         EHaeVnPIk/wdWCNX2EMBffppICYvAFAIV/VzbClOCZVCk7LXWF2sg8KLlpokVD8t6a
         QmJ+u6rFGLOl5ldiQTEc8GgqbblF2q75TjovxmJxoLiQ3RSUUm6bzNmxX1pngA3Jaa
         k4LF3wqlaXpPzFvjBCOQWBG3CnF0VXW1R1PDRQ1CWqa2lVMzJUExLlnNAFfrLQN45y
         6naMeVPd3aDX4QIlhVWwHrogWiZVv/7067Hq8jl99HPIH0TiTXRF0tmbBGqfyIGRzp
         gJC3xYSecYAXQ==
Date:   Wed, 24 Jul 2019 13:02:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: manual merge of the devicetree tree with Linus' tree
Message-ID: <20190724130252.7c29bba9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pho=2pwViQ=W7E09FHEbr.j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pho=2pwViQ=W7E09FHEbr.j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt

between commit:

  355fb0e54e85 ("dt-bindings: input: sun4i-lradc-keys: Add A64 compatible")

from Linus' tree and commit:

  3f587b3b77b9 ("dt-bindings: input: Convert Allwinner LRADC to a schema")

from the devicetree tree.

I fixed it up (I removed the file - the additions from the former
have been incorporated into the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/pho=2pwViQ=W7E09FHEbr.j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl03ylwACgkQAVBC80lX
0Gz7sQf+OjXfLS22yQioQ3PX2SssOVpP/LU0FoLhhIbvCo/Hfz+n2SqG4w2Z81xp
JaM0e+4xmBB/aFbGpzr0HHxNp++A/UgnTGztij2YQjjKIoB9DFzqPcax+RYJhr0Y
Xyf29d1c1NH+dynQu+mwretgjGyXsHntVhwYDE6YGk/vEdZpHuSEqvhE7oJtQ5d6
g+Yf/qdKZ3LLdp8H5l9snCXLFWKHJkO0uCPx75QZj7knn9r3rIYQFkE0Bqxg4Ssd
Z281sl132fdAtmc7nlvga+WlD97qHsFTDqSguAFvb+hwlFWnZUDoStEb5Pmd8xXv
BoZGpFibLV1itCKPAZKpWSHZx+VV2Q==
=UdgU
-----END PGP SIGNATURE-----

--Sig_/pho=2pwViQ=W7E09FHEbr.j--
