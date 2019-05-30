Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11139C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24B525B24
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfE3OkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:40:02 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38622 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbfE3OkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:40:01 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UEJ8l1025656;
        Thu, 30 May 2019 09:39:55 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2sq24q6ak4-1;
        Thu, 30 May 2019 09:39:55 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 482BB611E122;
        Thu, 30 May 2019 09:39:55 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 30 May
 2019 15:39:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 30 May 2019 15:39:54 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DD14745;
        Thu, 30 May 2019 15:39:53 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/3] mfd: madera: Update DT bindings to add additional CODECs
Date:   Thu, 30 May 2019 15:39:51 +0100
Message-ID: <20190530143953.25799-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

This adds the cs47l15, cs42l92, cs47l92 and cs47l93 to the list of
compatible strings and updates some properties that need to note
the new CODECs.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/mfd/madera.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
index db3266088386a..cad0f28005027 100644
--- a/Documentation/devicetree/bindings/mfd/madera.txt
+++ b/Documentation/devicetree/bindings/mfd/madera.txt
@@ -11,10 +11,14 @@ bindings/sound/madera.txt
 Required properties:
 
   - compatible : One of the following chip-specific strings:
+        "cirrus,cs47l15"
         "cirrus,cs47l35"
         "cirrus,cs47l85"
         "cirrus,cs47l90"
         "cirrus,cs47l91"
+        "cirrus,cs42l92"
+        "cirrus,cs47l92"
+        "cirrus,cs47l93"
         "cirrus,wm1840"
 
   - reg : I2C slave address when connected using I2C, chip select number when
@@ -22,7 +26,7 @@ Required properties:
 
   - DCVDD-supply : Power supply for the device as defined in
     bindings/regulator/regulator.txt
-    Mandatory on CS47L35, CS47L90, CS47L91
+    Mandatory on CS47L15, CS47L35, CS47L90, CS47L91, CS42L92, CS47L92, CS47L93
     Optional on CS47L85, WM1840
 
   - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
@@ -35,7 +39,7 @@ Required properties:
     (CS47L85, WM1840)
 
   - SPKVDD-supply : Power supply for the device
-    (CS47L35)
+    (CS47L15, CS47L35)
 
   - interrupt-controller : Indicates that this device is an interrupt controller
 
-- 
2.11.0

