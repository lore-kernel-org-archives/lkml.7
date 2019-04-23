Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEDBC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDF0206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="StR5fX64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfDWXn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:43:28 -0400
Received: from ozlabs.org ([203.11.71.1]:46743 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfDWXn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:43:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pg4X1Mwqz9sBp;
        Wed, 24 Apr 2019 09:43:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556063004;
        bh=QWu+WtEIZAq1G5Phv/Z94meXESgyJu0ozC9da9dQPFo=;
        h=Date:From:To:Cc:Subject:From;
        b=StR5fX64Ooyc8SWCGimNH2nHTlRJl8zJgFD0gv9zAv4f9o0hG8psXSqL8EeaGhO+X
         K7IOSkmh261qlTTwins3yhhHEsyhp4kmJYI/aDk/WlhzsGvWbI4UKdfz78T4uROOzr
         8PL1FH/YUkoN8sZtdJ0eNNWXtcM4qRqrzOsdq/6cgzeVlxa4YuBdlAQk/bNcwLOlm4
         Ty/g9BJyXtBo96jdmu7bMztHvKSBSaPB4DYh2MPFSO/TLzza1JHjg1Fxm+m8/Qli9K
         mGuF+m/KWCc3PfU7+cdGPpUWtK/A6QZ2qjCJR9fTi24E5h+vlTJAa4z4Uqoix+6D9S
         p8R6sLs1urAaA==
Date:   Wed, 24 Apr 2019 09:43:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: linux-next: manual merge of the tegra tree with the rockchip tree
Message-ID: <20190424094323.0ec123f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1H1Os2kHs_VtJEqpLXx0bwC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1H1Os2kHs_VtJEqpLXx0bwC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tegra tree got a conflict in:

  arch/arm/configs/multi_v7_defconfig

between commit:

  366391f04177 ("ARM: multi_v7_defconfig: Enable missing drivers for suppor=
ted Chromebooks")

from the rockchip tree and commit:

  35f8e2e29e74 ("ARM: multi_v7_defconfig: Update for moved options")

from the tegra tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/multi_v7_defconfig
index 7a288d18e257,88d4da77ae9b..000000000000
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@@ -511,9 -501,6 +509,7 @@@ CONFIG_MFD_AC100=3D
  CONFIG_MFD_AXP20X_I2C=3Dy
  CONFIG_MFD_AXP20X_RSB=3Dy
  CONFIG_MFD_CROS_EC=3Dm
- CONFIG_CROS_EC_I2C=3Dm
- CONFIG_CROS_EC_SPI=3Dm
 +CONFIG_MFD_CROS_EC_CHARDEV=3Dm
  CONFIG_MFD_DA9063=3Dm
  CONFIG_MFD_MAX14577=3Dy
  CONFIG_MFD_MAX77686=3Dy

--Sig_/1H1Os2kHs_VtJEqpLXx0bwC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly/oxsACgkQAVBC80lX
0Gyxvgf+NXaTqz9Kb7T6oNTeED+iHsRaE2EyKJ+L7XcENMrxt/Z42P/HPWvzPjQP
9NxEaH3DCRAM6nXonBg7AQZWnqWtkKikkmgZZypqifvq7G8cs8GDRH8nLaVkl9/I
GqyX0/UVWMQIL6y/yDgp+lFFevUKEIrooXtYkhFZPWbWOSob6lHXYB+m+85gnCqi
5Bed3/Eq7a6sxFqx00HN130UQ9CY5myPEbMDYbJj7stokzo+jx4MCzvAP5gNP4DC
Bf4UX/6flVjJrFOG2NjuTHlLvwru4muAGYjeqDGWTiRZG3hpUZm+N7+bFI084RDF
xED8JR7t2UIV3IYqDjtdLJoNiQu6gw==
=Flao
-----END PGP SIGNATURE-----

--Sig_/1H1Os2kHs_VtJEqpLXx0bwC--
