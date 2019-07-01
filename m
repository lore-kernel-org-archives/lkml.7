Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33BDC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B522145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfGAGmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:42:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725616AbfGAGmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:42:12 -0400
X-UUID: 9dafeb1bcff74413b6d2fe727a7d3b41-20190701
X-UUID: 9dafeb1bcff74413b6d2fe727a7d3b41-20190701
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 361156208; Mon, 01 Jul 2019 14:42:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Jul 2019 14:42:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Jul 2019 14:42:04 +0800
From:   <qii.wang@mediatek.com>
To:     <bbrezillon@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-i3c@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <qii.wang@mediatek.com>,
        <matthias.bgg@gmail.com>
Subject: [PATCH] dt-bindings: i3c: cdns: Use correct cells for I2C device
Date:   Mon, 1 Jul 2019 14:42:02 +0800
Message-ID: <1561963322-11513-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qii Wang <qii.wang@mediatek.com>

I2C device reg should be "reg = <0x52 0x0 0x10>;"

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
index 69da211..1cf6182 100644
--- a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
@@ -38,6 +38,6 @@ Example:
 
 		nunchuk: nunchuk@52 {
 			compatible = "nintendo,nunchuk";
-			reg = <0x52 0x80000010 0>;
+			reg = <0x52 0x0 0x10>;
 		};
 	};
-- 
1.7.9.5

