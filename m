Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E68C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C05213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IV7sS6Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfGAJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:09:46 -0400
Received: from ozlabs.org ([203.11.71.1]:60429 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbfGAJJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:09:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45chQb09x7z9s00;
        Mon,  1 Jul 2019 19:09:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561972183;
        bh=vmJfcAnvoqHOZoRT+MJCXj2iLUCQNGeOcljg8P1nO30=;
        h=Date:From:To:Cc:Subject:From;
        b=IV7sS6VgqpSDPmUTLLkpYxJWbUgMoRyRi7TQmRg28+2XOzBbbxbZcyl+VsOCUuJQ/
         Ru6M+2KSWHi/+n4+3sY+cS5AOAjxLPcn+Igv2LL4jCrVMD9aBSvMoAl4y5jRDZbGyW
         fBpwQT44poNhbeltlJn5krpJ/veQuQxahb1lIHr/jcw1yEO1Gn/5ZKgM8stXb1jjM9
         WZbxpQoTQoXre/BujPKO4Ig0mD7jks9lhA4ui9l60gqT9O2EcSQxhuyGibqvwkyJ/h
         RNVR2C/D4VJrXx/FMZ24HZ0AmgxQE5PUSZGLgOEiItiH+pmANRJv409rzb/2IrX3IE
         SPksc62IBVu1A==
Date:   Mon, 1 Jul 2019 19:09:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: linux-next: manual merge of the char-misc tree with the driver-core
 tree
Message-ID: <20190701190940.7f23ac15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/w_KPwi04vtaR+bmu90XDEeM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w_KPwi04vtaR+bmu90XDEeM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/hwtracing/coresight/of_coresight.c

between commit:

  418e3ea157ef ("bus_find_device: Unify the match callback with class_find_=
device")

from the driver-core tree and commits:

  22aa495a6477 ("coresight: Rename of_coresight to coresight-platform")
  20961aea982e ("coresight: platform: Use fwnode handle for device search")

from the char-misc tree.

I fixed it up (I removed the file and added the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 1 Jul 2019 19:07:20 +1000
Subject: [PATCH] coresight: fix for "bus_find_device: Unify the match callb=
ack
 with class_find_device"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwtracing/coresight/coresight-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwt=
racing/coresight/coresight-platform.c
index 3c5ceda8db24..fc67f6ae0b3e 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -37,7 +37,7 @@ static int coresight_alloc_conns(struct device *dev,
 	return 0;
 }
=20
-int coresight_device_fwnode_match(struct device *dev, void *fwnode)
+int coresight_device_fwnode_match(struct device *dev, const void *fwnode)
 {
 	return dev_fwnode(dev) =3D=3D fwnode;
 }
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/w_KPwi04vtaR+bmu90XDEeM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0ZzdQACgkQAVBC80lX
0Gwv2Qf9GjZkU2JzPMuJ1xhcyTzOoq6RNWz7LUUaS34qvI4Aou+eQb2xv+/6E5lb
loS5GGUjXBKrlGDEgfkxxuIjEY8y0YPG/kQyhPkYK4JFC/B2B8OjE0iVdxbgqu/Y
9A7vHz6lhAK5mVjFgw1oZnQUL6WywjGoCTtgLzVG/aThKCNVtGE3h/cYHtrFGQuT
uVr1iN2t621lsekTE9IV3y8QUzF58cMVEb2h7GJdS2pfKhQ4MCuYMIOcqWlsq8C7
m7JAGPl+SOXmnfGCwSTcmvbF7GGWyaUvLXpsMpD3IBh1GOTl1YBwDLkic2TKKafY
Y4mKeIXrE4D09M3RSk4dVa+059WVoA==
=/hD3
-----END PGP SIGNATURE-----

--Sig_/w_KPwi04vtaR+bmu90XDEeM--
