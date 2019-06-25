Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E351C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FCD208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CUMIS28l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732473AbfFYPru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:47:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39792 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbfFYPrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:47:49 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5PFhjts017774;
        Tue, 25 Jun 2019 10:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=AU9lgQXgneIvc7cWJxJm5cU7a8ZdhB5OZwaVtO2oiAI=;
 b=CUMIS28lY4HANj3FDmm1kEsCaXAGwGN7TeQvK+poUo1H5F1V68d3fSytyN2rCk+fQdQA
 zMWKyVDGwjOnXDwNBw4MUbWZyE76V9bKrtj3EYcIs/NHDWpuqilQnI4sA7wGm6Lk2yjY
 PLLmMJX8taJMqygmI0oSQZwMJ/rlchQwqg6Cp02QBcKAIMrp3dna7hevQHAq6/JhN8aM
 jpOblrIiqWwtFuKmcjoCvKYgcymDXbsV574y6+69wsRfC0r3lppXC/L4SdcdXPyp6Yi+
 jZOoiaWUQZ+qszZ+ZrMXI8Jlgs/Ym2rCvPAG+9ffvle5SphIkR6vj/BEwcdRXYgsBhmq AQ== 
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2t9grnvx2u-1;
        Tue, 25 Jun 2019 10:47:18 -0500
Received: from EDIEX02.ad.cirrus.com (ediex02.ad.cirrus.com [198.61.84.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 01F7C6121AFE;
        Tue, 25 Jun 2019 10:48:06 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 25 Jun
 2019 16:47:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 25 Jun 2019 16:47:17 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7685244;
        Tue, 25 Jun 2019 16:47:17 +0100 (BST)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] irqchip: madera: Fixup SPDX headers
Date:   Tue, 25 Jun 2019 16:47:17 +0100
Message-ID: <20190625154717.28640-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=710 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPL-2.0-only is the preferred way of expressing v2 of the GPL, update
the code to use this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/irqchip/irq-madera.c       | 2 +-
 include/linux/irqchip/irq-madera.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 8b81271c823c6..6b0457876941d 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Interrupt support for Cirrus Logic Madera codecs
  *
diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
index 1160fa3769ae6..3a46cadd38654 100644
--- a/include/linux/irqchip/irq-madera.h
+++ b/include/linux/irqchip/irq-madera.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Interrupt support for Cirrus Logic Madera codecs
  *
-- 
2.11.0

