Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86819C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2321473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="L8PFD9Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBAFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:05:36 -0400
Received: from ozlabs.org ([203.11.71.1]:36993 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGBAFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:05:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d4JF3l1sz9s3Z;
        Tue,  2 Jul 2019 10:05:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562025933;
        bh=cM4qVD6mANTz9SBGygr3+xZdq2SVjFUVmvYKFkaL9NI=;
        h=Date:From:To:Cc:Subject:From;
        b=L8PFD9JebAU+jdQZgTS5BiTWmdPzKuE8z6h1SOSKzOsm8P0oojbTGZUn3prHkHkWL
         pdM1AiI7tv2KV0YYju8yVfA79I/W8Fxr+ANakQp2OZW2tEoMmjEhe4ltqys2hBd1Kz
         pwBp0X9Gpx5EQG/eN9mqvsF6wo/LZm9yPaqEgoe3S8NxoBmvDG6mYewyw3CS/rVsU5
         eJL/bnequdkKnLti32qEVKl4hTgK96wGk/xRRfJEx5Hoyeyu8Zl0XlAbnFH0/e/2nZ
         5kV9yizb9+0CpimG1PcxphvIqyWwFPOJJxRZYfpCs8I2sxNtUKXaWxG788PQjrAmuk
         BznqvhdkyawXQ==
Date:   Tue, 2 Jul 2019 10:05:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the mlx5-next tree
Message-ID: <20190702100533.206ea0df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zHnU9/13EFoNnD84tQbSPRY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zHnU9/13EFoNnD84tQbSPRY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  16fff98a7e82 ("net/mlx5: E-Switch, Reg/unreg function changed event at co=
rrect stage")

Fixes tag

  Fixes: 61fc880839e6 ("net/mlx5: E-Switch, Handle representors creation in=
 handler context")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: ac35dcd6e4bd ("net/mlx5: E-Switch, Handle representors creation in h=
andler context")

--=20
Cheers,
Stephen Rothwell

--Sig_/zHnU9/13EFoNnD84tQbSPRY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0an80ACgkQAVBC80lX
0Gx+4Af/TMAjz5vzCJhN5YA9+d6Mc1MVRKB9FsMSEwHjkEHMZkKw/lGxTatY4vMu
XplUZR0oArqlWZPx9ZEd4GMeU6eBww4qB8UlI0FdD0iOQEuxOxWTdM6OsMRPjVz4
IhLCBtquGFTxO722ExaD+mnXobhckfTamdEztl5g4ZFatJwNO7/d5F6xfhmppezG
nQ8dfrCPj6alMW4cF5GLWZ0rU0+wdyOQyBgJDqPUd2Lys9tJfW3o9O7uYFAtJPaB
RLj4XsqBdzMF8THvw+VC2fU5yO8dRPOYrSzWObUWNmlb/MumaSgyIbe5iBT8zqa+
O8xM1Z6COHAXruoFMq5mgi1FVeDjyg==
=j5up
-----END PGP SIGNATURE-----

--Sig_/zHnU9/13EFoNnD84tQbSPRY--
