Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD9CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CADED21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404772AbfJYGNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:13:18 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:39195 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404680AbfJYGNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:13:15 -0400
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Fri, 25 Oct 2019
 14:13:20 +0800
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
Subject: [PATCH v3 2/4] dt-bindings: watchdog: add new binding for meson secure watchdog
Date:   Fri, 25 Oct 2019 14:13:02 +0800
Message-ID: <1571983984-11771-3-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571983984-11771-1-git-send-email-xingyu.chen@amlogic.com>
References: <1571983984-11771-1-git-send-email-xingyu.chen@amlogic.com>
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
 .../bindings/watchdog/amlogic,meson-sec-wdt.yaml   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
new file mode 100644
index 00000000..0bbc807
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
@@ -0,0 +1,34 @@
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
+  secure-monitor:
+    description: phandle to the secure-monitor node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - secure-monitor
+
+examples:
+  - |
+    watchdog {
+          compatible = "amlogic,meson-sec-wdt";
+          secure-monitor = <&sm>;
+    };
-- 
2.7.4

