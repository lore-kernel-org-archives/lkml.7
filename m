Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019D42190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfCWObf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:35 -0400
Received: from asrmicro.com ([210.13.118.86]:47298 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWObd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:33 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5MtD031357;
        Sat, 23 Mar 2019 22:05:22 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxrcC029582;
        Sat, 23 Mar 2019 21:59:53 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:01:30
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH 4/7] dt-bindings: serial: add ASR8751C serial bindings
Date:   Sat, 23 Mar 2019 22:01:25 +0800
Message-ID: <1553349688-1946-5-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxrcC029582
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add binding documentation for ASR8751C serial device.

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 .../devicetree/bindings/serial/asr-serial.txt      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/asr-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/asr-serial.txt b/Documentation/devicetree/bindings/serial/asr-serial.txt
new file mode 100644
index 0000000..9e0e191
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/asr-serial.txt
@@ -0,0 +1,23 @@
+* UART Controller of ASR8751C SoCs
+
+Required properties:
+- compatible : should be "asr,uart"
+- reg: iomem address and length of uart registers
+- interrupts : Should be the interrupt number
+- clocks: clock required by uart
+- clock-frequency: frequency of clock source
+- dmas: dma channel used by uart tx or rx
+- dma-names: dma name of uart tx or rx
+
+Example:
+
+	uart0: uart@d4017000 {
+		compatible = "asr,uart";
+		reg = <0xd4017000 0x1000>;
+		interrupts = <0 32 0x4>;
+		clock-frequency = <13000000>;
+		dmas = <&pdma0 AP_UART0_RX 1
+			&pdma0 AP_UART0_TX 1>;
+		dma-names = "rx", "tx";
+		clocks = <&soc_clocks ASR_CLK_UART0>;
+	};
-- 
2.7.4

