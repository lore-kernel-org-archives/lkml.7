Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0516AC4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75082077C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 02:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfIPCaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:30:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39808 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbfIPCaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:30:19 -0400
X-UUID: 3ab4dc6e48524a638730dfc321835554-20190916
X-UUID: 3ab4dc6e48524a638730dfc321835554-20190916
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 482570151; Mon, 16 Sep 2019 10:30:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Sep
 2019 10:30:11 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Sep 2019 10:30:10 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, "Jitao Shi" <jitao.shi@mediatek.com>
Subject: [PATCH v5 7/8] dt-bindings: display: panel: add AUO auo,b101uan08.3 panel documentation
Date:   Mon, 16 Sep 2019 10:29:40 +0800
Message-ID: <20190916022941.15404-8-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916022941.15404-1-jitao.shi@mediatek.com>
References: <20190916022941.15404-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: SMEX-12.5.0.1684-8.5.1010-24914.001
X-TM-AS-Result: No-4.309100-8.000000-10
X-TMASE-MatchedRID: YTzvI92rr1In3vOf0l6OFgPZZctd3P4By733NwuklsIHQvT9S3vHUDgK
        6rBjXxyiwmiM4j3WsDwCBQl2B+K9DUyOkx83/VM/Hbdv6Uke88BUE+MH85/4VPa7agslQWYYTXO
        j1XBAu3Dq/qW/Ghd+7SUJyrN1VessmvwPHdTg3FZqZ6OipRp3etJknNWM2wudUjFJwpdmcrS4jQ
        UH2MU9MGULUrNPkXXmBLbGmf83XzMkqjAuFnBndJ4CIKY/Hg3AGdQnQSTrKGPEQdG7H66TyJ8TM
        nmE+d0ZEU3csG6sUi/t0t7xVBP/YJliqu9HysuRSgtyPPDaBmpzV/XzfPIofBsQaDji93llVqMw
        UBMnm3N/Tt4aX/HW8fgqhcxGRbCankZgNaqizbL2z+v/HlGkuMCaqSgwpYR4eYa+lS0uTdBWXGv
        UUmKP2w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.309100-8.000000
X-TMASE-Version: SMEX-12.5.0.1684-8.5.1010-24914.001
X-TM-SNTS-SMTP: 6C5B8B914B1853EEC219B9B6DFFB7DF9AD0E2EA83787766D2FFFEB08C8DE93822000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dcumentation for auo,b101uan08.3, which is mipi dsi video panel
and resolution is 1200x1920.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 .../display/panel/auo,b101uan08.3.txt         | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.txt

diff --git a/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.txt b/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.txt
new file mode 100644
index 000000000000..7a31cfe534ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,b101uan08.3.txt
@@ -0,0 +1,34 @@
+AUO Corporation 10.1" WUXGA TFT LCD panel
+
+Required properties:
+- compatible: should be "auo,b101uan08.3"
+- reg: the virtual channel number of a DSI peripheral
+- enable-gpios: a GPIO spec for the enable pin
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
+		compatible = "auo,b101uan08.3";
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

