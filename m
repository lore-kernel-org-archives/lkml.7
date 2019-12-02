Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83581C43141
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F852084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfLBSWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:22:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:35978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727947AbfLBSWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18A91AE8D;
        Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 06/14] dt-bindings: reset: Add Realtek RTD1195
Date:   Mon,  2 Dec 2019 19:21:56 +0100
Message-Id: <20191202182205.14629-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191202182205.14629-1-afaerber@suse.de>
References: <20191202182205.14629-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header with symbolic reset indices for Realtek RTD1195 SoC.
Naming was derived from BSP register description headers.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1: From RTD1195 v4 series
 
 include/dt-bindings/reset/realtek,rtd1195.h | 74 +++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h

diff --git a/include/dt-bindings/reset/realtek,rtd1195.h b/include/dt-bindings/reset/realtek,rtd1195.h
new file mode 100644
index 000000000000..27902abf935b
--- /dev/null
+++ b/include/dt-bindings/reset/realtek,rtd1195.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+/*
+ * Realtek RTD1195 reset controllers
+ *
+ * Copyright (c) 2017 Andreas Färber
+ */
+#ifndef DT_BINDINGS_RESET_RTD1195_H
+#define DT_BINDINGS_RESET_RTD1195_H
+
+/* soft reset 1 */
+#define RTD1195_RSTN_MISC		0
+#define RTD1195_RSTN_RNG		1
+#define RTD1195_RSTN_USB3_POW		2
+#define RTD1195_RSTN_GSPI		3
+#define RTD1195_RSTN_USB3_P0_MDIO	4
+#define RTD1195_RSTN_VE_H265		5
+#define RTD1195_RSTN_USB		6
+#define RTD1195_RSTN_USB_PHY0		8
+#define RTD1195_RSTN_USB_PHY1		9
+#define RTD1195_RSTN_HDMIRX		11
+#define RTD1195_RSTN_HDMI		12
+#define RTD1195_RSTN_ETN		14
+#define RTD1195_RSTN_AIO		15
+#define RTD1195_RSTN_GPU		16
+#define RTD1195_RSTN_VE_H264		17
+#define RTD1195_RSTN_VE_JPEG		18
+#define RTD1195_RSTN_TVE		19
+#define RTD1195_RSTN_VO			20
+#define RTD1195_RSTN_LVDS		21
+#define RTD1195_RSTN_SE			22
+#define RTD1195_RSTN_DCU		23
+#define RTD1195_RSTN_DC_PHY		24
+#define RTD1195_RSTN_CP			25
+#define RTD1195_RSTN_MD			26
+#define RTD1195_RSTN_TP			27
+#define RTD1195_RSTN_AE			28
+#define RTD1195_RSTN_NF			29
+#define RTD1195_RSTN_MIPI		30
+
+/* soft reset 2 */
+#define RTD1195_RSTN_ACPU		0
+#define RTD1195_RSTN_VCPU		1
+#define RTD1195_RSTN_PCR		9
+#define RTD1195_RSTN_CR			10
+#define RTD1195_RSTN_EMMC		11
+#define RTD1195_RSTN_SDIO		12
+#define RTD1195_RSTN_I2C_5		18
+#define RTD1195_RSTN_RTC		20
+#define RTD1195_RSTN_I2C_4		23
+#define RTD1195_RSTN_I2C_3		24
+#define RTD1195_RSTN_I2C_2		25
+#define RTD1195_RSTN_I2C_1		26
+#define RTD1195_RSTN_UR1		28
+
+/* soft reset 3 */
+#define RTD1195_RSTN_SB2		0
+
+/* iso soft reset */
+#define RTD1195_ISO_RSTN_VFD		0
+#define RTD1195_ISO_RSTN_IR		1
+#define RTD1195_ISO_RSTN_CEC0		2
+#define RTD1195_ISO_RSTN_CEC1		3
+#define RTD1195_ISO_RSTN_DP		4
+#define RTD1195_ISO_RSTN_CBUSTX		5
+#define RTD1195_ISO_RSTN_CBUSRX		6
+#define RTD1195_ISO_RSTN_EFUSE		7
+#define RTD1195_ISO_RSTN_UR0		8
+#define RTD1195_ISO_RSTN_GMAC		9
+#define RTD1195_ISO_RSTN_GPHY		10
+#define RTD1195_ISO_RSTN_I2C_0		11
+#define RTD1195_ISO_RSTN_I2C_6		12
+#define RTD1195_ISO_RSTN_CBUS		13
+
+#endif
-- 
2.16.4

