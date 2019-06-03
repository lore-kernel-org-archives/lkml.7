Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865B7C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCD6270FD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 06:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfFCGsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 02:48:00 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43713 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727268AbfFCGrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 02:47:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0843899|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.425534-0.023847-0.550619;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.EglnAtr_1559544454;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EglnAtr_1559544454)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 03 Jun 2019 14:47:34 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Rob Herring <robh+dt@kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH V3 4/6] dt-bindings: csky: Add csky PMU bindings
Date:   Mon,  3 Jun 2019 14:46:23 +0800
Message-Id: <bb3a684599185ff30e11fa6cd82a44932e61e9ef.1559544301.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559544301.git.han_mao@c-sky.com>
References: <cover.1559544301.git.han_mao@c-sky.com>
In-Reply-To: <cover.1559544301.git.han_mao@c-sky.com>
References: <cover.1559544301.git.han_mao@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the documentation to describe that how to add pmu node in
dts.

Signed-off-by: Mao Han <han_mao@c-sky.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
---
 Documentation/devicetree/bindings/csky/pmu.txt | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/csky/pmu.txt

diff --git a/Documentation/devicetree/bindings/csky/pmu.txt b/Documentation/devicetree/bindings/csky/pmu.txt
new file mode 100644
index 0000000..4046b3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/csky/pmu.txt
@@ -0,0 +1,38 @@
+============================
+C-SKY Performance Monitor Units
+============================
+
+C-SKY 8xx series cores often have a PMU for counting cpu and cache events.
+The C-SKY PMU representation in the device tree should be done as under:
+
+==============================
+PMU node bindings definition
+==============================
+
+	Description: Describes PMU
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,csky-pmu"
+	- interrupts
+		Usage: required
+		Value type: <u32>
+		Definition: must be pmu irq num defined by soc
+	- reg-io-width
+		Usage: optional
+		Value type: <u32>
+		Definition: the width of pmu counter
+
+Examples:
+---------
+
+        pmu {
+                compatible = "csky,csky-pmu";
+                interrupts = <0x17 IRQ_TYPE_EDGE_RISING>;
+                interrupt-parent = <&intc>;
+		reg-io-width = <0x30>;
+        };
+
-- 
2.7.4

