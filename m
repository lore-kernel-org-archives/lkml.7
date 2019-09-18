Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A414BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F26205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfIRMYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:24:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3765 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730743AbfIRMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:24:46 -0400
X-UUID: b3c0ac18cef64d22b2c299599505bf80-20190918
X-UUID: b3c0ac18cef64d22b2c299599505bf80-20190918
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 267279714; Wed, 18 Sep 2019 20:24:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 18 Sep
 2019 20:24:28 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 18 Sep 2019 20:24:28 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 1/8] dt-bindings: display: panel: Add BOE tv101wum-n16 panel bindings
Date:   Wed, 18 Sep 2019 20:24:15 +0800
Message-ID: <20190918122422.17339-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918122422.17339-1-jitao.shi@mediatek.com>
References: <20190918122422.17339-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24918.004
X-TM-AS-Result: No-2.926200-8.000000-10
X-TMASE-MatchedRID: g25QWLQyM7sib7FbSDtRQ+w8wbnnSw8bPz+fM/byAtnfUZT83lbkEEZU
        qiaZ+o8nezYFSWzv4Aj++vFBYLLFFVE/ARLVFdXa71Wx2uUbPLfaCn4DqCiXNtGSMbwNT3aHNKC
        Fv+lwDDLSPFW/oJh/H4uawHNYVmzLbvzOyKQsPmDJ/bVh4iw9hg/o5bNHEsCT2BYnl9ycTo//Oc
        v2O9Epcqc/H7BUHe1qYxInQdYCzLe+L9dc5lmniijX0ag3hagYOYqKF7UrYh4b0rRLX3vtcFNc7
        vkHlfZ4JxT2+5OcJYqN6fDbnTu0nx8TzIzimOwPFnjKVTYbDMDEQdG7H66TyJ8TMnmE+d0ZYaI6
        7ainkb9LLo/6pJpqUuLKSVM7BWEXUKbHgJS5XNDhk8cFThWH/Y6VcldSdIpNdY2ihywWXnP25Bt
        HS3nmyndkUzTrfJs4nkZgNaqizbL2z+v/HlGkuMCaqSgwpYR4eYa+lS0uTdBWXGvUUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.926200-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24918.004
X-TM-SNTS-SMTP: 445996B6962CBE90720169803D19D7D918F3B1E5E46F20EFBA10854ABFE31E302000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv101wum-n16 panel.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/boe,tv101wum-nl6.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
new file mode 100644
index 000000000000..31d394054181
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,tv101wum-nl6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE TV101WUM-Nl6 DSI Display Panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+  - Rob Herring <robh+dt@kernel.org>
+ 
+properties:
+  compatible:
+        const: boe,tv101wum-nl6
+
+  reg:
+    description: the virtual channel number of a DSI peripheral
+
+  enable-gpios:
+    description: a GPIO spec for the enable pin
+
+  pp1800-supply:
+    description: core voltage supply
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  backlight:
+    description: phandle of the backlight device attached to the panel
+
+required:
+ - compatible
+ - reg
+ - enable-gpios
+ - pp1800-supply
+ - avdd-supply
+ - avee-supply
+ - backlight
+
+additionalProperties: false
+
+examples:
+  - |
+    &dsi {
+        panel@0 {
+            compatible = "boe,tv101wum-nl6";
+            reg = <0>;
+            enable-gpios = <&pio 45 0>;
+            avdd-supply = <&ppvarn_lcd>;
+            avee-supply = <&ppvarp_lcd>;
+            pp1800-supply = <&pp1800_lcd>;
+            backlight = <&backlight_lcd0>;
+            status = "okay";
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
\ No newline at end of file
-- 
2.21.0

