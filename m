Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B71C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6559621928
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfIRMZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:25:09 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30361 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727000AbfIRMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:25:08 -0400
X-UUID: f339eefe4923486fba72f75c7d7da6b4-20190918
X-UUID: f339eefe4923486fba72f75c7d7da6b4-20190918
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 38987971; Wed, 18 Sep 2019 20:24:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 18 Sep
 2019 20:24:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 18 Sep 2019 20:24:53 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 7/8] dt-bindings: display: panel: add AUO auo,b101uan08.3 panel documentation
Date:   Wed, 18 Sep 2019 20:24:21 +0800
Message-ID: <20190918122422.17339-8-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918122422.17339-1-jitao.shi@mediatek.com>
References: <20190918122422.17339-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24918.004
X-TM-AS-Result: No-3.344400-8.000000-10
X-TMASE-MatchedRID: LDQTIb3AkScn3vOf0l6OFgPZZctd3P4By733NwuklsIHQvT9S3vHUDgK
        6rBjXxyiwmiM4j3WsDwWIvAeOZ6lZBhzK7qAlTSLCLQsumV/5S9V3dLaYUoCPSS30GKAkBxWie3
        MY7Xv0phqry+54H7wDufAOkxShVgK5TDi4+38dPYgCPGiZqtI8Gp5nbEBTsLkrNaeJrYvUQiKWS
        pN2IMPKUPNs5J6pUBWmkLIyx+kbq+tsBhZwL3bDR23b+lJHvPAhdipnqZWlN6LT3esmGQfwEtTy
        K8ZTWCGZI1BYYTjZ96AMuqetGVetr9k4V4N5ceA3QfwsVk0UbsIoUKaF27lxTdnwF1xCHJtKYQO
        AmHjZDgD1LLVoxzeii+xQL3D9tGhAbtmaE6a4AM6sdVOraIqJAq56lBJ3DH63iB0sOu1KWw/OkL
        s4PpignWznloeB3HaPQzwIbfiR5AMD9LTK+5Nny0c7FwZxihenqg/VrSZEiM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.344400-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24918.004
X-TM-SNTS-SMTP: DFD9AD0DC79652028ABED49A663A5FD45074D0DC07093303310F4DADCA87326C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dcumentation for auo,b101uan08.3, which is mipi dsi video panel
and resolution is 1200x1920.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../display/panel/auo,b101uan08.3.yaml        | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml b/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml
new file mode 100644
index 000000000000..96125d7d1fe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/auo,b101uan08.3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AUO B101UAN08.3 DSI Display Panel
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+  - Rob Herring <robh+dt@kernel.org>
+ 
+properties:
+  compatible:
+        const: auo,b101uan08.3
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
+            compatible = "auo,b101uan08.3";
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

