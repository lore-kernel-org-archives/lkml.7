Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB6C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0899921835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfJIHlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:41:17 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25202 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbfJIHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:41:13 -0400
X-UUID: 1c2c8945898f44379b96f4c6da2a9510-20191009
X-UUID: 1c2c8945898f44379b96f4c6da2a9510-20191009
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 712371107; Wed, 09 Oct 2019 15:41:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 9 Oct 2019 15:41:04 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Oct 2019 15:41:03 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v3 03/11] dt-bindings: phy-mtk-tphy: remove unused u3phya_ref clock
Date:   Wed, 9 Oct 2019 15:40:26 +0800
Message-ID: <1570606834-5644-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1570606834-5644-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1570606834-5644-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1720D9286211C13975F0039AA85CB57381AE6118C83D4742D036AE587AC9B3092000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The u3phya_ref clock is already moved into sub-node, and
renamed as ref clock, no used anymore now, so remove it
to avoid confusion

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3: no changes

v2: add Reviewed-by Rob
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index 1f4a36dd80e0..48bc1a2e9299 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -13,10 +13,6 @@ Required properties (controller (parent) node):
 		  "mediatek,mt8173-u3phy";
 		  make use of "mediatek,generic-tphy-v1" on mt2701 instead and
 		  "mediatek,generic-tphy-v2" on mt2712 instead.
- - clocks	: (deprecated, use port's clocks instead) a list of phandle +
-		  clock-specifier pairs, one for each entry in clock-names
- - clock-names	: (deprecated, use port's one instead) must contain
-		  "u3phya_ref": for reference clock of usb3.0 analog phy.
 
 Required nodes	: a sub-node is required for each port the controller
 		  provides. Address range information including the usual
-- 
2.23.0

