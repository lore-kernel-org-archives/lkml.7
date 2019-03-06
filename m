Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3217D213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfCFJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:50:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47271 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728866AbfCFJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:50:44 -0500
X-UUID: 42e6f09927904a28b4c6f445de785950-20190306
X-UUID: 42e6f09927904a28b4c6f445de785950-20190306
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 890644307; Wed, 06 Mar 2019 17:50:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 17:50:38 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 17:50:37 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, <kendrick.hsu@mediatek.com>,
        Frederic Chen <Frederic.Chen@mediatek.com>
Subject: [PATCH v2 03/10] dt-binding: gce: add binding for gce subsys property
Date:   Wed, 6 Mar 2019 17:50:28 +0800
Message-ID: <1551865835-50974-4-git-send-email-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1551865835-50974-1-git-send-email-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmdq driver provide a function that get the relationship
of sub system number from device node for client.
add specification for #subsys-cells, mediatek,gce-subsys.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 Documentation/devicetree/bindings/mailbox/mtk-gce.txt | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index 812698f..07b2adf 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -26,6 +26,13 @@ Required properties:
 	phandle: Label name of a gce node.
 	event_number: the event number defined in 'dt-bindings/gce/mt8173-gce.h'
 		      or 'dt-binding/gce/mt8183-gce.h'.
+#subsys-cells: Should be 2.
+	<&phandle register_base_address subsys_number>
+	phandle: Label name of a gce node.
+	register_base_address: the register base address that client
+			       want to write or read.
+	subsys_number: specify the sub-system id which is corresponding
+		       to the register address.
 
 Required properties for a client device:
 - mboxes: Client use mailbox to communicate with GCE, it should have this
@@ -50,6 +57,7 @@ Example:
 		thread-num = CMDQ_THR_MAX_COUNT;
 		#mbox-cells = <3>;
 		#event-cells = <1>;
+		#subsys-cells = <2>;
 	};
 
 Example for a client device:
@@ -58,7 +66,8 @@ Example for a client device:
 		compatible = "mediatek,mt8173-mmsys";
 		mboxes = <&gce 0 CMDQ_THR_PRIO_LOWEST 1>,
 			 <&gce 1 CMDQ_THR_PRIO_LOWEST 1>;
-		mediatek,gce-subsys = <SUBSYS_1400XXXX>;
+		mediatek,gce-subsys = <&gce 0x14000000 SUBSYS_1400XXXX>,
+				      <&gce 0x14010000 SUBSYS_1401XXXX>;
 		mediatek,gce-event-names = "rdma0_sof",
 					   "rsz0_sof";
 		mediatek,gce-events = <&gce CMDQ_EVENT_MDP_RDMA0_SOF>,
-- 
1.9.1

