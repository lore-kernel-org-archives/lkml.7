Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA3C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A726208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfILJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:04:30 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19093 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730175AbfILJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:04:29 -0400
X-UUID: 23f7e77c5ff4483fa440867fbf5572ec-20190912
X-UUID: 23f7e77c5ff4483fa440867fbf5572ec-20190912
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1012836636; Thu, 12 Sep 2019 17:04:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 Sep
 2019 17:04:09 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 12 Sep 2019 17:04:07 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH 2/3] dt-bindings: display: Add documentation for innolux,p097pfg_ssd2858 panel
Date:   Thu, 12 Sep 2019 17:04:03 +0800
Message-ID: <20190912090404.89822-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912090404.89822-1-jitao.shi@mediatek.com>
References: <20190912090404.89822-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-SNTS-SMTP: A2AD4E9B5BC67489BF1EE305EB0FD902920C5B2551B08E2811322EF05B87C9822000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for innolux,p097pfg panel with bridge chip
ssd2858.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../display/panel/innolux,p097pfg_ssd2858.txt | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt
new file mode 100644
index 000000000000..4ce55e889ad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg_ssd2858.txt
@@ -0,0 +1,39 @@
+SSD2858 bridge + Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
+
+Required properties:
+- compatible: should be "innolux,p097pfg_ssd2858"
+- reg: DSI virtual channel of the peripheral
+- avdd-supply: phandle of the regulator that provides panel positive voltage
+- avee-supply: phandle of the regulator that provides panel negative voltage
+- pp1800-supply: phandle of the regulator that provides panel 1.8V IO power
+- pp3300-supply: phandle of the regulator that provides ssd2858 3.3V URAM power
+- pp1200-bridge-supply: phandle of the regulator that provides ssd2858 1.2V core power
+- vddio-bridge-supply: phandle of the regulator that provides ssd2858 1.8V IO power
+- enable-gpios: panel enable gpio
+
+Optional properties:
+- backlight: phandle of the backlight device attached to the panel
+
+Example:
+
+	&dsi0 {
+		panel: panel@0 {
+			compatible = "innolux,p097pfg_ssd2858";
+			reg = <0>;
+			enable-gpios = <&pio 45 0 &pio 73 0>;
+			avdd-supply = <...>;
+			avee-supply = <...>;
+			pp1800-supply = <...>;
+			pp3300-supply = <...>;
+			pp1200-bridge-supply = <...>;
+			vddio-bridge-supply = <...>;
+			backlight = <&backlight_lcd0>;
+			status = "okay";
+			port {
+				panel_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+		};
+
+	};
-- 
2.21.0

