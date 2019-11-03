Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B000CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F9320663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKCBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 21:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfKCBgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAAC3AF26;
        Sun,  3 Nov 2019 01:36:52 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 01/11] dt-bindings: soc: Add Realtek RTD1195 chip info binding
Date:   Sun,  3 Nov 2019 02:36:35 +0100
Message-Id: <20191103013645.9856-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a binding for RTD1195 and later SoCs' chip info registers.
Add the new directory to MAINTAINERS.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Note: The binding gets extended compatibly later for up to three reg entries.
 
 .../bindings/soc/realtek/realtek,rtd1195-chip.yaml | 32 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml

diff --git a/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
new file mode 100644
index 000000000000..565ad2419553
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/realtek/realtek,rtd1195-chip.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Realtek RTD1195 chip identification
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  The Realtek SoCs have some registers to identify the chip and revision.
+
+properties:
+  compatible:
+    const: "realtek,rtd1195-chip"
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    chip-info@1801a200 {
+        compatible = "realtek,rtd1195-chip";
+        reg = <0x1801a200 0x8>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f33adc430230..5c61cf5a44cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2188,6 +2188,7 @@ L:	linux-realtek-soc@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/realtek/
 F:	Documentation/devicetree/bindings/arm/realtek.yaml
+F:	Documentation/devicetree/bindings/soc/realtek/
 
 ARM/RENESAS ARM64 ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
-- 
2.16.4

