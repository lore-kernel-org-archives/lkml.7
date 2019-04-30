Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7EFC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A636A21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfD3Jp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:45:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42401 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727031AbfD3Jp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:45:29 -0400
X-UUID: 929360a7b50240acaf340d79ed27065e-20190430
X-UUID: 929360a7b50240acaf340d79ed27065e-20190430
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 876151854; Tue, 30 Apr 2019 17:45:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 30 Apr 2019 17:45:20 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 30 Apr 2019 17:45:20 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC V2 09/11] dt-bindings: interconnect: Add header for interconnect node
Date:   Tue, 30 Apr 2019 16:51:03 +0800
Message-ID: <1556614265-12745-10-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header file for mt8183 interconnect node that could be shared between
the interconeect provider driver and Device Tree source files.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 include/dt-bindings/interconnect/mtk,mt8183.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/mtk,mt8183.h

diff --git a/include/dt-bindings/interconnect/mtk,mt8183.h b/include/dt-bindings/interconnect/mtk,mt8183.h
new file mode 100644
index 0000000..34adbfa
--- /dev/null
+++ b/include/dt-bindings/interconnect/mtk,mt8183.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT8183_H
+#define __DT_BINDINGS_INTERCONNECT_MTK_MT8183_H
+
+#define SLAVE_DDR_EMI			0
+#define MASTER_MCUSYS			1
+#define MASTER_GPU			2
+#define MASTER_MMSYS			3
+#define MASTER_MM_VPU			4
+#define MASTER_MM_DISP			5
+#define MASTER_MM_VDEC			6
+#define MASTER_MM_VENC			7
+#define MASTER_MM_CAM			8
+#define MASTER_MM_IMG			9
+#define MASTER_MM_MDP			10
+
+#endif
-- 
1.9.1

