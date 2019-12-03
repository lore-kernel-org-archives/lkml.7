Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63385C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D3F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfLCHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:45:41 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39391 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfLCHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:45:40 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xB37jKtg016012, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xB37jKtg016012
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Dec 2019 15:45:21 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Dec 2019 15:45:19 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>,
        cylee12 <cylee12@realtek.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/6] dt-bindings: clock: add bindings for RTD1619 clocks
Date:   Tue, 3 Dec 2019 15:45:08 +0800
Message-ID: <20191203074513.9416-2-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203074513.9416-1-james.tai@realtek.com>
References: <20191203074513.9416-1-james.tai@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cylee12 <cylee12@realtek.com>

Add devicetree binding for Realtek RTD1619 clocks.

Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
Signed-off-by: James Tai <james.tai@realtek.com>
---
 include/dt-bindings/clock/rtk,clock-rtd1619.h | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 include/dt-bindings/clock/rtk,clock-rtd1619.h

diff --git a/include/dt-bindings/clock/rtk,clock-rtd1619.h b/include/dt-bindings/clock/rtk,clock-rtd1619.h
new file mode 100644
index 000000000000..497f9b914857
--- /dev/null
+++ b/include/dt-bindings/clock/rtk,clock-rtd1619.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __DT_BINDINGS_RTK_CLOCK_RTD1619_H
+#define __DT_BINDINGS_RTK_CLOCK_RTD1619_H
+
+#define CC_PLL_SCPU 0
+#define CC_PLL_BUS 2
+#define CC_CLK_SYS 3
+#define CC_CLK_SYS_SB2 4
+#define CC_PLL_DCSB 5
+#define CC_CLK_SYSH 6
+#define CC_PLL_DDSA 7
+#define CC_PLL_DDSB 8
+#define CC_PLL_GPU 9
+#define CC_CLK_GPU 10
+#define CC_PLL_VE1 11
+#define CC_PLL_VE2 12
+#define CC_CLK_VE1 13
+#define CC_CLK_VE2 14
+#define CC_CLK_VE3 15
+#define CC_CLK_VE2_BPU 16
+#define CC_PLL_DIF 17
+#define CC_PLL_PSAUD1A 18
+#define CC_PLL_PSAUD2A 19
+
+#define CC_CKE_MISC 33
+#define CC_CKE_PCIE0 34
+#define CC_CKE_GSPI 35
+#define CC_CKE_SDS 36
+#define CC_CKE_HDMI 37
+#define CC_CKE_LSADC 38
+#define CC_CKE_SE 39
+#define CC_CKE_CP 40
+#define CC_CKE_MD 41
+#define CC_CKE_TP 42
+#define CC_CKE_RSA 43
+#define CC_CKE_NF 44
+#define CC_CKE_EMMC 45
+#define CC_CKE_SD 46
+#define CC_CKE_SDIO_IP 47
+#define CC_CKE_MIPI 48
+#define CC_CKE_EMMC_IP 49
+#define CC_CKE_SDIO 50
+#define CC_CKE_SD_IP 51
+#define CC_CKE_CABLERX 52
+#define CC_CKE_TPB 53
+#define CC_CKE_SC1 54
+#define CC_CKE_I2C3 55
+#define CC_CKE_JPEG 56
+#define CC_CKE_SC0 57
+#define CC_CKE_HDMIRX 58
+#define CC_CKE_HSE 59
+#define CC_CKE_UR2 60
+#define CC_CKE_UR1 61
+#define CC_CKE_FAN 62
+#define CC_CKE_SATA_WRAP_SYS 63
+#define CC_CKE_SATA_WRAP_SYSH 64
+#define CC_CKE_SATA_MAC_SYSH 65
+#define CC_CKE_R2RDSC 66
+#define CC_CKE_PCIE1 67
+#define CC_CKE_I2C4 68
+#define CC_CKE_I2C5 69
+#define CC_CKE_EDP 70
+#define CC_CKE_TSIO_TRX 71
+#define CC_CKE_TVE 72
+#define CC_CKE_VO 73
+
+#define CC_CLK_MAX 74
+
+
+#define IC_CKE_CEC0 2
+#define IC_CKE_CBUSRX_SYS 3
+#define IC_CKE_CBUSTX_SYS 4
+#define IC_CKE_CBUS_SYS 5
+#define IC_CKE_CBUS_OSC 6
+#define IC_CKE_IR 7
+#define IC_CKE_UR0 8
+#define IC_CKE_I2C0 9
+#define IC_CKE_I2C1 10
+#define IC_CKE_ETN_250M 11
+#define IC_CKE_ETN_SYS 12
+#define IC_CKE_USB_DRD 13
+#define IC_CKE_USB_HOST 14
+#define IC_CKE_USB_U3_HOST 15
+#define IC_CKE_USB 16
+#define IC_CLK_MAX 17
+
+#endif /* __DT_BINDINGS_RTK_CLOCK_RTD1619_H */
+
-- 
2.24.0

