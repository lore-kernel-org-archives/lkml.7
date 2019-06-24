Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB08C4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BF1206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Wd5IZQ/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfFYAAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:00:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728694AbfFYAAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:00:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XmW15DXgz9s8m;
        Tue, 25 Jun 2019 09:59:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561420797;
        bh=MlRWefn1WQf29R23/74S5YR8kTEjm7BUbnrp4hb4pGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wd5IZQ/TwZDx2wHrneA0oZBPbn144eU7UA14QqvfHVljPGEXvyabBasaKCgT+mRm2
         cS7uOuMg/5aT1DXv7dtFMo0aNoB4RUSMukrGCwh3b8VYQKCLX0sCz7G5hBgJzenJy0
         p+LynBuw7jqCC6sluWhO6gI33XxaSBTZ0EP95g+PWLqAkSvN+lwF3ZXIDJX7wkzNlD
         xIrDVxq5vrwMb27NRo+/9Ht9h1vZ0Ze+4bStfW7wK/xJLwnCuTq1DGFtU5nWf0Wvrb
         4ea1WVAFIumkAPD7VT/oPAyflc/XFrPpmK8BFfy8sBdcTrT3OWv72FzK2OSleV58lm
         S4l7QmUc+cDDQ==
Date:   Tue, 25 Jun 2019 09:59:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the samsung-krzk tree with the
 arm-soc tree
Message-ID: <20190625095957.3b46dad2@canb.auug.org.au>
In-Reply-To: <20190625095906.06c97e0c@canb.auug.org.au>
References: <20190625095906.06c97e0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/j=1nnD556ddK5QITS5c.k+J"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j=1nnD556ddK5QITS5c.k+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 25 Jun 2019 09:59:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the samsung-krzk tree got a conflict in:
>=20
>   arch/arm/configs/s3c6400_defconfig
>=20
> between commit:
>=20
>   6c48edcc955a ("ARM: configs: Remove useless UEVENT_HELPER_PATH")
>=20
> from the arm-soc tree and commit:
>=20
>   5a96019ce5cd ("ARM: defconfig: samsung: Cleanup with savedefconfig")
>=20
> from the samsung-krzk tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/s3c6400_defconfig
index 6eea99300f7f,34f9992ce8e9..000000000000
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@@ -18,9 -15,12 +15,11 @@@ CONFIG_MACH_HMT=3D
  CONFIG_MACH_SMARTQ5=3Dy
  CONFIG_MACH_SMARTQ7=3Dy
  CONFIG_MACH_WLF_CRAGG_6410=3Dy
- CONFIG_AEABI=3Dy
  CONFIG_CMDLINE=3D"console=3DttySAC0,115200 root=3D/dev/ram init=3D/linuxr=
c initrd=3D0x51000000,6M ramdisk_size=3D6144"
  CONFIG_VFP=3Dy
 -CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+ CONFIG_MODULES=3Dy
+ CONFIG_MODULE_UNLOAD=3Dy
+ # CONFIG_BLK_DEV_BSG is not set
  CONFIG_MTD=3Dy
  CONFIG_MTD_RAW_NAND=3Dy
  CONFIG_MTD_NAND_S3C2410=3Dy

--Sig_/j=1nnD556ddK5QITS5c.k+J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0RY/0ACgkQAVBC80lX
0GyPwAf/fkACeIarbbcK2fwJPoxLF6bKdjgUZAHoFGlNpMrB0LvwJ3+lO/zdCrEE
lvMCss4LCr5E4RU9RuD8mG1BRoX2ltGwLcrsZITk8/dK6kd73wm8a/L5mZdk9eyd
+vxUFucdOtb8sB5RDJVfif4cvtJj85vTufKcPxL0tsYylCsiN53Qs1Ru3GT+kjmA
/QJa2hWRornUq953NkCkDJj1dDvNLKqd11XI+nqAmN1Ye1zEoHP4Z3x/MLhyFKuG
IgLDr5wxVlk+5N+vlzOtWCbKVX6aAbvLX70KahFXoHed6yjc/DkKX0ULEjYtZs8P
zgqkg3DWn3BZyB20Wvop8f5NZq7c2A==
=ptDH
-----END PGP SIGNATURE-----

--Sig_/j=1nnD556ddK5QITS5c.k+J--
