Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9F1C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0255622BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfGZUzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:55:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34184 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfGZUzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:55:52 -0400
Received: from hades.home (unknown [IPv6:2a00:23c5:58d:db00:68bb:47d:d5ca:9abd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: martyn)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E815828C2D1;
        Fri, 26 Jul 2019 21:55:50 +0100 (BST)
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: Add binding document for NOA1305
Date:   Fri, 26 Jul 2019 21:55:12 +0100
Message-Id: <20190726205513.31291-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the ON Semiconductor NOA1305 ambient light sensor devicetree
bindings.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:
v2: Same as v1.
v3: Same as v2.

 .../bindings/iio/light/noa1305.yaml           | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/noa1305.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/noa1305.yaml b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
new file mode 100644
index 000000000000..17e7f140b69b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/noa1305.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/noa1305.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor NOA1305 Ambient Light Sensor
+
+maintainers:
+  - Martyn Welch <martyn.welch@collabora.com>
+
+description: |
+  Ambient sensing with an i2c interface.
+
+  https://www.onsemi.com/pub/Collateral/NOA1305-D.PDF
+
+properties:
+  compatible:
+    enum:
+      - onnn,noa1305
+
+  reg:
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator that provides power to the sensor
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light@39 {
+                compatible = "onnn,noa1305";
+                reg = <0x39>;
+        };
+    };
+...
-- 
2.20.1

