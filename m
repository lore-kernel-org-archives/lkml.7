Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DAC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE03205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="O1oJnNw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfFZNdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:33:40 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:9162 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbfFZNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:33:39 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QDTIPI001300;
        Wed, 26 Jun 2019 08:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=6Us5tDDzXDFOeJq95snOZ9NhigO7GlVUE4ERf+4tuUw=;
 b=O1oJnNw0qaxsBqsuxEUbjsBlIqfa+4bB/fqxoQZBryPUDp6/wRudWutQZTQTi/OJ8s5c
 JQ86V8M71fVEThdjE257c9AkBzkLg6pVS1E8aq30M/dv4LEi5L3nHXs0r7EL/51XRQ+n
 QzBCCdnwF6WFcPmgG3Kmndf8Bsw0tS3zUZMpHMEWLJV4ulQTPbSIUjG2gqMJLfdTUzcD
 pEvqfKCAqvLDiXxKC7uBKW8WdRrEAAlNOvZ8JV0BO2NxCknwQ487pAlWV5mM1Fh964YU
 i5HU92RvHzL4/Rfb7hAbAOXllgWVQz1ynbcuVRLk0PxoDFkpsi6pZPk+89RmUpmq7txB 7Q== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2tc7gt871p-1;
        Wed, 26 Jun 2019 08:33:37 -0500
Received: from EDIEX01.ad.cirrus.com (ediex01.ad.cirrus.com [198.61.84.80])
        by mail3.cirrus.com (Postfix) with ESMTP id 0CEC1613DC14;
        Wed, 26 Jun 2019 08:34:25 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 26 Jun
 2019 14:33:36 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 26 Jun 2019 14:33:36 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C3AC44;
        Wed, 26 Jun 2019 14:33:36 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] mfd: madera: Fixup SPDX headers
Date:   Wed, 26 Jun 2019 14:33:36 +0100
Message-ID: <20190626133336.12466-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190626133336.12466-1-ckeepax@opensource.cirrus.com>
References: <20190626133336.12466-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=722 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPL-2.0-only is the preferred way of expressing v2 of the GPL, so switch
to that. Remove some redundant copyright notices and correct some
instances where the wrong comment type has been used in header files.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs47l15-tables.c         | 2 +-
 drivers/mfd/cs47l35-tables.c         | 6 +-----
 drivers/mfd/cs47l85-tables.c         | 6 +-----
 drivers/mfd/cs47l90-tables.c         | 6 +-----
 drivers/mfd/cs47l92-tables.c         | 2 +-
 drivers/mfd/madera-core.c            | 6 +-----
 drivers/mfd/madera-i2c.c             | 6 +-----
 drivers/mfd/madera-spi.c             | 6 +-----
 include/linux/mfd/madera/core.h      | 6 +-----
 include/linux/mfd/madera/pdata.h     | 6 +-----
 include/linux/mfd/madera/registers.h | 6 +-----
 11 files changed, 11 insertions(+), 47 deletions(-)

diff --git a/drivers/mfd/cs47l15-tables.c b/drivers/mfd/cs47l15-tables.c
index 73db8d03b531f..f81b45336690e 100644
--- a/drivers/mfd/cs47l15-tables.c
+++ b/drivers/mfd/cs47l15-tables.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Regmap tables for CS47L15 codec
  *
diff --git a/drivers/mfd/cs47l35-tables.c b/drivers/mfd/cs47l35-tables.c
index fe838cbc2a7ee..a0bc6c5100d63 100644
--- a/drivers/mfd/cs47l35-tables.c
+++ b/drivers/mfd/cs47l35-tables.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Regmap tables for CS47L35 codec
  *
  * Copyright (C) 2015-2017 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/mfd/cs47l85-tables.c b/drivers/mfd/cs47l85-tables.c
index d0198b5e86bac..270d8eda3f5f2 100644
--- a/drivers/mfd/cs47l85-tables.c
+++ b/drivers/mfd/cs47l85-tables.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Regmap tables for CS47L85 codec
  *
  * Copyright (C) 2015-2017 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/mfd/cs47l90-tables.c b/drivers/mfd/cs47l90-tables.c
index 2c761fc241f30..7345fc09c0bb6 100644
--- a/drivers/mfd/cs47l90-tables.c
+++ b/drivers/mfd/cs47l90-tables.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Regmap tables for CS47L90 codec
  *
  * Copyright (C) 2015-2017 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/mfd/cs47l92-tables.c b/drivers/mfd/cs47l92-tables.c
index c8a2343813502..f296e355df4da 100644
--- a/drivers/mfd/cs47l92-tables.c
+++ b/drivers/mfd/cs47l92-tables.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Regmap tables for CS47L92 codec
  *
diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index b9e9c169c6cc7..29540cbf75934 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Core MFD support for Cirrus Logic Madera codecs
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index 3f4ab5dcf5c3d..6b965eb034b6c 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * I2C bus interface to Cirrus Logic Madera codecs
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
index d76c7e7376d7c..e860f5ff09336 100644
--- a/drivers/mfd/madera-spi.c
+++ b/drivers/mfd/madera-spi.c
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * SPI bus interface to Cirrus Logic Madera codecs
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #include <linux/device.h>
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index 7b87f9a02ecc2..7ffa696cce7ca 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * MFD internals for Cirrus Logic Madera codecs
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #ifndef MADERA_CORE_H
diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index dd00ab824e5be..ec0711bcad503 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Platform data for Cirrus Logic Madera codecs
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #ifndef MADERA_PDATA_H
diff --git a/include/linux/mfd/madera/registers.h b/include/linux/mfd/madera/registers.h
index 53c2377b54b29..fe909d1777622 100644
--- a/include/linux/mfd/madera/registers.h
+++ b/include/linux/mfd/madera/registers.h
@@ -1,12 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Madera register definitions
  *
  * Copyright (C) 2015-2018 Cirrus Logic
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #ifndef MADERA_REGISTERS_H
-- 
2.11.0

