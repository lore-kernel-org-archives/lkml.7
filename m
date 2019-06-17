Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24143C31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kP0QHqRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfFQDNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:13:02 -0400
Received: from ozlabs.org ([203.11.71.1]:53021 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfFQDNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:13:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Rx9R2VJ5z9s7h;
        Mon, 17 Jun 2019 13:12:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560741179;
        bh=dii/HBw3ZnI4e+hFv439RvrNBRhuS3jfce2LXRNFDRs=;
        h=Date:From:To:Cc:Subject:From;
        b=kP0QHqRiJeq6VP6/hfMI0Aeoz/JwTg15jiDBwKjgxjvk+VgCGgd2SC21YTTSP3yV/
         eNA/GVhMT4HnuMa0FaoVLzKsMsGej4PLTFP+Osex8GAiEh8WUV5cNIKgQD35O2q24t
         f6Z5L03dzGICk2KSA7GGPkl46D7uC0umgYPlZ4WHsKGCkufTIz60jeC+3/TGpxCWCQ
         +5GFtqJ/leUMdsTXPQdLTyn4D5CdW8V4sX8Ho3iEBJRLWGDi1fNdCG1Jl1QvclamNR
         VlQipglFayAB/yrkoPNY7zetWht7sQbE+tmqMyDRZAdThbLItR7Rja52t2nyaqB6HO
         fDVaojAR5IKFg==
Date:   Mon, 17 Jun 2019 13:12:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yintian Tao <yttao@amd.com>, Prike Liang <Prike.Liang@amd.com>,
        Trigger Huang <Trigger.Huang@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20190617131258.323a4a90@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w.oAuHCOhQJq8XNheooQ4HH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w.oAuHCOhQJq8XNheooQ4HH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c

between commits:

  192905989302 ("drm/amd/amdgpu: add RLC firmware to support raven1 refresh=
")
  f3a5231c8f14 ("drm/amdgpu: return 0 by default in amdgpu_pm_load_smu_firm=
ware")

from Linus' tree and commits:

  80f41f84ae2c ("drm/amd/amdgpu: add RLC firmware to support raven1 refresh=
")
  4a39ec6ac5f3 ("drm/amdgpu: fix pm_load_smu_firmware for SR-IOV")
  e9bc1bf7916e ("drm/amdgpu: register pm sysfs for sriov (v2)")
  0079f82e710c ("drm/amdgpu: return 0 by default in amdgpu_pm_load_smu_firm=
ware")

from the amdgpu tree.

I fixed it up (I used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/w.oAuHCOhQJq8XNheooQ4HH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HBToACgkQAVBC80lX
0Gzslwf9GupTS+jmfa7PlhO6ZMsEWqHasNXT3zRsMT3QUKYadrC6JhfJm7uDLq6H
rcHjkvhc7VCVjZxcM8DpHTXtx3YNuVwr+Ctx7onzf5i8nR84BrczCtLOAOK2aJ0P
cptHzW1nRxTLQL6yn/d8qkVUdgaXhx8r/zoVoPsbmTMaMj75x9IaXdqWBAGInQYM
bdUIOt3XySZ+hxTttKRMqJcyDMMR8D4roxUh0sefibiun4IRodjRu7qFNOFJN187
uxvCUTswzgnpHOL9ZqwkUNdBplEp/Ekvx+uCbuJybXMJPilG5z0wjXPVIvHn1sjK
dEYTbFPROJZUUdRhxMJ2Ii9gSP0JBA==
=eU9y
-----END PGP SIGNATURE-----

--Sig_/w.oAuHCOhQJq8XNheooQ4HH--
