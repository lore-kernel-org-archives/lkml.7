Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C55C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7761F21C38
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfFQIPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:15:45 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:52652 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFQIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:15:44 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Td872a1cd5cac14014b1070@ACLMS1.advantech.com.tw>;
 Mon, 17 Jun 2019 16:15:42 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <jia.sui@advantech.com.cn>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v2 7/9] hwmon: (nct7904) Delete wrong comment in function nct7904_write_in.
Date:   Mon, 17 Jun 2019 08:15:26 +0000
Message-ID: <5be014e8e289c615bd9c74321e39484e8f448d8a.1560756733.git.amy.shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
References: <928e46508bbe1ebc0763c3d2403a5aebe95af552.1560756733.git.amy.shih@advantech.com.tw>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.58]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

In function nct7904_write_in, delete wrong comment "Bit 15 is sign bit".

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
Changes in v2:
- Delete wrong comment in function nct7904_write_in.

 drivers/hwmon/nct7904.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 3fa3eb31d176..c74f919c0181 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -581,7 +581,7 @@ static int nct7904_write_in(struct device *dev, u32 attr, int channel,
 	else
 		val = val / 6; /* 0.006V scale */
 
-	val = clamp_val(val, 0, 0x7ff); /* Bit 15 is sign bit */
+	val = clamp_val(val, 0, 0x7ff);
 
 	switch (attr) {
 	case hwmon_in_min:
-- 
2.17.1

