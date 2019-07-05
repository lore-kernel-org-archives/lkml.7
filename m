Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB3C0651F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FA42184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GspxrCer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfGECuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:50:51 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfGECuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:50:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fzqT23JJz9sNf;
        Fri,  5 Jul 2019 12:50:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562295048;
        bh=CwZDWdAbth5jMXxyrhGjRXLrCsjjva+ka1rJPIeETBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GspxrCerJBkI4HWmoseCoWFshTlm0tHa8iIvKzWu/9rHtGNBL6SxdGH2KdCAtsRXU
         UuOVgHCDAVFs6qFPGmsbAMIIR/pJE5+a4Q26hPSGtRS4yUAoW8zu0RpKfIQUs/xs4a
         BILCYzFtKpXYgAHDTbArdYj3i/0uPo5EpY+Bch33wGNF7/M4ftcuH3UI+qjYqj3How
         AifyIKLkMZpdDfhY2XsSCSYYsFKkgazqvB/lmro1CN+6KS3FZ4DFt7Wa/S3tKcQrC2
         C2xRegzXbspyDdTxnfl5NRhzsjzs8Gss7oJkh+wSO7aTWJl0C/mwNof+NJw79DwjQq
         6JIdB8FK/66Sw==
Date:   Fri, 5 Jul 2019 12:50:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trigger Huang <Trigger.Huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20190705125044.12c10552@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8gZKdzyZ.MTIruRd3tsn7Vg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8gZKdzyZ.MTIruRd3tsn7Vg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c

between commit:

  25f09f858835 ("drm/amdgpu/gfx9: use reset default for PA_SC_FIFO_SIZE")

from the drm-fixes tree and commit:

  1bff7f6c679f ("drm/amdgpu: RLC to program regs for Vega10 SR-IOV")

from the drm tree.

I fixed it up (the former removes the code modified by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8gZKdzyZ.MTIruRd3tsn7Vg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0euwQACgkQAVBC80lX
0GwLyAf8D4+tM3UyxYIbHzXNp9lsJcqI9EKjnUB2NwnC8c1FqTZA0Bd5HYv12wfT
UxqGMCmUXZm8r12CFt8b48WFofS2q8sMSGJh0l/IyR+D3xPjxX/OWhXkAzDbiSfL
OwBwlqDoazWuzfjatt5l4kNYE+R6K756TgHUvf4/PqQ0xhaI0CZ2PsfFPmMER4a7
5d5Oq9V95vZwI0H1cipa3EvL0nHBB0KWhBRvsLI13ImT0WrC3QOkhWQ54CrpIaL0
QBcO0ybBRNxeERjb20hYMSzvbaQw4jEolefXdklbxYX66hAwWSYN9Wc3+Exaqflx
jK4R8KSdDqhBgNX2EHrNQENhzvNazg==
=Jo7x
-----END PGP SIGNATURE-----

--Sig_/8gZKdzyZ.MTIruRd3tsn7Vg--
