Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D8AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE5F217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 22:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G3Jezmv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfE1WFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 18:05:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1WFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 18:05:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45D7Dm0s2wz9sBb;
        Wed, 29 May 2019 08:04:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559081096;
        bh=latartSpAexslz84ppDW3m6VjQvcega24simC5z4y2A=;
        h=Date:From:To:Cc:Subject:From;
        b=G3Jezmv4sMoCRolnG8T+dT5mw4caYYJSx9zGELDnclxHYb5ZeQ4GyXSrsrVvYmo42
         0gfhSqMeRqhG0lV+o5I1PR/NRjn34CDjYCW4XL/b8f1UDLYHPHfvMkZiiuKgsyx7di
         SPkrG6nzObzVwo7A4ZzG8ak0maaKl7Osqrokpg4pIc+7ByUPZ0Vl7pKuRcn+NXz4qg
         TC9lruBBY6EKmS8/PwHXHcm2S4+CCeUzvGFdB2yIU5Q4+hChXIRvup0MTtMhqC9/LR
         w61d35JwF5U9vJqnPw8ze3qBvIoDhxv5VjQBxZuA82pDheAic+wlM27TeeNUL2OMUO
         crqUok1mEBXhA==
Date:   Wed, 29 May 2019 08:04:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190529080454.6d62a7fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.d=BWJoTy6lPfZL4/CmtHiY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.d=BWJoTy6lPfZL4/CmtHiY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

In commit

  0c310868826e ("media: rcar-csi2: Fix coccinelle warning for PTR_ERR_OR_ZE=
RO()")

Fixes tag

  Fixes: 3ae854cafd76 ("rcar-csi2: Use standby mode instead of resetting")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: d245a940d97b ("media: rcar-csi2: Use standby mode instead of resetti=
ng")

--=20
Cheers,
Stephen Rothwell

--Sig_/.d=BWJoTy6lPfZL4/CmtHiY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlztsIYACgkQAVBC80lX
0Gz+/gf/T31KoLazyjEW89krmzM2wgc40Sab/m3NnCGPtDAzT4itrTJbP7xHwKts
R+MpjXiHQ5CtUdZnaBT9o4jsHQYR0gZNiqCxAC2gTok1tZkZHRzsU18LzRHcwLCE
bV4QzTxH4JJJwNZCeG90AsZsG2NLvE3M/DRneZ48TcstMk1rOqrp+C/8SX5Af6Qx
vovVBPfg5KokPSd76NnTZSJT+r8GV67CmoYXfVLsEiCOnAhFPkDAPLe7rhXjl8bg
lwDJuxDk/lSzfZqr9Q+zeeU1qucx5SLx1jMYB1CMMl3c/8+lamlnn/w8iPNar+Y6
MGnT8yyWWd5tAESGkM7wD9agYrJfBQ==
=Y/Qv
-----END PGP SIGNATURE-----

--Sig_/.d=BWJoTy6lPfZL4/CmtHiY--
