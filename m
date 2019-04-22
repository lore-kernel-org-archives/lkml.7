Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26B2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9E22075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="epCri5FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfDVVeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:34:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42441 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfDVVeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:34:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44p0Fx0wQKz9sB8;
        Tue, 23 Apr 2019 07:34:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555968853;
        bh=pQ2H9T8Cy1iiiQ922EqbquGW4xLn6hkDzGVgnhr/IKM=;
        h=Date:From:To:Cc:Subject:From;
        b=epCri5FT0IJe3ZukGKeolpGqzDFPr24W7pfADAA3kzyxThKYYnG2vBoeYCH6+B2pe
         xImZhoYwF6P31oi3AKeP9Ryl0MsWtw4FBMDnlej8NQYc7uBqg1whRfcwSRi2lsBmtM
         X0VBakGF9qq1r61ZHHJ5qkR3uQy2ScbyIHlZPh2HXfIl5yIzoKGS3HA8AaXTSp0RhT
         QCgEYPVzJRL3dJfnavsPWN6o6b2eR9Cl3Ta70mTJ8Li0IFZTmFvjBM0+lWywaTm2ji
         InwDrkCK0r2hHRGXmgTctfpR4FkwoFVMca1dp+9FJ1yXFSa//GV/J9UarczG4yizd7
         noOwFV2KTg9Qw==
Date:   Tue, 23 Apr 2019 07:34:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: linux-next: Fixes tag needs some work in the device-mapper tree
Message-ID: <20190423073412.01c6376a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N2s5W2ifAqi=VcYKPBRHU/O"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N2s5W2ifAqi=VcYKPBRHU/O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e28adc3bf34e ("dm cache metadata: Fix loading discard bitset")

Fixes tag

  Fixes: ae4a46a1f6 ("dm cache metadata: use bitset cursor api to load disc=
ard bitset")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/N2s5W2ifAqi=VcYKPBRHU/O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+M1QACgkQAVBC80lX
0GyI2Af+OvmatQ7Sy71kjrrDoXjdz/l0hjYnj30x8DLP22JF+NQbxd4ShA7KoPh9
qegKMHykDKDdKP3A67/yVyt3R+GAaAQe5SA8ab61e3oZKvUfRHpV0YP8ljBn9c/D
Q/4NORJL3YuV4f0EJ9hx634OvqdUQhock79kMGkM8Pn6KiughubyY9yro1dex5P8
0SzIPvw3kta6GjbepTI1WJd0xwPe8A572EcGboZg+Zc17hg+cz2YuaxPxYNRr4ZE
5c0TQ2Qr93k0GO/Umtwve1TKbNkpE2aDVK7BsK8WTuMgmA799oD6WT6yxGftOmSM
Lnqezi++yIBsm7GPLMNM2Na1RuE6kA==
=GWpp
-----END PGP SIGNATURE-----

--Sig_/N2s5W2ifAqi=VcYKPBRHU/O--
