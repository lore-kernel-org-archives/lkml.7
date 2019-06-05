Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A31C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7414720872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfFELno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:43:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61628 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727537AbfFELnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:39 -0400
X-UUID: eb367cf3db7e48d5bdea2deeab260d56-20190605
X-UUID: eb367cf3db7e48d5bdea2deeab260d56-20190605
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1175874861; Wed, 05 Jun 2019 19:43:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Jun 2019 19:43:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 5 Jun 2019 19:43:31 +0800
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
Subject: [PATCH v3, 01/27] dt-bindings: mediatek: add binding for mt8183 display
Date:   Wed, 5 Jun 2019 19:42:40 +0800
Message-ID: <1559734986-7379-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1559734986-7379-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
 .../bindings/display/mediatek/mediatek,disp.txt    | 34 +++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 8469de5..70770fe 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -27,20 +27,20 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
 
 Required properties (all function blocks):
 - compatible: "mediatek,<chip>-disp-<function>", one of
-	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
-	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
-	"mediatek,<chip>-disp-wdma"  - write DMA
-	"mediatek,<chip>-disp-color" - color processor
-	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
-	"mediatek,<chip>-disp-gamma" - gamma correction
-	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
-	"mediatek,<chip>-disp-split" - split stream to two encoders
-	"mediatek,<chip>-disp-ufoe"  - data compression engine
-	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
-	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
-	"mediatek,<chip>-disp-mutex" - display mutex
-	"mediatek,<chip>-disp-od"    - overdrive
-  the supported chips are mt2701, mt2712 and mt8173.
+	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
+	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
+	"mediatek,<chip>-disp-wdma"  		- write DMA
+	"mediatek,<chip>-disp-color" 		- color processor
+	"mediatek,<chip>-disp-aal"   		- adaptive ambient light controller
+	"mediatek,<chip>-disp-gamma" 		- gamma correction
+	"mediatek,<chip>-disp-merge" 		- merge streams from two RDMA sources
+	"mediatek,<chip>-disp-split" 		- split stream to two encoders
+	"mediatek,<chip>-disp-ufoe"  		- data compression engine
+	"mediatek,<chip>-dsi"        		- DSI controller, see mediatek,dsi.txt
+	"mediatek,<chip>-dpi"        		- DPI controller, see mediatek,dpi.txt
+	"mediatek,<chip>-disp-mutex" 		- display mutex
+	"mediatek,<chip>-disp-od"    		- overdrive
+  the supported chips are mt2701, mt2712, mt8173 and mt8183.
 - reg: Physical base address and length of the function block register space
 - interrupts: The interrupt signal from the function block (required, except for
   merge and split function blocks).
@@ -71,6 +71,12 @@ mmsys: clock-controller@14000000 {
 	#clock-cells = <1>;
 };
 
+display_components: dispsys@14000000 {
+		compatible = "mediatek,mt8183-display";
+		reg = <0 0x14000000 0 0x1000>;
+		power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+};
+
 ovl0: ovl@1400c000 {
 	compatible = "mediatek,mt8173-disp-ovl";
 	reg = <0 0x1400c000 0 0x1000>;
-- 
1.8.1.1.dirty

