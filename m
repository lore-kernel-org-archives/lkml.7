Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA30C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8FC22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfH2OxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:53:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37019 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726739AbfH2OvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:51:15 -0400
X-UUID: 0250ace5e46b48ac84f223215ffb59d4-20190829
X-UUID: 0250ace5e46b48ac84f223215ffb59d4-20190829
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 752941872; Thu, 29 Aug 2019 22:51:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 29 Aug 2019 22:51:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 29 Aug 2019 22:51:07 +0800
From:   <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5, 01/32] dt-bindings: mediatek: add binding for mt8183 display
Date:   Thu, 29 Aug 2019 22:50:23 +0800
Message-ID: <1567090254-15566-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1567090254-15566-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CD518F2D9425BB27412A521C8A4BF32488C9E74A8EAC953394182163C1A7FC1C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yongqiang Niu <yongqiang.niu@mediatek.com>

Update device tree binding documention for the display subsystem for
Mediatek MT8183 SOCs

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 .../bindings/display/mediatek/mediatek,display.txt  | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt
new file mode 100644
index 0000000..951d2a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,display.txt
@@ -0,0 +1,21 @@
+Mediatek Display Device
+============================
+
+The Mediatek Display Device provides power control to the system.
+
+Required Properties:
+
+- compatible: Should be one of:
+	- "mediatek,mt8183-display"
+
+The Display Device power name are defined in
+include\dt-bindings\power\mt*-power.h
+
+
+Example:
+
+display_components: dispsys@14000000 {
+	compatible = "mediatek,mt8183-display";
+	reg = <0 0x14000000 0 0x1000>;
+	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+};
\ No newline at end of file
-- 
1.8.1.1.dirty

