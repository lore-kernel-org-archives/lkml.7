Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF3C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F2920659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ef5BFGbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfJBWMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:12:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60627 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfJBWMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:12:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46k9Nt55jRz9sP7;
        Thu,  3 Oct 2019 08:12:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570054350;
        bh=W1eDZ5VIsU8MXT4woar8/3j6QFLMNiRoiYNv26dvW9I=;
        h=Date:From:To:Cc:Subject:From;
        b=Ef5BFGbeX1shKLf370eqOXO0uSafHUvjzHkNZNS3X1ARTAPkrUYHPjivP9NudXa9O
         ErR6JynNeKdzuaEQH1/Y/8jnLHqePBtZxzeuC5lSd+sySuSila2Cm7qT7obLw3CEu0
         BBOwHxqVnR9wFCgwLX9cBd+L/N56ELUatuxM+FGq6DzbHv8XCwbI4vPLQ55ew1ujNE
         dScQOThlnIBi4YlN6gYhZn2VW1UcnME8umV6cDJhHRAuvrY5Z0XHnnD1Cmu/4bXG4S
         eP3kecA3OnqYNrDbKwv8e7oPEuLKEeCdsPvU/e1j0Jf0qY1q58sZTV8HOA0Qd27omb
         LM8Fo1dDyXWfg==
Date:   Thu, 3 Oct 2019 08:12:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the amdgpu tree
Message-ID: <20191003081229.6b3b8a9a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F.qlmoe+T9m+6zkzIKlnDyX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F.qlmoe+T9m+6zkzIKlnDyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  e2c6983e3533 ("drm/amd/display: Revert fixup DPP programming sequence")
  79312258f95d ("drm/amd/display: Do not double-buffer DTO adjustments")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/F.qlmoe+T9m+6zkzIKlnDyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2VIM0ACgkQAVBC80lX
0Gw+rAgAiqVzyPIRES5MO3ZywZGHVUW+zSsdgnSII12PezX1LVnq6KXDvYNoiSpt
DxDMSUfDAPy2o0b7ih6YZ3LXfSex+YpU71PCPJKYm67pbyQOiKLVAG1ZXZXDijhH
FPfP+F/mcuhE/Q9DhWXiDeieKX2JFPUc9XrE/Aiy4+utbD/qqw67jYnI2EOnyerg
uGCNi6u6vf7iii491c/Xaobu64n/9rARALtVCexFVxmNTBsXpU17VK/eyCjt0XYp
vP8j2nJKAqXMlT8xZ+CE4e7rEYfPrPnY25GJXCLMAjgfCUtYhkgiQ1/YYmMni7iw
Qln7YBxjUzYZyMdlzZpM6dloyHnQ5w==
=VOtR
-----END PGP SIGNATURE-----

--Sig_/F.qlmoe+T9m+6zkzIKlnDyX--
