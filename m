Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C2FC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD72199C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VQRQuOZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfGWBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:03:35 -0400
Received: from ozlabs.org ([203.11.71.1]:49319 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfGWBDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:03:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45t0bS1wKvz9s3Z;
        Tue, 23 Jul 2019 11:03:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563843813;
        bh=EgLzuuOlqciTbhsbAXpNasSCsMeGLSHIWQ28FtGs0I0=;
        h=Date:From:To:Cc:Subject:From;
        b=VQRQuOZWsUz9x7pT7riQeHCsTKnY4/Gxk+HepcfdxKw7AZj2N7lbFQLBUVRZema+X
         urUkvYolS6kFFeiWaP6yHdUV34CcnxCpHVwVGe1037NC4zyiYwTbgI6ikw+E+drvwZ
         R/Y+6PJeJImx1oghtkw9fWCuFuzXax7YFUs8kFQJ9nGiWisptq5Upd9SWD70680hj2
         oNmeW5mO7BF9Rjqs8pQpdVl6RGgP7rQVNPAlvItuzvrOPI36l7GqQSk14JQxpstdKn
         iO+H+en5kflYU9FvXechwyqanVyHIUWy2r26507iH3MYqXvVPz7vqWCIL8gmTWz+wW
         093iKepYe2TmA==
Date:   Tue, 23 Jul 2019 11:03:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Imre Deak <imre.deak@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the
 kspp-gustavo tree
Message-ID: <20190723110331.1967d000@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ys73Uxj2mKTiAI7sxPqI1zL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ys73Uxj2mKTiAI7sxPqI1zL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_dp.c

between commit:

  b6ac32eac063 ("drm/i915: Mark expected switch fall-throughs")

from the kspp-gustavo tree and commit:

  bc85328ff431 ("drm/i915: Move the TypeC port handling code to a separate =
file")
  4f36afb26cbe ("drm/i915: Sanitize the TypeC FIA lane configuration decodi=
ng")

from the drm-intel tree.

I fixed it up (bc85328ff431 moved the function updated by b6ac32eac063
and 4f36afb26cbe added an equivalt fixup) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ys73Uxj2mKTiAI7sxPqI1zL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl02XOMACgkQAVBC80lX
0GwDbwgAlaf+xE1tNCPsgcl5HiOTZUxrqytDq4ycNhd8xFpJEaYjWRt9ldGASVMz
UfcpujMglgxs74dUunYoPKpX1dRDvwStCnTsAhqmNFYsYvITqfCcFXeQow0a+FEq
FTaY8ukiLVLud61SU2OtRuDhynlvaH1MGcWFy7VmWXq5I64aGKoLAK6TkrUnYBEP
hmMG0nH6qXD5npB2HkGnSrFszOKMfU775mHEjTDXPLbYyb/IcKqFVXU8fil0t6YC
mdbekGPEh8a97++FZRMqndFuxipjobnmIef3ncpGwRsEDin7bakacvn4HGAtQdd/
pHErDey/00MZW90mXE4cjshBlsIdBw==
=0Gt0
-----END PGP SIGNATURE-----

--Sig_/ys73Uxj2mKTiAI7sxPqI1zL--
