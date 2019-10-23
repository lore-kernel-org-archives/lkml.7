Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE02CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF416205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404110AbfJWKNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391001AbfJWKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:13:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EAECAB4DF;
        Wed, 23 Oct 2019 10:13:27 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 01/11] dt-bindings: reset: Add Realtek RTD1295
Date:   Wed, 23 Oct 2019 12:13:07 +0200
Message-Id: <20191023101317.26656-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191023101317.26656-1-afaerber@suse.de>
References: <20191023101317.26656-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header with symbolic reset indices for Realtek RTD1295 SoC.
Naming was derived from reset-names in an OEM's Device Tree.

Acked-by: Rob Herring <robh@kernel.org>
[AF: Dropped RTD1295 specific binding definition, updated SPDX]
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v1 -> v2:
 * Dropped textual binding with new compatible
 * Updated SPDX-License-Identifier location
 * Updated to SPDX 2.0
 * Changed from MIT to BSD (Rob)
 
 include/dt-bindings/reset/realtek,rtd1295.h | 111 ++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 include/dt-bindings/reset/realtek,rtd1295.h

diff --git a/include/dt-bindings/reset/realtek,rtd1295.h b/include/dt-bindings/reset/realtek,rtd1295.h
new file mode 100644
index 000000000000..2c0cb6afe816
--- /dev/null
+++ b/include/dt-bindings/reset/realtek,rtd1295.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
+/*
+ * Realtek RTD1295 reset controllers
+ *
+ * Copyright (c) 2017 Andreas Färber
+ */
+#ifndef DT_BINDINGS_RESET_RTD1295_H
+#define DT_BINDINGS_RESET_RTD1295_H
+
+/* soft reset 1 */
+#define RTD1295_RSTN_MISC		0
+#define RTD1295_RSTN_NAT		1
+#define RTD1295_RSTN_USB3_PHY0_POW	2
+#define RTD1295_RSTN_GSPI		3
+#define RTD1295_RSTN_USB3_P0_MDIO	4
+#define RTD1295_RSTN_SATA_0		5
+#define RTD1295_RSTN_USB		6
+#define RTD1295_RSTN_SATA_PHY_0		7
+#define RTD1295_RSTN_USB_PHY0		8
+#define RTD1295_RSTN_USB_PHY1		9
+#define RTD1295_RSTN_SATA_PHY_POW_0	10
+#define RTD1295_RSTN_SATA_FUNC_EXIST_0	11
+#define RTD1295_RSTN_HDMI		12
+#define RTD1295_RSTN_VE1		13
+#define RTD1295_RSTN_VE2		14
+#define RTD1295_RSTN_VE3		15
+#define RTD1295_RSTN_ETN		16
+#define RTD1295_RSTN_AIO		17
+#define RTD1295_RSTN_GPU		18
+#define RTD1295_RSTN_TVE		19
+#define RTD1295_RSTN_VO			20
+#define RTD1295_RSTN_LVDS		21
+#define RTD1295_RSTN_SE			22
+#define RTD1295_RSTN_DCU		23
+#define RTD1295_RSTN_DC_PHY		24
+#define RTD1295_RSTN_CP			25
+#define RTD1295_RSTN_MD			26
+#define RTD1295_RSTN_TP			27
+#define RTD1295_RSTN_AE			28
+#define RTD1295_RSTN_NF			29
+#define RTD1295_RSTN_MIPI		30
+#define RTD1295_RSTN_RSA		31
+
+/* soft reset 2 */
+#define RTD1295_RSTN_ACPU		0
+#define RTD1295_RSTN_JPEG		1
+#define RTD1295_RSTN_USB_PHY3		2
+#define RTD1295_RSTN_USB_PHY2		3
+#define RTD1295_RSTN_USB3_PHY1_POW	4
+#define RTD1295_RSTN_USB3_P1_MDIO	5
+#define RTD1295_RSTN_PCIE0_STITCH	6
+#define RTD1295_RSTN_PCIE0_PHY		7
+#define RTD1295_RSTN_PCIE0		8
+#define RTD1295_RSTN_PCR_CNT		9
+#define RTD1295_RSTN_CR			10
+#define RTD1295_RSTN_EMMC		11
+#define RTD1295_RSTN_SDIO		12
+#define RTD1295_RSTN_PCIE0_CORE		13
+#define RTD1295_RSTN_PCIE0_POWER	14
+#define RTD1295_RSTN_PCIE0_NONSTICH	15
+#define RTD1295_RSTN_PCIE1_PHY		16
+#define RTD1295_RSTN_PCIE1		17
+#define RTD1295_RSTN_I2C_5		18
+#define RTD1295_RSTN_PCIE1_STITCH	19
+#define RTD1295_RSTN_PCIE1_CORE		20
+#define RTD1295_RSTN_PCIE1_POWER	21
+#define RTD1295_RSTN_PCIE1_NONSTICH	22
+#define RTD1295_RSTN_I2C_4		23
+#define RTD1295_RSTN_I2C_3		24
+#define RTD1295_RSTN_I2C_2		25
+#define RTD1295_RSTN_I2C_1		26
+#define RTD1295_RSTN_UR2		27
+#define RTD1295_RSTN_UR1		28
+#define RTD1295_RSTN_MISC_SC		29
+#define RTD1295_RSTN_CBUS_TX		30
+#define RTD1295_RSTN_SDS_PHY		31
+
+/* soft reset 4 */
+#define RTD1295_RSTN_DCPHY_CRT		0
+#define RTD1295_RSTN_DCPHY_ALERT_RX	1
+#define RTD1295_RSTN_DCPHY_PTR		2
+#define RTD1295_RSTN_DCPHY_LDO		3
+#define RTD1295_RSTN_DCPHY_SSC_DIG	4
+#define RTD1295_RSTN_HDMIRX		5
+#define RTD1295_RSTN_CBUSRX		6
+#define RTD1295_RSTN_SATA_PHY_POW_1	7
+#define RTD1295_RSTN_SATA_FUNC_EXIST_1	8
+#define RTD1295_RSTN_SATA_PHY_1		9
+#define RTD1295_RSTN_SATA_1		10
+#define RTD1295_RSTN_FAN		11
+#define RTD1295_RSTN_HDMIRX_WRAP	12
+#define RTD1295_RSTN_PCIE0_PHY_MDIO	13
+#define RTD1295_RSTN_PCIE1_PHY_MDIO	14
+#define RTD1295_RSTN_DISP		15
+
+/* iso reset */
+#define RTD1295_ISO_RSTN_IR		1
+#define RTD1295_ISO_RSTN_CEC0		2
+#define RTD1295_ISO_RSTN_CEC1		3
+#define RTD1295_ISO_RSTN_DP		4
+#define RTD1295_ISO_RSTN_CBUSTX		5
+#define RTD1295_ISO_RSTN_CBUSRX		6
+#define RTD1295_ISO_RSTN_EFUSE		7
+#define RTD1295_ISO_RSTN_UR0		8
+#define RTD1295_ISO_RSTN_GMAC		9
+#define RTD1295_ISO_RSTN_GPHY		10
+#define RTD1295_ISO_RSTN_I2C_0		11
+#define RTD1295_ISO_RSTN_I2C_1		12
+#define RTD1295_ISO_RSTN_CBUS		13
+
+#endif
-- 
2.16.4

