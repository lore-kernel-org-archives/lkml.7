Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B502CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E39220679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 01:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MM7/PoR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfJ1BLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 21:11:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39171 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfJ1BLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 21:11:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 471c9z030gz9sPK;
        Mon, 28 Oct 2019 12:11:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1572225095;
        bh=5Ds8Q7CwdrMTbH9IXggt+mmI5j9uKDnt49CBC/Yz0ac=;
        h=Date:From:To:Cc:Subject:From;
        b=MM7/PoR8cF8t5iPgN5QkQc36BoC2GCYAu0R4TZ735lteuWaNTU8rqYfZKQ9Sm101V
         DtDWX/XRAqaEY/rZzARWDLLCwQQqjRHjsM8vJX4FlAXA6qlmoenutcFR+P/C6GLbsI
         xlgf9YwQaz9aSyOMFX1cej85Sxv17sQScpi8aVDYIqk3dmPobXymJ3i0Xu0D7dhgXa
         C7bweNgoO1iH7H4yo2Sy2feqwTFo4MwNeqKMiiw42UXEO5/QkoIziCTSVQMMgIeEDD
         UZQo2r/XX3o1Lmx7sjluxjRBiW4QNnLXWObAWpD4Tou3LGd3XUXGNetfnPSH3IlNTN
         PDuwpCurDq9aQ==
Date:   Mon, 28 Oct 2019 12:11:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Wang <kevin1.wang@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20191028121134.63b6c3c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GWYAgCEI=ktipbJFMteknT0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GWYAgCEI=ktipbJFMteknT0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h

between commit:

  155f85c0d568 ("drm/amd/powerplay: remove duplicate macro smu_get_uclk_dpm=
_states in amdgpu_smu.h")

from Linus' tree and commit:

  18c1d3cee4c5 ("drm/amd/powerplay: split out those internal used swSMU API=
s V2")

from the amdgpu tree.

I fixed it up (I just used the amdgpu tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/GWYAgCEI=ktipbJFMteknT0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl22QEYACgkQAVBC80lX
0GzvBgf/T2qJJzaB2aCW3QcDa1KxjhFm6Uj3hqXBjy0akfnJ0YG2udqAqd8vLYrs
epTg9PEJaxGgIDZFZ2lS8zxhgHr9Lzbg+DPVaXaQx9COIyNQSMsw+EPuA90B0Q36
avdwsL/5g7Bqvib0sHTV6ke4zKUGRQGhdIz/+uoCuwj6X6nstXC2Mu+xVccjtBVh
Zi27tac6QZpN8HJrZOLq5pualLpU92uCkV4V0twEHltN6xGV9sx53hT4ujsYOZ9/
Wu1CMCmCLX+wEt3WFIlvEM1MMf6UysmbHLoUKqzUJohbT2kEMJMj+ilT5nvagF/R
3Ci6aQiis1mzn41Sm7MvjsKhZ+AczA==
=PkON
-----END PGP SIGNATURE-----

--Sig_/GWYAgCEI=ktipbJFMteknT0--
