Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498AC47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55986214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfJLDIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:08:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37237 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727896AbfJLDIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:08:00 -0400
X-UUID: cfbfcefb92fc43e5aed137a2b7424aa6-20191012
X-UUID: cfbfcefb92fc43e5aed137a2b7424aa6-20191012
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1211227749; Sat, 12 Oct 2019 11:07:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 12 Oct
 2019 11:07:50 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sat, 12 Oct 2019 11:07:49 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 5/8] dt-bindings: display: panel: add boe tv101wum-n53 panel documentation
Date:   Sat, 12 Oct 2019 11:07:17 +0800
Message-ID: <20191012030720.27127-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012030720.27127-1-jitao.shi@mediatek.com>
References: <20191012030720.27127-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24970.000
X-TM-AS-Result: No-3.344400-8.000000-10
X-TMASE-MatchedRID: LDQTIb3AkScn3vOf0l6OFgPZZctd3P4By733NwuklsIHQvT9S3vHUDgK
        6rBjXxyiwmiM4j3WsDwWIvAeOZ6lZBhzK7qAlTSLCLQsumV/5S9V3dLaYUoCPSS30GKAkBxWie3
        MY7Xv0phqry+54H7wDufAOkxShVgK5TDi4+38dPYgCPGiZqtI8Gp5nbEBTsLkrNaeJrYvUQiKWS
        pN2IMPKUPNs5J6pUBWmkLIyx+kbq+tsBhZwL3bDR23b+lJHvPAhdipnqZWlN6LT3esmGQfwEtTy
        K8ZTWCGZI1BYYTjZ96AMuqetGVetr9k4V4N5ceA3QfwsVk0UbsIoUKaF27lxa+VNt27m34VrKYl
        gqznSc4xP9Zy6unRStfmgibWsLHGTgsevC4sB+C0btMs1U/nhob6DPwnZOM0denzLfRnwSvqqRM
        MGfOl4nWznloeB3HaPQzwIbfiR5AMD9LTK+5Nny0c7FwZxihenqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.344400-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24970.000
X-TM-SNTS-SMTP: 6D9C4C56DB1E911528170B75A9D921C0E5DB4CF1DAD720447BBF5B3C009627462000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dcumentation for boe,tv101wum-n53, which is mipi dsi video panel
and resolution is 1200x1920.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../display/panel/boe,tv101wum-n53.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.yaml
new file mode 100644
index 000000000000..ceeba8d95486
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-n53.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,tv101wum-n53.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE TV101WUM-N53 DSI Display Panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+  - Rob Herring <robh+dt@kernel.org>
+
+properties:
+  compatible:
+        const: boe,tv101wum-n53
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
+            compatible = "boe,tv101wum-n53";
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
-- 
2.21.0

