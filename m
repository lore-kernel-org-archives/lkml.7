Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E085AC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B887D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 23:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mOfcCydr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfFTXeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 19:34:10 -0400
Received: from ozlabs.org ([203.11.71.1]:47525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfFTXeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 19:34:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VJ722nLwz9s5c;
        Fri, 21 Jun 2019 09:34:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561073647;
        bh=ndWhno4F9OKQyrb9LiFmh3NXDp1/Q19RsftBd8rGACs=;
        h=Date:From:To:Cc:Subject:From;
        b=mOfcCydr2hTTQBsb8wFDNpBbohjJIVEgEt5Jff93A/+V6U4XM8JNrNxJwygGq8/9O
         +LB0m40EwsZ/bQqyYZyM2vJcJQBCSNVR85QJOmHsX9ar75M12/6pT5vPtppo5fDDnj
         thhJJjOHYZlhM0Gpgj0vjYsSujzmdjmmnyB5Qg7j42lxK+RJsV2UINp8xqXQrs0Ny9
         tJrVTHpxOJ+PA3jiXDAj63/2tjGVLcs/0pA6c1x0NgMw500Od+3w0IGiPGGiFkbyIb
         Xr3YGr/bJ+/bY4iHFpW94mke2NjqFQlBYB4Z0WNuAGcCpEWbnUD4jODwPehbQvXt2V
         bMHxq/dPlt5Bw==
Date:   Fri, 21 Jun 2019 09:33:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk@armlinux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: linux-next: manual merge of the samsung-krzk tree with the arm tree
Message-ID: <20190621093347.36987c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/drJXAftZso.P65jPS5fJLqV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/drJXAftZso.P65jPS5fJLqV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the samsung-krzk tree got a conflict in:

  arch/arm/configs/exynos_defconfig

between commit:

  5f41f9198f29 ("ARM: 8864/1: Add workaround for I-Cache line size mismatch=
 between CPU cores")

from the arm tree and commit:

  9f532d26c75c ("ARM: exynos_defconfig: Trim and reorganize with savedefcon=
fig")

from the samsung-krzk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/configs/exynos_defconfig
index 9b959afaaa12,f140532ddca7..000000000000
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@@ -4,12 -5,7 +5,8 @@@ CONFIG_PREEMPT=3D
  CONFIG_CGROUPS=3Dy
  CONFIG_BLK_DEV_INITRD=3Dy
  CONFIG_PERF_EVENTS=3Dy
- CONFIG_MODULES=3Dy
- CONFIG_MODULE_UNLOAD=3Dy
- CONFIG_PARTITION_ADVANCED=3Dy
  CONFIG_ARCH_EXYNOS=3Dy
- CONFIG_ARCH_EXYNOS3=3Dy
 +CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=3Dy
  CONFIG_SMP=3Dy
  CONFIG_BIG_LITTLE=3Dy
  CONFIG_NR_CPUS=3D8

--Sig_/drJXAftZso.P65jPS5fJLqV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MF9sACgkQAVBC80lX
0Gy2pgf+ML0TjxE2m+kPtNCsnUOq/A/U9Cu7T5JMbxQ5dq2EvpthF3e/pM1/hnQj
6C86Jx9HE6Y4miYXkuarQzJKwo9fuwThzaNnkbJOv3a/O75a8zeaxCTxxEe1pNor
Xi4LC1WTmgdyDuFXDnwezxsoQFu1yXf2y28NZ6UJBy3Ady2c6kssZxvq523zGI0z
xCTLtge3YnZB60u/X4Wui17+OFQBDUhkjpoHjZAC4GfcMmFGWg1mxtGNJrI1D4hn
HNm78ClTNQewUob8C80dmQHB0xLLJdrKeLXWf7K1ONByR79TKeOkQI+m8Pmx3oh0
BI7nFLMhEYdamL/yFXJEctd2VoFFVg==
=xLVW
-----END PGP SIGNATURE-----

--Sig_/drJXAftZso.P65jPS5fJLqV--
