Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC367CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A70F21D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfJ0O1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:27:09 -0400
Received: from mout.perfora.net ([74.208.4.197]:43423 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfJ0O1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:27:08 -0400
Received: from marcel-nb-toradex-int.toradex.int ([31.10.206.124]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Mhk8L-1icIIn38YF-00Mp4u; Sun, 27 Oct 2019 15:26:31 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     dri-devel@lists.freedesktop.org
Cc:     devicetree@vger.kernel.org, info@logictechno.com,
        j.bauer@endrich.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for logic technologies displays
Date:   Sun, 27 Oct 2019 15:26:09 +0100
Message-Id: <20191027142609.12754-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027142609.12754-1-marcel@ziswiler.com>
References: <20191027142609.12754-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rn2nbHYbKGFtT1kFHLXc+1zL6fferQ0Tgc21oMBgzjMmLxqX4/8
 Jke+6Oj29/ZuQty+9XlPen4JV6zUjbPkz2AClYMOF+B6LIY+vJVEloclw/Mlw8rMvxYAQDt
 r2ZHTi0pFhsckhLRQ/h6ihYC8P4hwL/tu3ABoKv6dkivqhDMw+9iN5BlOWZMl2xVmPr9X3q
 bqzfm1ZOxKmEUAIVQ3g3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1j+F5+geFuU=:u8hBdz9UBSpD9di/H07AHI
 5naIstvX6RNzubf4cSF+27fBnOlD40WkwskXSWgJ7t7XE6nBZlUppPqY6IuqQoU830LjdKfaK
 dWEO/t1NlwP4WZ38v6Hg8U0g8XgBqFroZO8c6la265478CL5Lju9efiSdvl0+WpzHsl4uhLsE
 Dhffq8PkPo5Ify9HF/3wmutBtxUwGNVKr8JCtZNlbi3NWE76s0gWbc6cfYNXVjfGvF/0q1bPq
 ArM3MLPLobEg8LEed1E3OGbFqT7Bncn0axPi1SdhKlb7Qqh7l6n5j8pUyNa+hpXyr7oBz0StF
 G8u65dK2xjJ/LOIM7S4b/ykda4akIXfBCsjyZ+PwEo3b88qXNyEp4SrBdPQdDx9Hlianybn6u
 lJ6/i8cVOscX3iXn8dP4JBzi1T8WJuH9AsAhnPKb5mtHvjSi3YKBnulGe6EStUreQAc2DK5D2
 JllcU6Tb52LgJn2Isk0bHfygBOHRka3HFT3oC/YHu52RjE3txODhtsPeg125tFk4gsRL2bZWF
 KQ6f4YvbF3/ew8BwtBZqif0heMYay9l3hcEb/N5Hx95M19epaLQVXmYBf6CHY2SlSQpdYboTf
 tq74AjuWKq9QUHSJ+HinSCQu7fmZ8eNVcrwx59ejTlDzVNQSJTiIjW0S/bch0/94Qzs2k62aj
 Rfq4COdDRjjG9sH0ZJYen5JqePmTvWHFAEpwFLIdLpGIJnMRcInDY4X5SkK/qkoB9fLdZLxRf
 kDWEEnebBvHfEW+NMKff54GDN9FgpBF3/fyiqfXWryA610OQ4YGlqmdd+KTiYgPz/KBJaoNlY
 fPNhiY/b/J/LoYmFsIL3P1F7zQ3FPAL7o6dcDXxMJeh6suiP0n4HCRnzB/fTR1mWCs7lp56rj
 FVzQn7xqKgfcVyOFKWbKJiVNf8AyMajet2p7sg31Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add bindings for the following 3 previously added display panels
manufactured by Logic Technologies Limited:

- LT161010-2NHC e.g. as found in the Toradex Capacitive Touch Display
7" Parallel [1]
- LT161010-2NHR e.g. as found in the Toradex Resistive Touch Display 7"
Parallel [2]
- LT170410-2WHC e.g. as found in the Toradex Capacitive Touch Display
10.1" LVDS [3]

Those panels may also be distributed by Endrich Bauelemente Vertriebs
GmbH [4].

[1] https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
[2] https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
[3] https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
[4] https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch adding display panel bindings as well as suggested by Rob.

 .../panel/logictechno,lt161010-2nhc.yaml      | 44 +++++++++++++++++++
 .../panel/logictechno,lt161010-2nhr.yaml      | 44 +++++++++++++++++++
 .../panel/logictechno,lt170410-2whc.yaml      | 44 +++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhr.yaml
 create mode 100644 Documentation/devicetree/bindings/display/panel/logictechno,lt170410-2whc.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
new file mode 100644
index 000000000000..0dfe94d38a47
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/logictechno,lt161010-2nhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic Technologies LT161010-2NHC 7" WVGA TFT Cap Touch Module
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Thierry Reding <treding@nvidia.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: logictechno,lt161010-2nhc
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel_rgb: panel {
+      compatible = "logictechno,lt161010-2nhc";
+      backlight = <&backlight>;
+      power-supply = <&reg_3v3>;
+
+      port {
+        panel_in_rgb: endpoint {
+          remote-endpoint = <&controller_out_rgb>;
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhr.yaml b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhr.yaml
new file mode 100644
index 000000000000..ffc97529b068
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logictechno,lt161010-2nhr.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/logictechno,lt161010-2nhr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic Technologies LT161010-2NHR 7" WVGA TFT Resistive Touch Module
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Thierry Reding <treding@nvidia.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: logictechno,lt161010-2nhr
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel_rgb: panel {
+      compatible = "logictechno,lt161010-2nhr";
+      backlight = <&backlight>;
+      power-supply = <&reg_3v3>;
+
+      port {
+        panel_in_rgb: endpoint {
+          remote-endpoint = <&controller_out_rgb>;
+        };
+      };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/logictechno,lt170410-2whc.yaml b/Documentation/devicetree/bindings/display/panel/logictechno,lt170410-2whc.yaml
new file mode 100644
index 000000000000..3606f7fe0dd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/logictechno,lt170410-2whc.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/logictechno,lt170410-2whc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Module
+
+maintainers:
+  - Marcel Ziswiler <marcel.ziswiler@toradex.com>
+  - Thierry Reding <treding@nvidia.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: logictechno,lt170410-2whc
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    lvds_panel: panel {
+      compatible = "logictechno,lt170410-2whc";
+      backlight = <&backlight>;
+      power-supply = <&reg_3v3>;
+
+      port {
+        panel_in_lvds: endpoint {
+          remote-endpoint = <&controller_out_lvds>;
+        };
+      };
+    };
+
+...
-- 
2.21.0

