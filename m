Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA21C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A062216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 06:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oO58vmbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEIGjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 02:39:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57269 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfEIGjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 02:39:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4503bz41lDz9s9y;
        Thu,  9 May 2019 16:39:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557383983;
        bh=Dy19V1ekO8bMEFYYDG7JNKoKSMUwbDVlOCMCfJEfQl8=;
        h=Date:From:To:Cc:Subject:From;
        b=oO58vmbXKH96T92p+Ai5DX9UCPdNnT23tQCUsWzVMxK+QD2l4YjfOSM8dhP4F56qy
         TalpSbdFZF46HuvMXYmTajZR1DkxDDca9d1CJn0s2Iey/5tuozdL+OccGRGlZoXSEN
         sviOdiUSp0w2Bx4ZQSFBGfGlQL2BoGkuRmR52GAAYPoycgH8eBWimWYVhypphZyN8o
         Yb3FDZCcZbIDtET3gtBeRNI+Z4uwxXLH9LI1CEbRT7a8BzvluwsD/UVmpA9DyMucKy
         4opYe6LllUQ0+tV9c6Mu/ZoGm7N+iJWZTTuXDWameJRuRUKp4A6PebCzWUVRWi/mHM
         THIuupx0UDpWw==
Date:   Thu, 9 May 2019 16:39:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: the merge window is open
Message-ID: <20190509163942.6a233bf4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3ys0XM_FdcHI52m8E1ExmQU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3ys0XM_FdcHI52m8E1ExmQU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v5.3 material to your linux-next included
trees/branches until after v5.2-rc1 has been released.

--=20
Cheers,
Stephen Rothwell

--Sig_/3ys0XM_FdcHI52m8E1ExmQU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzTyy8ACgkQAVBC80lX
0GyK+AgAiMiumY9MMQzlqX7AWpUsxiSqJi0LJP+qIAW8ZtdP7Mzy8k0B94hJgpk/
zNzt1gPYEQoopZsn7do0Aww0uRK642q1DAVORR+qddlrujn/I18EBCDCXutft5PD
sfzEM9cWL35kl8Qhrc7iTTaNdN9W4Bn7RdnDhkh1tL/B/EL1GmBo+u1QUHfKY/Fd
HQsST5CIn1hW4FJI5bnvY3bobN8d99gIPpk/KsOyJsPIOp1IMGeurVjm4W4PSg2e
y2OUv2QKnTguCo8GyKkmPCvNC13t8lR55T04f2+xmvlAscfksytq/uv/BldbOpNE
3uiUdTIn2p+2HRRRreI2aj/h8atyag==
=slrH
-----END PGP SIGNATURE-----

--Sig_/3ys0XM_FdcHI52m8E1ExmQU--
