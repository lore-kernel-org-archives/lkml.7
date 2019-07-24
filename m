Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4D9C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811702070B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gLcZ5X1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGXJtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:49:23 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6830 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbfGXJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:49:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6O9iw6H028065;
        Wed, 24 Jul 2019 04:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=SixxkbdVbYs1BOlf86+x6cysihoarsZ459XJM+PuVD0=;
 b=gLcZ5X1PzrFzmQblSdEkpJR9u62Ctxcwt3eBIYM4LLkXJskAG7Zd8JYkIHckIE/UDpKc
 4eWFkv66gFvwbA8FNvEmtL0Uro5J5W7sD0TJYW7VeUBCbhfrjcMXvVQAT8e9p2wxaOIp
 PqW8NPj5g46U8mwC5+YmD/VuZaQ+4hiUJmb/ATWoiTPjYaUy2QlLmkUI84gpFRgp8z26
 r5ddOpT7ilBXEUTtXw6OWgTElzjgvWSzDVmPuOoQBIhVspTbVvtyWFmxnNEyGvZlVVoZ
 kX6GM5x6YtKYrYQ524l8y1wQmoxmss4YI4BrfRF+aY1b0f5+fqMFCK5IKcCmhiDKgyaQ Rg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2tx61nh38q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jul 2019 04:49:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 24 Jul
 2019 10:49:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 24 Jul 2019 10:49:14 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 257B045;
        Wed, 24 Jul 2019 10:49:14 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cw00.choi@samsung.com>
CC:     <myungjoo.ham@samsung.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] extcon: arizona: Update binding example to use available defines
Date:   Wed, 24 Jul 2019 10:49:14 +0100
Message-ID: <20190724094914.19284-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=1
 malwarescore=0 lowpriorityscore=0 mlxlogscore=507 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1907240109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/extcon/extcon-arizona.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
index 7f3d94ae81ffb..208daaff0be4f 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-arizona.txt
@@ -72,5 +72,5 @@ codec: wm8280@0 {
 		1 2 1 /* MICDET2 MICBIAS2 GPIO=high */
 	>;
 
-	wlf,gpsw = <0>;
+	wlf,gpsw = <ARIZONA_GPSW_OPEN>;
 };
-- 
2.11.0

