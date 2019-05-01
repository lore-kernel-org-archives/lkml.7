Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC42C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC78F21670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 10:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfEAKYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 06:24:00 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57300 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbfEAKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 06:24:00 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41AJX1q000629;
        Wed, 1 May 2019 05:23:55 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2s6xhv0wsv-1;
        Wed, 01 May 2019 05:23:54 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail2.cirrus.com (Postfix) with ESMTP id 2A86E605A687;
        Wed,  1 May 2019 05:23:54 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 1 May
 2019 11:23:50 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 1 May 2019 11:23:50 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA9412A1;
        Wed,  1 May 2019 11:23:50 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] mfd: lochnagar: Add links to binding docs for sound and hwmon
Date:   Wed, 1 May 2019 11:23:50 +0100
Message-ID: <20190501102350.3520-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=907 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905010069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Add links to the binding documents for the new sound and hardware
monitor parts of the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../devicetree/bindings/mfd/cirrus,lochnagar.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
index 004b0158cf4d7..3bf92ad37fa1b 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
@@ -19,6 +19,8 @@ And these documents for the required sub-node binding details:
   [4] Clock: ../clock/cirrus,lochnagar.txt
   [5] Pinctrl: ../pinctrl/cirrus,lochnagar.txt
   [6] Regulator: ../regulator/cirrus,lochnagar.txt
+  [7] Sound: ../sound/cirrus,lochnagar.txt
+  [8] Hardware Monitor: ../hwmon/cirrus,lochnagar.txt
 
 Required properties:
 
@@ -41,6 +43,11 @@ Optional sub-nodes:
   - Bindings for the regulator components, see [6]. Only available on
     Lochnagar 2.
 
+  - lochnagar-sc : Binding for the sound card components, see [7].
+                   Only available on Lochnagar 2.
+  - lochnagar-hwmon : Binding for the hardware monitor components, see [8].
+                      Only available on Lochnagar 2.
+
 Optional properties:
 
   - present-gpios : Host present line, indicating the presence of a
@@ -65,4 +72,14 @@ lochnagar: lochnagar@22 {
 		compatible = "cirrus,lochnagar-pinctrl";
 		...
 	};
+
+	lochnagar-sc {
+		compatible = "cirrus,lochnagar2-soundcard";
+		...
+	};
+
+	lochnagar-hwmon {
+		compatible = "cirrus,lochnagar2-hwmon";
+		...
+	};
 };
-- 
2.11.0

