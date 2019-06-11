Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CFCC46477
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AifJeYNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405478AbfFKWdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:33:45 -0400
Received: from ozlabs.org ([203.11.71.1]:57987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404099AbfFKWdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:33:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NlCT60Mgz9s7h;
        Wed, 12 Jun 2019 08:33:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560292421;
        bh=tJqum1akZ7Lu4aMUmDvYiICEGpxAbYk4hDY4i9k41wE=;
        h=Date:From:To:Cc:Subject:From;
        b=AifJeYNI//Ty4Hsjpi6Lfd5QByPx++QJSb7ZrnsVhXDTIOVnEOiab1E3FckqRcBTy
         MkWboSM2MLifswoqG/6dqBI4mLzSNRVJiHoYPhQ0IQNvXvLKr0QEQqeFeQG6UkeuyB
         t26wz8dpiSFM7zqFNXxH2o3W86L6LHV/N/MhQCac+xI1hMZnnf92iV/tTgCrcyvVVy
         +E3dKgx/a1FCLopZClY8oH+wx4Ll+Zi/ogBZBL3KIsrDdHgSixC1czxsw4zhHY2ffE
         eQRQFndADbPj58IVbzIWZC78nXcDIF9kH4g5zsrlM//U7yG4uBJhX1SsVDcpUgBSYM
         ekO2W08G6MvkA==
Date:   Wed, 12 Jun 2019 08:33:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>
Subject: linux-next: Signed-off-by missing for commits in the mips tree
Message-ID: <20190612083340.1c84a0b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QmAwlCBloiPAW6evq1L6Yj9"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QmAwlCBloiPAW6evq1L6Yj9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  5285b4d2be3a ("memory: jz4780-nemc: Reduce size of const array")
  fb91216516a3 ("memory: jz4780_nemc: Add support for the JZ4740")
  d1da6683d678 ("dt-bindings: memory: jz4780: Add compatible string for JZ4=
740 SoC")
  6ef12765520f ("memory: Kconfig: Drop dependency on MACH_JZ4780 for jz4780=
")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/QmAwlCBloiPAW6evq1L6Yj9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ALEQACgkQAVBC80lX
0GxSpgf9F1Fat4lofRFr995n8p9h/NOMtMgVlGOtRiPUVbLHP/EmuYjAxyfixk9h
22yx2fzuYWlMIBaNeh9ErX17yXgQAT+u6LYKWwucGUNmTI8Ft6FMFk1m7hESxfPi
fofLHb7vqkcqOGhGM34DvXGZ2t2t7aiuWfP2VTSs0akKq4DDhBo+16QlyHrFl7r3
0QUiJlfMuoUSmO7O+HHV3TqJ8ZjdztmzC0zAoL45S+PdvvmN1PiC3LzuV/66dcxY
Qs3eewFi3zvLsYnloASlK90TvBTk4pRwr5aSlKrMECS1+5FajwFwvLiV1OmxSmaX
kYlrNCLLe12TyyFXFXiGhVB83M7Mbg==
=2fXC
-----END PGP SIGNATURE-----

--Sig_/QmAwlCBloiPAW6evq1L6Yj9--
