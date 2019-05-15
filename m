Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF2C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699ED20879
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 03:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ayDiQn3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEODPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 23:15:23 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:54435 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEODPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 23:15:23 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 746EB83640;
        Wed, 15 May 2019 15:15:18 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557890118;
        bh=ZlRilQpyHzMvCdRuOmJ1KSODQnzCTTyuQ2gSBErg2sU=;
        h=From:To:Cc:Subject:Date;
        b=ayDiQn3jKBXiFRPHo1a7mQQPRNCfYKowYaDh024PiFxjgc/1KvD7DlfNztmSrJ1og
         JTrb3dsF+lHyGM0xoVYtXM1cul7Ew02OD1zIeHopY+zhv8BHJPbhysT0APT0R+BAKa
         +l+Td8Q/lwaYZo74E7nSTf2/zHl057lsc1NiFLuqul79ybT36g8wYAS6EAcDgM1qjA
         fcIw0kaF71Ru5RG62Rf2GetQTa6u+2bI1BVWji7B6LZuZk1lAMptbBJOahBtEenRtC
         ySzw6z6gsnifENa0JviPMMtbjxx9NhnzxrOgRiEt1zkDKuPh3s2ro8BFRQpezLbMSM
         G+QO6IOv56A3g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cdb84420000>; Wed, 15 May 2019 15:15:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id EDB1B13EC46;
        Wed, 15 May 2019 15:15:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 78FE01E1D5B; Wed, 15 May 2019 15:15:16 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] hwmon: (tc654) Update to use SPDX-License-Identifier
Date:   Wed, 15 May 2019 15:15:08 +1200
Message-Id: <20190515031508.30206-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPDX-License-Identifier to the top of the file and remove the
old license boilerplate.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I've gone with GPL-2.0+ because that matches the old text. As the aut=
hor I
    don't mind switching to GPL-2.0 if people want that.

 drivers/hwmon/tc654.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
index 81dd229d7db4..8d0acbf8fbfc 100644
--- a/drivers/hwmon/tc654.c
+++ b/drivers/hwmon/tc654.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * tc654.c - Linux kernel modules for fan speed controller
  *
  * Copyright (C) 2016 Allied Telesis Labs NZ
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
=20
 #include <linux/bitops.h>
--=20
2.21.0

