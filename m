Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64FCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA882173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VyaQYTS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfEVWcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:32:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfEVWcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:32:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 458S6s1K1Nz9s1c;
        Thu, 23 May 2019 08:32:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558564326;
        bh=Knnw+5TsuH3S+QLuWLrTu+e1ww3rqKwPn63Mzwew8G4=;
        h=Date:From:To:Cc:Subject:From;
        b=VyaQYTS3wIlK9ljM4JhLBrbQKbRIVR1ujlrkUS7cT3J3u8O+opigS7uOBGnAmW2+Z
         CqfPvS5XyJ3JfBTX7L70yRF8XgIoVzG+R9ZO0VNvPx4Gd1PB478s+SXMsNrvHxluj+
         hhulUI+WIHMWqUPHAwCeqqEb1isADfpOYmEd4UvMYBG1cAE4XxQUtwN0BgiRfiGg2K
         b51tVAII4noiNfEP4LBxhLDPPKia8WnOJlrtqkKPNRjBxvQ34AYJjY5ceaGd8Km3Bi
         sEM20pcVvcCniRTQ3G3GrUbpjvEVzjfTXu7L/Jv8UqYQdJPvjnuQEZIPjurnQgSY3Q
         AXbX21yvdMBCQ==
Date:   Thu, 23 May 2019 08:32:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Long Cheng <long.cheng@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: linux-next: manual merge of the slave-dma-fixes tree with Linus'
 tree
Message-ID: <20190523083202.7b3df878@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y0mm32AOd6uAGO7GIF.9Izl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y0mm32AOd6uAGO7GIF.9Izl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slave-dma-fixes tree got a conflict in:

  drivers/dma/mediatek/Makefile

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  e8b3ba1e38a2 ("dmaengine: mediatek: Add MediaTek UART APDMA support")

from the slave-dma-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/dma/mediatek/Makefile
index 13b144594510,61a6d29c8e8c..000000000000
--- a/drivers/dma/mediatek/Makefile
+++ b/drivers/dma/mediatek/Makefile
@@@ -1,3 -1,3 +1,4 @@@
 +# SPDX-License-Identifier: GPL-2.0-only
+ obj-$(CONFIG_MTK_UART_APDMA) +=3D mtk-uart-apdma.o
  obj-$(CONFIG_MTK_HSDMA) +=3D mtk-hsdma.o
  obj-$(CONFIG_MTK_CQDMA) +=3D mtk-cqdma.o

--Sig_/Y0mm32AOd6uAGO7GIF.9Izl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzlzeIACgkQAVBC80lX
0GxoEwf/b+3YUGsq6AM1xX1m5GiKTgWrMfZpl/xszpdVYOi60C7YAr1cBcXDvVuT
h0ExyCSsfrp3HS7/0KH7r81rrn0c5sZsgijcbhaIbaMR+D7VnmfepYhwGu8Nt/Zz
5sV3IEwNjORM1/blnB/XmyGuh87howOZgN1NCU/h6nmNbA5F+7ajdT/EX50W9ID1
Bs1VSVk5xEUoeliHj1CQzlK0q7bBFL+LuC263bM3vuF9gboFhgANjac4YcrHIopE
bIBOEi1RMu9NeAYE/6CuVmZOhNeIheNhULe3tekbXb9TNcdo+B3gSzV5ZvXRnMuK
dainXT1r07E4pQrPvXS2dCXAaAVGbQ==
=K++D
-----END PGP SIGNATURE-----

--Sig_/Y0mm32AOd6uAGO7GIF.9Izl--
