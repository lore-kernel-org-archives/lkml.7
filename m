Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8232C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C4D2190A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 14:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfCWObk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 10:31:40 -0400
Received: from asrmicro.com ([210.13.118.86]:11747 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWObi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 10:31:38 -0400
Received: from spam.asrmicro.com (localhost [127.0.0.2] (may be forged))
        by spam.asrmicro.com with ESMTP id x2NE5S4H031363;
        Sat, 23 Mar 2019 22:05:28 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x2NDxr2M029585;
        Sat, 23 Mar 2019 21:59:53 +0800 (GMT-8)
        (envelope-from qiaozhou@asrmicro.com)
Received: from localhost (10.1.170.171) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Sat, 23 Mar 2019 22:01:30
 +0800
From:   qiaozhou <qiaozhou@asrmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH 5/7] dt-bindings: Add header file of ASR8751C clock driver
Date:   Sat, 23 Mar 2019 22:01:26 +0800
Message-ID: <1553349688-1946-6-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.170.171]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x2NDxr2M029585
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiao Zhou <qiaozhou@asrmicro.com>

Add header file used by both ASR8751C clock driver and device tree file.

Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
---
 include/dt-bindings/clock/asr8751c-clk.h | 252 +++++++++++++++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 include/dt-bindings/clock/asr8751c-clk.h

diff --git a/include/dt-bindings/clock/asr8751c-clk.h b/include/dt-bindings/clock/asr8751c-clk.h
new file mode 100644
index 0000000..e90fe8d
--- /dev/null
+++ b/include/dt-bindings/clock/asr8751c-clk.h
@@ -0,0 +1,252 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * asr clock driver file for asr8751c
+ *
+ * Copyright (c) 2019, ASR Microelectronics(Shanghai) Co., Ltd.
+ * Gang Wu <gangwu@asrmicro.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __DTS_ASR8751C_CLOCK_H
+#define __DTS_ASR8751C_CLOCK_H
+
+/* fixed clocks and plls */
+#define ASR_CLK_CLK32				1
+#define ASR_CLK_VCTCXO				2
+#define ASR_CLK_PLL1_VCO			3
+#define ASR_CLK_PLL2_VCO			4
+#define ASR_CLK_PLL3_VCO			5
+#define ASR_CLK_PLL4_VCO			6
+#define ASR_CLK_PLL5_VCO			7
+#define ASR_CLK_PLL6_VCO			8
+#define ASR_CLK_PLL7_VCO			9
+#define ASR_CLK_DPLL1_VCO			10
+#define ASR_CLK_DPLL2_VCO			11
+#define ASR_CLK_VCTCXO_3P25M			12
+#define ASR_CLK_VCTCXO_1M			13
+
+#define ASR_CLK_PLL1_D1_2496_VCO		20
+#define ASR_CLK_PLL1_D2_1248_VCO		21
+#define ASR_CLK_PLL1_D3_832_VCO			22
+#define ASR_CLK_PLL1_D4_624_VCO			23
+#define ASR_CLK_PLL1_D5_499_VCO			24
+#define ASR_CLK_PLL2_D1_VCO			25
+#define ASR_CLK_PLL2_D2_VCO			26
+#define ASR_CLK_PLL2_D3_VCO			27
+#define ASR_CLK_PLL2_D4_VCO			28
+#define ASR_CLK_PLL2_D5_VCO			29
+#define ASR_CLK_PLL3_D1_VCO			30
+#define ASR_CLK_PLL3_D2_VCO			31
+#define ASR_CLK_PLL3_D3_VCO			32
+#define ASR_CLK_PLL3_D4_VCO			33
+#define ASR_CLK_PLL3_D5_VCO			34
+#define ASR_CLK_PLL4_D1_VCO			35
+#define ASR_CLK_PLL4_D2_VCO			36
+#define ASR_CLK_PLL4_D3_VCO			37
+#define ASR_CLK_PLL4_D4_VCO			38
+#define ASR_CLK_PLL4_D5_VCO			39
+#define ASR_CLK_PLL5_D1_VCO			40
+#define ASR_CLK_PLL5_D2_VCO			41
+#define ASR_CLK_PLL5_D3_VCO			42
+#define ASR_CLK_PLL5_D4_VCO			43
+#define ASR_CLK_PLL5_D5_VCO			44
+#define ASR_CLK_PLL6_D1_VCO			45
+#define ASR_CLK_PLL6_D2_VCO			46
+#define ASR_CLK_PLL6_D3_VCO			47
+#define ASR_CLK_PLL6_D4_VCO			48
+#define ASR_CLK_PLL6_D5_VCO			49
+#define ASR_CLK_PLL7_D1_VCO			50
+#define ASR_CLK_PLL7_D2_VCO			51
+#define ASR_CLK_PLL7_D3_VCO			52
+#define ASR_CLK_PLL7_D4_VCO			53
+#define ASR_CLK_PLL7_D5_VCO			54
+
+#define ASR_CLK_DPLL1_D1_VCO			55
+#define ASR_CLK_DPLL1_D2_VCO			56
+#define ASR_CLK_DPLL1_D3_VCO			57
+#define ASR_CLK_DPLL1_D4_VCO			58
+#define ASR_CLK_DPLL2_D1_VCO			59
+#define ASR_CLK_DPLL2_D2_VCO			60
+#define ASR_CLK_DPLL2_D3_VCO			61
+#define ASR_CLK_DPLL2_D4_VCO			62
+
+#define ASR_CLK_PLL1_D1_2496			70
+#define ASR_CLK_PLL1_D2_1248			71
+#define ASR_CLK_PLL1_D3_832			72
+#define ASR_CLK_PLL1_D4_624			73
+#define ASR_CLK_PLL1_D5_499			74
+#define ASR_CLK_PLL2_D1				75
+#define ASR_CLK_PLL2_D2				76
+#define ASR_CLK_PLL2_D3				77
+#define ASR_CLK_PLL2_D4				78
+#define ASR_CLK_PLL2_D5				79
+#define ASR_CLK_PLL3_D1				80
+#define ASR_CLK_PLL3_D2				81
+#define ASR_CLK_PLL3_D3				82
+#define ASR_CLK_PLL3_D4				83
+#define ASR_CLK_PLL3_D5				84
+#define ASR_CLK_PLL4_D1				85
+#define ASR_CLK_PLL4_D2				86
+#define ASR_CLK_PLL4_D3				87
+#define ASR_CLK_PLL4_D4				88
+#define ASR_CLK_PLL4_D5				89
+#define ASR_CLK_PLL5_D1				90
+#define ASR_CLK_PLL5_D2				91
+#define ASR_CLK_PLL5_D3				92
+#define ASR_CLK_PLL5_D4				93
+#define ASR_CLK_PLL5_D5				94
+#define ASR_CLK_PLL6_D1				95
+#define ASR_CLK_PLL6_D2				96
+#define ASR_CLK_PLL6_D3				97
+#define ASR_CLK_PLL6_D4				98
+#define ASR_CLK_PLL6_D5				99
+#define ASR_CLK_PLL7_D1				100
+#define ASR_CLK_PLL7_D2				101
+#define ASR_CLK_PLL7_D3				102
+#define ASR_CLK_PLL7_D4				103
+#define ASR_CLK_PLL7_D5				104
+#define ASR_CLK_DPLL1_D1			105
+#define ASR_CLK_DPLL1_D2			106
+#define ASR_CLK_DPLL1_D3			107
+#define ASR_CLK_DPLL1_D4			108
+#define ASR_CLK_DPLL2_D1			109
+#define ASR_CLK_DPLL2_D2			110
+#define ASR_CLK_DPLL2_D3			111
+#define ASR_CLK_DPLL2_D4			112
+
+#define ASR_CLK_PLL1_D6_416			120
+#define ASR_CLK_PLL1_D8_312			121
+#define ASR_CLK_PLL1_D12_208			122
+#define ASR_CLK_PLL1_D32_78			123
+#define ASR_CLK_PLL1_D24_104			124
+#define ASR_CLK_PLL1_D32_78_2			125
+#define ASR_CLK_PLL1_M3D128_58P5		126
+#define ASR_CLK_PLL1_D48_52			127
+#define ASR_CLK_PLL1_D52_48			128
+#define ASR_CLK_PLL1_D78_32			129
+#define ASR_CLK_PLL1_D96_26			130
+#define ASR_CLK_PLL1_D192_13			131
+#define ASR_CLK_PLL1_D384_6P5			132
+#define ASR_CLK_PLL1_D10_249			133
+
+#define ASR_CLK_PLL1_13_WDT			150
+#define ASR_CLK_PLL1_1248			151
+#define ASR_CLK_PLL1_624			152
+#define ASR_CLK_PLL1_832			153
+#define ASR_CLK_PLL1_312			154
+#define ASR_CLK_PLL1_78_UART			155
+#define ASR_CLK_PLL1_104			156
+#define ASR_CLK_PLL1_78				157
+#define ASR_CLK_PLL1_52				158
+#define ASR_CLK_PLL1_48				159
+#define ASR_CLK_PLL1_58P5			160
+#define ASR_CLK_PLL1_52_2			161
+#define ASR_CLK_PLL1_32				162
+#define ASR_CLK_PLL1_208			163
+#define ASR_CLK_PLL1_26				164
+#define ASR_CLK_PLL1_13				165
+#define ASR_CLK_PLL1_6P5			166
+#define ASR_CLK_PLL1_416			167
+#define ASR_CLK_PLL1_499			168
+#define ASR_CLK_PLL1_249			169
+
+/* ddr/axi etc */
+#define ASR_CLK_DDR				180
+#define ASR_CLK_AXI				181
+#define ASR_CLK_CLST0				182
+#define ASR_CLK_CLST1				183
+#define ASR_CLK_CLST2				184
+#define ASR_CLK_CCI_MEM				185
+#define ASR_CLK_DDR_PERF			186
+
+/* apb periphrals */
+#define ASR_CLK_TWSI0				200
+#define ASR_CLK_TWSI1				201
+#define ASR_CLK_TWSI2				202
+#define ASR_CLK_TWSI3				203
+#define ASR_CLK_TWSI4				204
+#define ASR_CLK_TWSI5				205
+#define ASR_CLK_TWSI6				206
+#define ASR_CLK_TWSI7				207
+#define ASR_CLK_TWSI8				208
+#define ASR_CLK_GPIO				209
+#define ASR_CLK_KPC				210
+#define ASR_CLK_AIB				211
+#define ASR_CLK_RTC				212
+#define ASR_CLK_PWM01P				213
+#define ASR_CLK_PWM0				214
+#define ASR_CLK_PWM1				215
+#define ASR_CLK_PWM23P				226
+#define ASR_CLK_PWM2				217
+#define ASR_CLK_PWM3				218
+#define ASR_CLK_UART0				219
+#define ASR_CLK_UART1				220
+#define ASR_CLK_UART2				221
+#define ASR_CLK_THERMAL				222
+#define ASR_CLK_SWJTAG				223
+#define ASR_CLK_IPC				224
+#define ASR_CLK_SSP0				225
+#define ASR_CLK_SSP2				226
+#define ASR_CLK_TIMER0				227
+#define ASR_CLK_TIMER1				228
+#define ASR_CLK_TIMER2				229
+
+/* axi periphrals */
+#define ASR_CLK_USB				230
+#define ASR_CLK_SDH_AXI				231
+#define ASR_CLK_SDH0				232
+#define ASR_CLK_SDH1				233
+#define ASR_CLK_SDH2				234
+#define ASR_CLK_GPU				235
+#define ASR_CLK_GPUBUS				236
+#define ASR_CLK_VPU				237
+#define ASR_CLK_VPUBUS				238
+#define ASR_CLK_DPU_HWCLK			239
+#define ASR_CLK_DPU_PXCLK			240
+#define ASR_CLK_DPU_PCLK			241
+#define ASR_CLK_DPU_MCLK			242
+#define ASR_CLK_DPU_AXICLK			243
+#define ASR_CLK_DPU_DPHYCLK			244
+#define ASR_CLK_DSI_ESC				245
+#define ASR_CLK_DSI_BIT				246
+#define ASR_CLK_ISP				247
+#define ASR_CLK_DMA				248
+#define ASR_CLK_AES				249
+
+#define ASR_CLK_JPEGFNC				250
+#define ASR_CLK_2KAFBC_FNC			251
+#define ASR_CLK_4KAFBC_FNC			252
+#define ASR_CLK_ISP_MCU				253
+#define ASR_CLK_ISP_BUS				254
+#define ASR_CLK_ISP_FNC				255
+#define ASR_CLK_CCIC_FNC			256
+#define ASR_CLK_SC2_AHB				257
+#define ASR_CLK_CCIC1_PHY			258
+#define ASR_CLK_CCIC2_PHY			259
+#define ASR_CLK_CCIC3_PHY			260
+#define ASR_CLK_CSI_FNC				261
+#define ASR_CLK_CAM_M0				262
+#define ASR_CLK_CAM_M1				263
+#define ASR_CLK_CAM_M2				264
+#define ASR_CLK_XM4_FNC				265
+#define ASR_CLK_AFBC_ENC			266
+#define ASR_CLK_AFBC_DEC			267
+#define ASR_CLK_ISP_BLANK			268
+#define ASR_CLK_AUDIO_FNC			270
+#define ASR_CLK_AUDIOIPC			271
+#define ASR_CLK_RIPC				272
+#define ASR_CLK_DBG				280
+#define ASR_CLK_WDT				281
+#define ASR_CLK_MUX_TIMER0			282
+#define ASR_CLK_MUX_SSP0			283
+#define ASR_CLK_MUX_SSP2			284
+#define ASR_CLK_MUX_UART0			285
+#define ASR_CLK_MUX_UART1			286
+#define ASR_CLK_MUX_UART2			287
+#define ASR_CLK_MUX_AES				288
+
+#define ASR_NR_CLKS				300
+#endif /* __DTS_ASR8751C_CLOCK_H */
-- 
2.7.4

