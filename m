Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AF6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81D72071E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 22:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLBWFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 17:05:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:49118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbfLBWFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 17:05:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C093B2EC;
        Mon,  2 Dec 2019 22:05:45 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     Cheng-Yu Lee <cylee12@realtek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC 1/5] dt-bindings: hwlock: Add Realtek RTD1195 SB2
Date:   Mon,  2 Dec 2019 23:05:31 +0100
Message-Id: <20191202220535.6208-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202220535.6208-1-afaerber@suse.de>
References: <20191202220535.6208-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a binding for Realtek RTD1195 SoC's SB2 hardware semaphore.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 .../bindings/hwlock/realtek,rtd1195-sb2-sem.yaml   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml b/Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml
new file mode 100644
index 000000000000..8035af02c667
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/realtek,rtd1195-sb2-sem.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/realtek,rtd1195-sb2-sem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTD1195 SB2 hardware semaphore device tree binding
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+properties:
+  compatible:
+    const: realtek,rtd1195-sb2-sem
+
+  reg:
+    maxItems: 1
+
+  "#hwlock-cells":
+    enum: [ 0, 1 ]
+
+required:
+  - compatible
+  - reg
+  - "#hwlock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hwspinlock@9801a000 {
+      compatible = "realtek,rtd1195-sb2-sem";
+      reg = <0x9801a000 0x4>;
+      #hwlock-cells = <0>;
+    };
+  - |
+    hwspinlock@9801a620 {
+      compatible = "realtek,rtd1195-sb2-sem";
+      reg = <0x9801a620 0x20>;
+      #hwlock-cells = <1>;
+    };
+...
-- 
2.16.4

