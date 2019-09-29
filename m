Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB78C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20520863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 06:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfI2GYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 02:24:24 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:15311 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfI2GYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 02:24:23 -0400
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Sun, 29 Sep 2019
 14:24:19 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: reset: add bindings for the Meson-A1 SoC Reset Controller
Date:   Sun, 29 Sep 2019 14:24:14 +0800
Message-ID: <1569738255-3941-3-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
References: <1569738255-3941-1-git-send-email-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Meson-A1 SoC Reset Controller include file,
and also slightly update documentation.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
---
 .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
 include/dt-bindings/reset/amlogic,meson-a1-reset.h | 74 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
index 00917d8..b3f57d8 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
@@ -16,6 +16,7 @@ properties:
       - amlogic,meson8b-reset # Reset Controller on Meson8b and compatible SoCs
       - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatible SoCs
       - amlogic,meson-axg-reset # Reset Controller on AXG and compatible SoCs
+      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible SoCs
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/reset/amlogic,meson-a1-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
new file mode 100644
index 00000000..f1a3a79
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-a1-reset.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ *
+ * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_A1_RESET_H
+
+/*	RESET0					*/
+/*					0	*/
+#define RESET_AM2AXI_VAD		1
+/*					2-3	*/
+#define RESET_PSRAM			4
+#define RESET_PAD_CTRL			5
+/*					6	*/
+#define RESET_TEMP_SENSOR		7
+#define RESET_AM2AXI_DEV		8
+/*					9	*/
+#define RESET_SPICC_A			10
+#define RESET_MSR_CLK			11
+#define RESET_AUDIO			12
+#define RESET_ANALOG_CTRL		13
+#define RESET_SAR_ADC			14
+#define RESET_AUDIO_VAD			15
+#define RESET_CEC			16
+#define RESET_PWM_EF			17
+#define RESET_PWM_CD			18
+#define RESET_PWM_AB			19
+/*					20	*/
+#define RESET_IR_CTRL			21
+#define RESET_I2C_S_A			22
+/*					23	*/
+#define RESET_I2C_M_D			24
+#define RESET_I2C_M_C			25
+#define RESET_I2C_M_B			26
+#define RESET_I2C_M_A			27
+#define RESET_I2C_PROD_AHB		28
+#define RESET_I2C_PROD			29
+/*					30-31	*/
+
+/*	RESET1					*/
+#define RESET_ACODEC			32
+#define RESET_DMA			33
+#define RESET_SD_EMMC_A			34
+/*					35	*/
+#define RESET_USBCTRL			36
+/*					37	*/
+#define RESET_USBPHY			38
+/*					39-41	*/
+#define RESET_RSA			42
+#define RESET_DMC			43
+/*					44	*/
+#define RESET_IRQ_CTRL			45
+/*					46	*/
+#define RESET_NIC_VAD			47
+#define RESET_NIC_AXI			48
+#define RESET_RAMA			49
+#define RESET_RAMB			50
+/*					51-52	*/
+#define RESET_ROM			53
+#define RESET_SPIFC			54
+#define RESET_GIC			55
+#define RESET_UART_C			56
+#define RESET_UART_B			57
+#define RESET_UART_A			58
+#define RESET_OSC_RING			59
+/*					60-63	*/
+
+/*	RESET2					*/
+/*					64-95	*/
+
+#endif
-- 
2.7.4

