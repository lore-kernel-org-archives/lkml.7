Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D8C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7611F2192B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfCWObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:21 -0400
Received: from asrmicro.com ([210.13.118.86]:36844 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:20 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5BN4030920;
        Sat, 23 Mar 2019 22:05:11 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxqeu029573;
        Sat, 23 Mar 2019 21:59:52 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:01:29
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH 1/7] dt-bindings: arm: asr: add ASR8751C bindings
Date:   Sat, 23 Mar 2019 22:01:22 +0800
Message-ID: <1553349688-1946-2-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxqeu029573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add new vendor for ASR and add binding document for ASR8751C SoC and initial
board: aquilac-evb

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 Documentation/devicetree/bindings/arm/asr/asr-8751c.txt | 9 +++++++++
 Documentation/devicetree/bindings/vendor-prefixes.txt   | 1 +
 2 files changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/asr/asr-8751c.txt

diff --git a/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt b/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
new file mode 100644
index 0000000..af7f816
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/asr/asr-8751c.txt
@@ -0,0 +1,9 @@
+ASR 8751C Platforms Device Tree Bindings
+----------------------------------------------------
+ASR 8751C SoC
+Required root node properties:
+	- compatible = ""asr,8751c";
+
+ASR 8751C AquilaC EVB Board
+Required root node properties:
+	- compatible = "asr,aquilac-evb", "asr,8751c";
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0e..3e10f13 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -43,6 +43,7 @@ arrow	Arrow Electronics
 artesyn	Artesyn Embedded Technologies Inc.
 asahi-kasei	Asahi Kasei Corp.
 aspeed	ASPEED Technology Inc.
+asr	ASR Microelectronics(Shanghai) Co., Ltd
 asus	AsusTek Computer Inc.
 atlas	Atlas Scientific LLC
 atmel	Atmel Corporation
-- 
2.7.4

