Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38FB217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UJtbp+GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfE1Vs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:48:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1Vs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:48:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45D6sb6HZBz9s5c;
        Wed, 29 May 2019 07:48:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559080105;
        bh=f6MQvnd2Z2LMquE6A4O+dZA9a/E+daW2j8qTlCCoZyw=;
        h=Date:From:To:Cc:Subject:From;
        b=UJtbp+GA8fxKXd+0GwhIDog4CB3ZR9jJrKt380DxHVm2FFOW9NJE54eTaDNGwkTDy
         4s0wGRZdsTdWKoR11xm4EF95/Hsv9NaFVIabx4TNrUZ8Mgc/Uz21XyhgrvocvrnPyM
         Pa3OLW4CKAsqVckfQceNcbpGQUNsEOq6CeKt13vgThUV/T16pQbHeOpggTO/EyF8Mk
         GE6Qdgb69N1oeyakXUF+yNveb6SeyqoDmKcINoDSYx823DOkKDDLAB7PpxKGj4VOHG
         HiuB/vtbXVkS4KczhAo8kCuzadM3exM6EA7feVbVbOLe/a0OtLUYKJcvkY7/dEfQK9
         lfXE2owyGaQdw==
Date:   Wed, 29 May 2019 07:48:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Sowden <jeremy@azazel.net>
Subject: linux-next: Fixes tag needs some work in the ipsec tree
Message-ID: <20190529074812.00c8df44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/t68a.7rqE3KQABLBwq1dh39"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t68a.7rqE3KQABLBwq1dh39
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steffen,

In commit

  7c80eb1c7e2b ("af_key: fix leaks in key_pol_get_resp and dump_sp.")

Fixes tag

  Fixes: 55569ce256ce ("Fix conversion between IPSEC_MODE_xxx and XFRM_MODE=
_xxx.")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/t68a.7rqE3KQABLBwq1dh39
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlztrJwACgkQAVBC80lX
0GxuXAf9Hh415uZ2vKeIAQ4ICsK3TgMdgl6omZ92f3gE0vTerrGpw9weux9qf18o
JR10zdcusb1hVJ8BReB+h8j5yyQqsRIgtVvjvNDubknk4gr/LIh3fkvnIY9eX3cm
D/1O2hfie0Z6Xk9an1RkHq8WuTLjnoGUamv21OxDBVJQ7z+LwceZp43E+kHCVqYd
llrgDPCu/9xJ0DOEghfxGOfviDGcJnVP8Tph+BKq0ArYcEdhINmS/GV/aJpA29gH
LkTL9cyd2g73jN6J3ncHj+PzvoRtgbDj67Rx87xNQZa2VjCF1tUGqG8QhKekY+zp
mvC9jlcaYFtnJvo6erw5FqGcMCUV+Q==
=2q9e
-----END PGP SIGNATURE-----

--Sig_/t68a.7rqE3KQABLBwq1dh39--
