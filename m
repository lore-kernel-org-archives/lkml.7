Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA6FC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81BC2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfIPCae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:30:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59465 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728150AbfIPCac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:30:32 -0400
X-UUID: c42f87e619b04d8396740301e9f6e6a9-20190916
X-UUID: c42f87e619b04d8396740301e9f6e6a9-20190916
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1812552000; Mon, 16 Sep 2019 10:30:03 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 10:29:55 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Sep 2019 10:29:55 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, "Jitao Shi" <jitao.shi@mediatek.com>
Subject: [PATCH v5 1/8] dt-bindings: display: panel: Add BOE tv101wum-n16 panel bindings
Date:   Mon, 16 Sep 2019 10:29:34 +0800
Message-ID: <20190916022941.15404-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916022941.15404-1-jitao.shi@mediatek.com>
References: <20190916022941.15404-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24914.001
X-TM-AS-Result: No-3.890900-8.000000-10
X-TMASE-MatchedRID: icpV8lao858ib7FbSDtRQ+w8wbnnSw8bPz+fM/byAtnfUZT83lbkEEZU
        qiaZ+o8nezYFSWzv4Aj++vFBYLLFFSJrrIAyia6MRORIkLq4xDQ5iooXtStiHoRYHyK7IaoJi9w
        qKeXPJfWPlkcXn2IeyAaIRpZxOPntHRgRCLcbWrgvPGk0keCcJR+qR83NNEVKVptCZRwLvQFKj9
        RzqMBfu9CoiCTf1ntP2SPEr0GBThVv+U6cgdvK9b+Kd/geEyt7fS0Ip2eEHnz3IzXlXlpamPoLR
        4+zsDTtWA7iEVqasYbCFTRnL8b7CbZLgBXF/MOuIu1Mbak02eUOhWkWiQMQJH7kr2QIkk2lb9AY
        +7wXzUwMqpepEwpsT5LY/OI5AKdKa/e94QkRN541URakDnXQmkktfpZ7dIYnT2FJac+dZhxC1db
        lKiPrE8C+ksT6a9fy
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.890900-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24914.001
X-TM-SNTS-SMTP: 79BCCA3AC8E06AE64982B5C43B6046DA685819E2D5C8C46CB03FB7D005011D752000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for boe tv101wum-n16 panel.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 .../display/panel/boe,tv101wum-nl6.txt        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
new file mode 100644
index 000000000000..4746ed153507
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.txt
@@ -0,0 +1,34 @@
+Boe Corporation 10.1" WUXGA TFT LCD panel
+
+Required properties:
+- compatible: should be "boe,tv101wum-nl6"
+- reg: the virtual channel number of a DSI peripheral
+- enable-gpios: a gpio spec for the enable pin
+- pp1800-supply: core voltage supply
+- avdd-supply: phandle of the regulator that provides positive voltage
+- avee-supply: phandle of the regulator that provides negative voltage
+- backlight: phandle of the backlight device attached to the panel
+
+The device node can contain one 'port' child node with one child
+'endpoint' node, according to the bindings defined in
+media/video-interfaces.txt. This node should describe panel's video bus.
+
+Example:
+&dsi {
+	...
+	panel@0 {
+		compatible = "boe,tv101wum-nl6";
+		reg = <0>;
+		enable-gpios = <&pio 45 0>;
+		avdd-supply = <&ppvarn_lcd>;
+		avee-supply = <&ppvarp_lcd>;
+		pp1800-supply = <&pp1800_lcd>;
+		backlight = <&backlight_lcd0>;
+		status = "okay";
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&dsi_out>;
+			};
+		};
+	};
+};
-- 
2.21.0

