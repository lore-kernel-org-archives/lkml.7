Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED53207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfI0Dt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:49:29 -0400
Received: from mxout2.idt.com ([157.165.5.26]:48800 "EHLO mxout2.idt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfI0Dt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:49:29 -0400
Received: from mail6.idt.com (localhost [127.0.0.1])
        by mxout2.idt.com (8.14.4/8.14.4) with ESMTP id x8R3nE8I012538;
        Thu, 26 Sep 2019 20:49:14 -0700
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail6.idt.com (8.14.4/8.14.4) with ESMTP id x8R3nDNS016042;
        Thu, 26 Sep 2019 20:49:13 -0700
Received: from vcheng-VirtualBox.localdomain (corpimss2.corp.idt.com [157.165.141.30])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id x8R3nBW13322;
        Thu, 26 Sep 2019 20:49:11 -0700 (PDT)
From:   vincent.cheng.xh@renesas.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Vincent Cheng <vincent.cheng.xh@renesas.com>
Subject: [PATCH v2 1/2] dt-bindings: ptp: Add bindings doc for IDT ClockMatrix based PTP clock
Date:   Thu, 26 Sep 2019 23:48:47 -0400
Message-Id: <1569556128-22212-1-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Cheng <vincent.cheng.xh@renesas.com>

Add device tree binding doc for the IDT ClockMatrix PTP clock driver.

Co-developed-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>
---

Changes since v1:
 - No changes
---
 Documentation/devicetree/bindings/ptp/ptp-idtcm.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-idtcm.txt

diff --git a/Documentation/devicetree/bindings/ptp/ptp-idtcm.txt b/Documentation/devicetree/bindings/ptp/ptp-idtcm.txt
new file mode 100644
index 0000000..4eaa34d
--- /dev/null
+++ b/Documentation/devicetree/bindings/ptp/ptp-idtcm.txt
@@ -0,0 +1,15 @@
+* IDT ClockMatrix (TM) PTP clock
+
+Required properties:
+
+  - compatible  Should be "idt,8a3400x-ptp" for System Synchronizer
+                Should be "idt,8a3401x-ptp" for Port Synchronizer
+                Should be "idt,8a3404x-ptp" for Universal Frequency Translator (UFT)
+  - reg         I2C slave address of the device
+
+Example:
+
+	phc@5b {
+		compatible = "idt,8a3400x-ptp";
+		reg = <0x5b>;
+	};
-- 
2.7.4

