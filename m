Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585EBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F86820449
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GnOq1I+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfIDVY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:24:57 -0400
Received: from ozlabs.org ([203.11.71.1]:60585 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDVYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:24:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Nxfr6zCGz9s7T;
        Thu,  5 Sep 2019 07:24:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1567632293;
        bh=eNW/ajGWlMGT2zVfiq0xeHOgrXfvOpoxaZYav5xwi7s=;
        h=Date:From:To:Cc:Subject:From;
        b=GnOq1I+YiwGfEt5b+CaMtK1jV7cV1UguKjuIqk+43im1Ay4a0xZuowEbS/bAhBBPQ
         IVwOHC4K8wnLEh+4zf0qvY+OY7dYtWiZ2pmuOMVxPcXCGkI3LGvEPb6DKRivA4UGq5
         7WtfYn+WVtzFO7bJo65mAfZwPEp/851Z4tnyqHWVJDZdh/SR/OjhGdbKRJtq6R9Brv
         Xep3bKi3wlGTK/upV1tL76sigogceX/ywgMTgenjCIo0us6o3WeXfezGyxARBeHRFn
         xRJTODbKuKZRQ8mvlpmT9Xn+3tdT236U8P2c5HWWe0o+7rbQbxsjLCn4bheEOlO5fs
         4TF1XwFGPgN5g==
Date:   Thu, 5 Sep 2019 07:24:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: linux-next: Fixes tag needs some work in the arm-soc tree
Message-ID: <20190905072443.3ad56568@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p+6iuOX35cArZ+.jsRTBokb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p+6iuOX35cArZ+.jsRTBokb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ca33f735b119 ("arm64: dts: bitmain: Modify pin controller memory map")

Fixes tag

  Fixes: af2ff87de413 ("arm64: dts: bitmain: Add pinctrl support for BM1880=
 SoC")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: c1294fb5cb78 ("arm64: dts: bitmain: Add pinctrl support for BM1880 S=
oC")

--=20
Cheers,
Stephen Rothwell

--Sig_/p+6iuOX35cArZ+.jsRTBokb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1wK5sACgkQAVBC80lX
0GzdrggAg3vj2a2Ve+Vo8eCAp+w/f3bjePQJwGUdAXx2cgmb7och0Ai50pxh9ZyD
eNR5ZWurqd/7OynZCAD/wjtuywU9I5XsEuJIKcR/NLCpMA6tYUsvG0MLdqKrDhsJ
9mP/LI3tXmW/mMhFEtNmwa3aUhQYa/pCddND+Usj5XucunQymGb+Sfbbcsx4I2kX
pKn9uyBt59wu1L0KLL3Ztmmxazb6cI9Gl5rxZCNBtlkIsV62OGTBMUkBQCEeBRM4
Pi5KZn90HZECluYKw8unfrmF4jodLSO+Zi8nNJRJBEPLX9+iE4S6UgBQ5davaBSY
Y6Z7tuQOvr+pjQ5Xemo9Id5ZKqU1pg==
=pIkX
-----END PGP SIGNATURE-----

--Sig_/p+6iuOX35cArZ+.jsRTBokb--
