Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AECEC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417002070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KRBcK5Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfF1DzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:55:16 -0400
Received: from ozlabs.org ([203.11.71.1]:35679 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfF1DzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:55:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Zjb42J7Nz9s7h;
        Fri, 28 Jun 2019 13:55:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561694112;
        bh=E7+sBd3+tvi8PaqXxixyn9dYJbuB3JNjSvB/N/pRXdM=;
        h=Date:From:To:Cc:Subject:From;
        b=KRBcK5QaQg/BeZMHLHiq6oklB1jL1crrU34K0LceA0krsh14Kg2l81SZkRLbq6b8N
         wyYYzh22OKBG0fFcRXrqVnquTJjPKI33BjZgniJvy55xJhJoQLHt4b92r+ov5YcoHa
         lWlqvinOByA42DZyjqMWVsWw/yFXJ2ZGTUoX85nXhauX/BEJNWevSutrfRzQTblusU
         qrbZUk5z3K3/YA8t+ItOZzJwJigOD66NOmD8/Vk2VqOKGq8b68nMCC3tET50lJHmim
         yheysdRJcSfHAQMKXVUvR37gFfI0KWGZnputVvg+zKdgpIHzzgh5EOpab/naBh2Uyu
         58uAZRj3pD5AQ==
Date:   Fri, 28 Jun 2019 13:55:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: linux-next: manual merge of the battery tree with the pci tree
Message-ID: <20190628135511.34853c19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bMZKEXnBAx5LYXOGzReQV=g"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bMZKEXnBAx5LYXOGzReQV=g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the battery tree got a conflict in:

  Documentation/power/power_supply_class.txt

between commit:

  151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")

from the pci tree and commit:

  49c9cd95bb6d ("power: supply: add input power and voltage limit propertie=
s")

from the battery tree.

I fixed it up (I deleted the file and adde the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 Jun 2019 13:52:44 +1000
Subject: [PATCH] power: supply: update for conversion to .rst

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/power/power_supply_class.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/power/power_supply_class.rst b/Documentation/pow=
er/power_supply_class.rst
index 3f2c3fe38a61..883b2ef63119 100644
--- a/Documentation/power/power_supply_class.rst
+++ b/Documentation/power/power_supply_class.rst
@@ -166,6 +166,14 @@ INPUT_CURRENT_LIMIT
   input current limit programmed by charger. Indicates
   the current drawn from a charging source.
=20
+INPUT_VOLTAGE_LIMIT
+  input voltage limit programmed by charger. Indicates
+  the voltage limit from a charging source.
+
+INPUT_POWER_LIMIT
+  input power limit programmed by charger. Indicates
+  the power limit from a charging source.
+
 CHARGE_CONTROL_LIMIT
   current charge control limit setting
 CHARGE_CONTROL_LIMIT_MAX
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/bMZKEXnBAx5LYXOGzReQV=g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Vj58ACgkQAVBC80lX
0Gzmzgf/Y+92RSl/KxL8S/LWesEglgsA7dtU1Kfnr4rRxXr0MbFyIrBvAFybdX8B
pdcsL0yR4LwsDCgizL2pdwsTdCashVKoOEnyX4gEYR6UVeFpjCqo7+ERWYNQ5J0u
IcHoAcMQ2d6qDOAakqKU1VFy2BVpC0PM4cp5aIdTxd6Fy8zcdinh4jHTQ5kD/gIK
AS3zy5JoU085x9MzRysjsSt6nJSxR5teaFg+l4VllybFR/j0Xv6YrZ/YK+QVhQ2o
hNoTpYdFIzjWwNjcDeJ099dWe0i60tHCuQoV6AULHQNulbVEEVYQ76HVB+JI16IC
g/sYtOa2UMDX1r35UyBoOuXoQrjUeg==
=fGY/
-----END PGP SIGNATURE-----

--Sig_/bMZKEXnBAx5LYXOGzReQV=g--
