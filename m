Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20741C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D72190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EHyw4e57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCUXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:53:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:44575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfCUXxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553212372;
        bh=KvMXmUIknsxmOD93e4AfGwjNqhHVey3dIGojC8KMH6A=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=EHyw4e57dHq8DS7yvsre1vpzbBUXAOVJ38BC1pxV+eGfFgegU3F2XB1RCpY0qlLS/
         pBccOzRUHH9D8fR0Y6xUl1pqpPVITR2B0pLjx2Jlt8z+CcmFR6tr6ucerKUkCR87Hv
         BWER7xXzAtTB5Xeqm/Uweo/HLGN/ve/0J/uwOI+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDymt-1hDR9f1Tih-00HNbY; Fri, 22
 Mar 2019 00:52:52 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Fix sphinx syntax
Date:   Fri, 22 Mar 2019 00:52:41 +0100
Message-Id: <20190321235242.32158-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0AaLLJgmSTpYH9NYOZvdnVlm7P1tfYcngyPtOXxJj1wMzdJMd27
 UXesPorUZkzGiQPoVStWGH5S+wlNuSzfeo4WzcpXKxGhs1MH49tq6dsEh7Z0zVUwrC0YoSJ
 PZNcTjzdCxUajsL+Btl6CZaWby7GlLfQRJwQpMA36yyRggAaseLPWipZmyGkcXzK0EXgNhw
 44aV7qNbqZDDlnrX7VpIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iq4lttArJ0Q=:u1awK5EQ4/0I2xq7k3EcFk
 GbPzDvNWYirNcVPtAR4tDGAuzDXgYv3jHmsNqbH2NJwbUWiEIR5Y4wxmFxGdUftcose0vp/QG
 rdPX6OtCvFE/C+m9L0TKvgHAxLSnnJwHwXYSbtRyTQ8Yof8cy8Y8BgAj4d2iZ1X2ObTSOhsi1
 JZOqOr54uAB6kWmvKtpVNBQ8MelYP+GUPuT6AbDe+xOzUIWcOS2PWM8PUi7+vZVZ1vydC7gt3
 cDTJwWGbSlt3RDlLEpZTfrS/LvkCuzU+GeqhJRvLin0RbhkkI/AGyyksCUbHeEJZ96VwrZu//
 YkqCQG3Rw5OSoyGDykU+2GAO2bgPr7Ihh0qFygGbAqnDvwgykyuh7Id6zHf2J3F4dQZUy4Yk8
 NEiU4MJTEa1xlM2guOWhpxKIX3EmtAh5H7K93Eke3HYCzuOnEh+GoPxPgmnU2DhZSyCGK+MTO
 kIJPGDOasZB8NXGZdXHSRr2HIVqKLkkqWM+zKbRjwYunqFOFlcl5JVpVgAyTtjA+a4KPiEriw
 8YqfDr8cChcVi6UuyH0LN+3kiUvnnoxGIcv+eUlHTycMnE1YMpbifI+02z31+Ugc5KzVa+9/O
 1/J7biJGKEfukr0q4k1RukkJBrddOcz2a71V08rmLiriPwfYYQ6WfOk5yQIinob9yUeWg95j1
 WvKVs5EYpBihrQIk2nignfPlt7w5387ZboGw9rciIEeTmWN00R6tKKQ8ykQ1w8HqJSc8EaBDR
 3z6I/Q8KxeD5Vd+SAtXTyQO2BRlyOAzjO8JR8NWFnn5gU7OLfdwgwaz33Pcs6E2cTaVRdirVu
 y7c71WkZCZJAYZBtTpCdWoufVpIPcqZ8I1G9yTZJ6WOSdjdcy4zdZa1CDWK2KwDk7xgjIkb4K
 NhrbAmoHXGaNNO91NdpEblq9zlyBk2gw90D9vfdlEVZD+z3oiqNjrVRMgnYgr5MD9mNdW4398
 huC0rOYyiLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx doesn't handle expressions in identifier references.

This fixes the following warnings:

./include/linux/mtd/rawnand.h:1184: WARNING: Inline strong start-string wi=
thout end-string.
./include/linux/mtd/rawnand.h:1186: WARNING: Inline strong start-string wi=
thout end-string.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/mtd/rawnand.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b7445a44a814..27c2db8e4a1f 100644
=2D-- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1180,9 +1180,9 @@ static inline void *nand_get_manufacturer_data(struc=
t nand_chip *chip)
  * @name: a human-readable name of the NAND chip
  * @dev_id: the device ID (the second byte of the full chip ID array)
  * @mfr_id: manufecturer ID part of the full chip ID array (refers the sa=
me
- *          memory address as @id[0])
+ *          memory address as ``id[0]``)
  * @dev_id: device ID part of the full chip ID array (refers the same mem=
ory
- *          address as @id[1])
+ *          address as ``id[1]``)
  * @id: full device ID array
  * @pagesize: size of the NAND page in bytes; if 0, then the real page si=
ze (as
  *            well as the eraseblock size) is determined from the extende=
d NAND
=2D-
2.20.1

