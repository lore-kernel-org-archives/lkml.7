Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E764C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA302073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbfDQIrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:47:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:57601 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727013AbfDQIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:47:33 -0400
X-UUID: 7a2fad5d1f404bd384287a1c7bb0f092-20190417
X-UUID: 7a2fad5d1f404bd384287a1c7bb0f092-20190417
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2084934261; Wed, 17 Apr 2019 16:47:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 16:47:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 16:47:25 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <fparent@baylibre.com>, Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH] dt-bindings: spi: spi-mt65xx: add support for MT8516
Date:   Wed, 17 Apr 2019 16:47:16 +0800
Message-ID: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation of spi-mt65xx for MT8516 SOC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 69c3567..c0f6c8e 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -10,6 +10,7 @@ Required properties:
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
+    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
 
 - #address-cells: should be 1.
 
-- 
1.7.9.5

