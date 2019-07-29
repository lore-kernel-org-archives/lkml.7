Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7506C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930F4206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 07:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfG2HBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 03:01:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48608 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727090AbfG2HBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:01:21 -0400
X-UUID: b6171fe7024146d6a35b69c88875ee18-20190729
X-UUID: b6171fe7024146d6a35b69c88875ee18-20190729
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1171082523; Mon, 29 Jul 2019 15:01:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Jul 2019 15:01:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Jul 2019 15:01:09 +0800
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
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v11 02/12] dt-binding: gce: add gce header file for mt8183
Date:   Mon, 29 Jul 2019 15:00:56 +0800
Message-ID: <20190729070106.9332-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190729070106.9332-1-bibby.hsieh@mediatek.com>
References: <20190729070106.9332-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7E251C2001E9EDBA3D2C84C37C510D13F02EAD25AEE9B970D3EE412AB10AA06A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the mt8183 gce.

Add gce header file defined the gce hardware event,
subsys number and constant for mt8183.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mailbox/mtk-gce.txt   |   6 +-
 include/dt-bindings/gce/mt8183-gce.h          | 177 ++++++++++++++++++
 2 files changed, 180 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/gce/mt8183-gce.h

diff --git a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
index cfe40b01d164..1f7f8f2a3f49 100644
--- a/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
+++ b/Documentation/devicetree/bindings/mailbox/mtk-gce.txt
@@ -9,7 +9,7 @@ CMDQ driver uses mailbox framework for communication. Please refer to
 mailbox.txt for generic information about mailbox device-tree bindings.
 
 Required properties:
-- compatible: Must be "mediatek,mt8173-gce"
+- compatible: can be "mediatek,mt8173-gce" or "mediatek,mt8183-gce"
 - reg: Address range of the GCE unit
 - interrupts: The interrupt signal from the GCE block
 - clock: Clocks according to the common clock binding
@@ -28,8 +28,8 @@ Required properties for a client device:
 - mediatek,gce-subsys: u32, specify the sub-system id which is corresponding
   to the register address.
 
-Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'. Such as
-sub-system ids, thread priority, event ids.
+Some vaules of properties are defined in 'dt-bindings/gce/mt8173-gce.h'
+or 'dt-binding/gce/mt8183-gce.h'. Such as sub-system ids, thread priority, event ids.
 
 Example:
 
diff --git a/include/dt-bindings/gce/mt8183-gce.h b/include/dt-bindings/gce/mt8183-gce.h
new file mode 100644
index 000000000000..aeb95154fac2
--- /dev/null
+++ b/include/dt-bindings/gce/mt8183-gce.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Bibby Hsieh <bibby.hsieh@mediatek.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_GCE_MT8183_H
+#define _DT_BINDINGS_GCE_MT8183_H
+
+#define CMDQ_NO_TIMEOUT		0xffffffff
+
+#define CMDQ_THR_MAX_COUNT	24
+
+/* GCE HW thread priority */
+#define CMDQ_THR_PRIO_LOWEST	0
+#define CMDQ_THR_PRIO_HIGHEST	1
+
+/* GCE SUBSYS */
+#define SUBSYS_1300XXXX		0
+#define SUBSYS_1400XXXX		1
+#define SUBSYS_1401XXXX		2
+#define SUBSYS_1402XXXX		3
+#define SUBSYS_1502XXXX		4
+#define SUBSYS_1880XXXX		5
+#define SUBSYS_1881XXXX		6
+#define SUBSYS_1882XXXX		7
+#define SUBSYS_1883XXXX		8
+#define SUBSYS_1884XXXX		9
+#define SUBSYS_1000XXXX		10
+#define SUBSYS_1001XXXX		11
+#define SUBSYS_1002XXXX		12
+#define SUBSYS_1003XXXX		13
+#define SUBSYS_1004XXXX		14
+#define SUBSYS_1005XXXX		15
+#define SUBSYS_1020XXXX		16
+#define SUBSYS_1028XXXX		17
+#define SUBSYS_1700XXXX		18
+#define SUBSYS_1701XXXX		19
+#define SUBSYS_1702XXXX		20
+#define SUBSYS_1703XXXX		21
+#define SUBSYS_1800XXXX		22
+#define SUBSYS_1801XXXX		23
+#define SUBSYS_1802XXXX		24
+#define SUBSYS_1804XXXX		25
+#define SUBSYS_1805XXXX		26
+#define SUBSYS_1808XXXX		27
+#define SUBSYS_180aXXXX		28
+#define SUBSYS_180bXXXX		29
+
+#define CMDQ_EVENT_DISP_RDMA0_SOF					0
+#define CMDQ_EVENT_DISP_RDMA1_SOF					1
+#define CMDQ_EVENT_MDP_RDMA0_SOF					2
+#define CMDQ_EVENT_MDP_RSZ0_SOF						4
+#define CMDQ_EVENT_MDP_RSZ1_SOF						5
+#define CMDQ_EVENT_MDP_TDSHP_SOF					6
+#define CMDQ_EVENT_MDP_WROT0_SOF					7
+#define CMDQ_EVENT_MDP_WDMA0_SOF					8
+#define CMDQ_EVENT_DISP_OVL0_SOF					9
+#define CMDQ_EVENT_DISP_OVL0_2L_SOF					10
+#define CMDQ_EVENT_DISP_OVL1_2L_SOF					11
+#define CMDQ_EVENT_DISP_WDMA0_SOF					12
+#define CMDQ_EVENT_DISP_COLOR0_SOF					13
+#define CMDQ_EVENT_DISP_CCORR0_SOF					14
+#define CMDQ_EVENT_DISP_AAL0_SOF					15
+#define CMDQ_EVENT_DISP_GAMMA0_SOF					16
+#define CMDQ_EVENT_DISP_DITHER0_SOF					17
+#define CMDQ_EVENT_DISP_PWM0_SOF					18
+#define CMDQ_EVENT_DISP_DSI0_SOF					19
+#define CMDQ_EVENT_DISP_DPI0_SOF					20
+#define CMDQ_EVENT_DISP_RSZ_SOF						22
+#define CMDQ_EVENT_MDP_AAL_SOF						23
+#define CMDQ_EVENT_MDP_CCORR_SOF					24
+#define CMDQ_EVENT_DISP_DBI_SOF						25
+#define CMDQ_EVENT_DISP_RDMA0_EOF					26
+#define CMDQ_EVENT_DISP_RDMA1_EOF					27
+#define CMDQ_EVENT_MDP_RDMA0_EOF					28
+#define CMDQ_EVENT_MDP_RSZ0_EOF						30
+#define CMDQ_EVENT_MDP_RSZ1_EOF						31
+#define CMDQ_EVENT_MDP_TDSHP_EOF					32
+#define CMDQ_EVENT_MDP_WROT0_EOF					33
+#define CMDQ_EVENT_MDP_WDMA0_EOF					34
+#define CMDQ_EVENT_DISP_OVL0_EOF					35
+#define CMDQ_EVENT_DISP_OVL0_2L_EOF					36
+#define CMDQ_EVENT_DISP_OVL1_2L_EOF					37
+#define CMDQ_EVENT_DISP_WDMA0_EOF					38
+#define CMDQ_EVENT_DISP_COLOR0_EOF					39
+#define CMDQ_EVENT_DISP_CCORR0_EOF					40
+#define CMDQ_EVENT_DISP_AAL0_EOF					41
+#define CMDQ_EVENT_DISP_GAMMA0_EOF					42
+#define CMDQ_EVENT_DISP_DITHER0_EOF					43
+#define CMDQ_EVENT_DSI0_EOF						44
+#define CMDQ_EVENT_DPI0_EOF						45
+#define CMDQ_EVENT_DISP_RSZ_EOF						47
+#define CMDQ_EVENT_MDP_AAL_EOF						48
+#define CMDQ_EVENT_MDP_CCORR_EOF					49
+#define CMDQ_EVENT_DBI_EOF						50
+#define CMDQ_EVENT_MUTEX_STREAM_DONE0					130
+#define CMDQ_EVENT_MUTEX_STREAM_DONE1					131
+#define CMDQ_EVENT_MUTEX_STREAM_DONE2					132
+#define CMDQ_EVENT_MUTEX_STREAM_DONE3					133
+#define CMDQ_EVENT_MUTEX_STREAM_DONE4					134
+#define CMDQ_EVENT_MUTEX_STREAM_DONE5					135
+#define CMDQ_EVENT_MUTEX_STREAM_DONE6					136
+#define CMDQ_EVENT_MUTEX_STREAM_DONE7					137
+#define CMDQ_EVENT_MUTEX_STREAM_DONE8					138
+#define CMDQ_EVENT_MUTEX_STREAM_DONE9					139
+#define CMDQ_EVENT_MUTEX_STREAM_DONE10					140
+#define CMDQ_EVENT_MUTEX_STREAM_DONE11					141
+#define CMDQ_EVENT_DISP_RDMA0_BUF_UNDERRUN_EVEN				142
+#define CMDQ_EVENT_DISP_RDMA1_BUF_UNDERRUN_EVEN				143
+#define CMDQ_EVENT_DSI0_TE_EVENT					144
+#define CMDQ_EVENT_DSI0_IRQ_EVENT					145
+#define CMDQ_EVENT_DSI0_DONE_EVENT					146
+#define CMDQ_EVENT_DISP_WDMA0_SW_RST_DONE				150
+#define CMDQ_EVENT_MDP_WDMA_SW_RST_DONE					151
+#define CMDQ_EVENT_MDP_WROT0_SW_RST_DONE				152
+#define CMDQ_EVENT_MDP_RDMA0_SW_RST_DONE				154
+#define CMDQ_EVENT_DISP_OVL0_FRAME_RST_DONE_PULE			155
+#define CMDQ_EVENT_DISP_OVL0_2L_FRAME_RST_DONE_ULSE			156
+#define CMDQ_EVENT_DISP_OVL1_2L_FRAME_RST_DONE_ULSE			157
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_0					257
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_1					258
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_2					259
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_3					260
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_4					261
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_5					262
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_6					263
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_7					264
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_8					265
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_9					266
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_10					267
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_11					268
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_12					269
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_13					270
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_14					271
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_15					272
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_16					273
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_17					274
+#define CMDQ_EVENT_ISP_FRAME_DONE_P2_18					275
+#define CMDQ_EVENT_AMD_FRAME_DONE					276
+#define CMDQ_EVENT_DVE_DONE						277
+#define CMDQ_EVENT_WMFE_DONE						278
+#define CMDQ_EVENT_RSC_DONE						279
+#define CMDQ_EVENT_MFB_DONE						280
+#define CMDQ_EVENT_WPE_A_DONE						281
+#define CMDQ_EVENT_SPE_B_DONE						282
+#define CMDQ_EVENT_OCC_DONE						283
+#define CMDQ_EVENT_VENC_CMDQ_FRAME_DONE					289
+#define CMDQ_EVENT_JPG_ENC_CMDQ_DONE					290
+#define CMDQ_EVENT_JPG_DEC_CMDQ_DONE					291
+#define CMDQ_EVENT_VENC_CMDQ_MB_DONE					292
+#define CMDQ_EVENT_VENC_CMDQ_128BYTE_DONE				293
+#define CMDQ_EVENT_ISP_FRAME_DONE_A					321
+#define CMDQ_EVENT_ISP_FRAME_DONE_B					322
+#define CMDQ_EVENT_CAMSV0_PASS1_DONE					323
+#define CMDQ_EVENT_CAMSV1_PASS1_DONE					324
+#define CMDQ_EVENT_CAMSV2_PASS1_DONE					325
+#define CMDQ_EVENT_TSF_DONE						326
+#define CMDQ_EVENT_SENINF_CAM0_FIFO_FULL				327
+#define CMDQ_EVENT_SENINF_CAM1_FIFO_FULL				328
+#define CMDQ_EVENT_SENINF_CAM2_FIFO_FULL				329
+#define CMDQ_EVENT_SENINF_CAM3_FIFO_FULL				330
+#define CMDQ_EVENT_SENINF_CAM4_FIFO_FULL				331
+#define CMDQ_EVENT_SENINF_CAM5_FIFO_FULL				332
+#define CMDQ_EVENT_SENINF_CAM6_FIFO_FULL				333
+#define CMDQ_EVENT_SENINF_CAM7_FIFO_FULL				334
+#define CMDQ_EVENT_IPU_CORE0_DONE0					353
+#define CMDQ_EVENT_IPU_CORE0_DONE1					354
+#define CMDQ_EVENT_IPU_CORE0_DONE2					355
+#define CMDQ_EVENT_IPU_CORE0_DONE3					356
+#define CMDQ_EVENT_IPU_CORE1_DONE0					385
+#define CMDQ_EVENT_IPU_CORE1_DONE1					386
+#define CMDQ_EVENT_IPU_CORE1_DONE2					387
+#define CMDQ_EVENT_IPU_CORE1_DONE3					388
+
+#endif
-- 
2.18.0

