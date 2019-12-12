Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AC7C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7794721655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfLLMUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:20:13 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:53857 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfLLMUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:20:11 -0500
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Thu, 12 Dec 2019
 20:20:37 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: watchdog: add new binding for meson secure watchdog
Date:   Thu, 12 Dec 2019 20:19:45 +0800
Message-ID: <1576153187-28378-3-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576153187-28378-1-git-send-email-xingyu.chen@amlogic.com>
References: <1576153187-28378-1-git-send-email-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding targets the Meson-A/C series compatible SoCs, in which the
watchdog registers are in secure world.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
---
 .../bindings/watchdog/amlogic,meson-sec-wdt.yaml   | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
new file mode 100644
index 00000000..c0ff2ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+# Copyright (c) 2019 Amlogic, Inc
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/amlogic,meson-sec-wdt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic Meson Secure Watchdog Timer
+
+maintainers:
+  - Xingyu Chen <xingyu.chen@amlogic.com>
+
+description: |+
+  Secure Watchdog Timer used in Meson-A/C series Compatible SoCs
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-sec-wdt
+
+  timeout-sec:
+    minimum: 1
+    maximum: 65
+    description:
+      Watchdog timeout values (in seconds)
+
+required:
+  - compatible
+
+examples:
+  - |
+    watchdog {
+          compatible = "amlogic,meson-sec-wdt";
+          timeout-sec = <60>;
+    };
-- 
2.7.4

