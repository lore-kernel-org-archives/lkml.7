Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B529EC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8542133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfDBMgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:36:21 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38714 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbfDBMgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:36:17 -0400
X-UUID: 0c5b94eec23a4ec18e7440be16dbe491-20190402
X-UUID: 0c5b94eec23a4ec18e7440be16dbe491-20190402
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1382522866; Tue, 02 Apr 2019 20:36:10 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Apr 2019 20:36:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Apr 2019 20:36:08 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <xinping.qian@mediatek.com>,
        <liguo.zhang@mediatek.com>, <robh@kernel.org>
Subject: [PATCH RESEND v6 2/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date:   Tue, 2 Apr 2019 20:35:56 +0800
Message-ID: <1554208560-14817-3-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
controller, MT8183 has different registers, offsets, and clock.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index ee4c324..b052f29 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -12,13 +12,15 @@ Required properties:
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
       "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
       "mediatek,mt8173-i2c": for MediaTek MT8173
+      "mediatek,mt8183-i2c": for MediaTek MT8183
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
   - clock-div: the fixed value for frequency divider of clock source in i2c
     module. Each IC may be different.
   - clocks: clock name from clock manager
-  - clock-names: Must include "main" and "dma", if enable have-pmic need include
+  - clock-names: Must include "main" and "dma", "arb" is for multi-master that
+    one bus has more than two i2c controllers, if enable have-pmic need include
     "pmic" extra.
 
 Optional properties:
-- 
1.7.9.5

