Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595B92177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 23:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="upyPMan9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbfEWXVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 19:21:47 -0400
Received: from ozlabs.org ([203.11.71.1]:59519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfEWXVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 19:21:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45959g5bGGz9s5c;
        Fri, 24 May 2019 09:21:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558653704;
        bh=T6ekc/MGtCIVUVYB//skznkZYh0QGIVZEjJOl0d4DBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=upyPMan9Rq6/b6aVskcBgN9HXiX8O7EY4+K8Y5JxrOM7MBdqgWSVh2DxV4WSanUBc
         VvaKVaLgAWEgrKs7Z19HKxhiL9UbyO3tYpvqXg89ppsdiFoGf9oFNw4tq0kGOte7us
         RzQb5ulxxsQA81mzWFwT5+KftNAlpkPn6S8Ajs5rXLlOqrdJ9DYlKr32F5xj9fwQtW
         4m1KNaUD5QG2Onyu6lXjsIB78Tc25i4o5ToLZR0VmgZGc/4+STGgi19mAEs2mGnqLR
         kp0nVp+icDzkuSP9kXQ6pAqUu35NtQt+V6tra9d4OYKjckAA4Rfq3DyI8mKXHF24Pk
         rMGsUdeVehH8w==
Date:   Fri, 24 May 2019 09:21:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: linux-next: manual merge of the v4l-dvb tree with Linus' tree
Message-ID: <20190524092125.4ebc4d28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//vSvU6n/=OcUnbshppgiivd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//vSvU6n/=OcUnbshppgiivd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the v4l-dvb tree got a conflict in:

  drivers/media/platform/coda/Makefile

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  94b7ddb91c16 ("media: coda: remove -I$(src) header search path")

from the v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/media/platform/coda/Makefile
index f13adacd924e,3eed82137257..000000000000
--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@@ -1,6 -1,3 +1,5 @@@
 +# SPDX-License-Identifier: GPL-2.0-only
- ccflags-y +=3D -I$(src)
 +
  coda-objs :=3D coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-jpeg.o
 =20
  obj-$(CONFIG_VIDEO_CODA) +=3D coda.o

--Sig_//vSvU6n/=OcUnbshppgiivd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlznKvUACgkQAVBC80lX
0GzAzgf+Jeyk59jpqszwjhCVdTLAfx9dp9f8GwJ1yy5pC5WItANJtp6pA6ej90Tu
8aNwVnYCmaVbwSpImDdSJz6QfhaYzdjKf+aD3u527eL6Ip1elO+cCgKyCbhr8MaI
qio+/KjJgJv01HmfPsBpcxE3dX+/4JfITkT9DmLm2WbHOsONQZi65UPRLP8lfsGR
VQ4pP++9+7kcbaHeRM7GD26+qDhAlxlr+5uBni56DCEIKUTYexKjwDava7KkEKxE
U34sDRWPpLCP7H7ms3yL8cfIQrmfVmLBHyCjUoh3w1FlJMk5lxyrRv1ApDQ+7pZZ
jsl5jN3fHQQ6I7swYZKQJzxx7H6Z6g==
=8ai2
-----END PGP SIGNATURE-----

--Sig_//vSvU6n/=OcUnbshppgiivd--
