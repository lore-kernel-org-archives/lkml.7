Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B75C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB942467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 07:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTHtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 02:49:25 -0500
Received: from [167.172.186.51] ([167.172.186.51]:59874 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfLTHtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:49:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 962F9DFCB7;
        Fri, 20 Dec 2019 07:49:23 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id KSI7p0ab5b_x; Fri, 20 Dec 2019 07:49:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A1227DFCB3;
        Fri, 20 Dec 2019 07:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oNRIsQf3TfRC; Fri, 20 Dec 2019 07:49:21 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id BB208DFCB1;
        Fri, 20 Dec 2019 07:49:20 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/3] dt-bindings: display: Add Chrontel CH7033 Video Encoder binding
Date:   Fri, 20 Dec 2019 08:49:13 +0100
Message-Id: <20191220074914.249281-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220074914.249281-1-lkundrak@v3.sk>
References: <20191220074914.249281-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for the Chrontel CH7033 VGA/DVI/HDMI Encoder.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../display/bridge/chrontel,ch7033.yaml       | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/chro=
ntel,ch7033.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/chrontel,ch=
7033.yaml b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7=
033.yaml
new file mode 100644
index 0000000000000..f19b336a99c78
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/chrontel,ch7033.ya=
ml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/chrontel,ch7033.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chrontel CH7033 Video Encoder Device Tree Bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  compatible:
+    const: chrontel,ch7033
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description: |
+          Video port for RGB input.
+
+      port@1:
+        type: object
+        description: |
+          DVI port, should be connected to a node compatible with the
+          dvi-connector binding.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    dvi-connector {
+        compatible =3D "dvi-connector";
+        ddc-i2c-bus =3D <&twsi5>;
+        hpd-gpios =3D <&gpio 62 GPIO_ACTIVE_LOW>;
+        digital;
+        analog;
+
+        port {
+            dvi_in: endpoint {
+                remote-endpoint =3D <&encoder_out>;
+            };
+        };
+    };
+
+    vga-dvi-encoder@76 {
+        compatible =3D "chrontel,ch7033";
+        reg =3D <0x76>;
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                endpoint {
+                    remote-endpoint =3D <&lcd0_rgb_out>;
+                };
+            };
+
+            encoder_out: port@1 {
+                reg =3D <1>;
+                endpoint {
+                    remote-endpoint =3D <&dvi_in>;
+                };
+            };
+
+        };
+    };
--=20
2.24.1

