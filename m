Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB48CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0122087E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfJaOLC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:11:02 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:44204 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfJaOLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:11:01 -0400
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 7A1761C80E13;
        Thu, 31 Oct 2019 21:56:25 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct 2019
 21:56:24 +0800
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Thu, 31 Oct
 2019 15:56:19 +0200
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Thu, 31 Oct 2019 15:56:19 +0200
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id 5D3C61A4;
        Thu, 31 Oct 2019 15:56:19 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5DABD60275; Thu, 31 Oct 2019 15:56:19 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <yuenn@google.com>, <venture@google.com>,
        <benjaminfair@google.com>, <avifishman70@gmail.com>,
        <joel@jms.id.au>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: reset: Add binding constants for NPCM7xx reset controller
Date:   Thu, 31 Oct 2019 15:56:16 +0200
Message-ID: <20191031135617.249303-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191031135617.249303-1-tmaimon77@gmail.com>
References: <20191031135617.249303-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding constants for Nuvoton BMC NPCM7xx
reset controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../dt-bindings/reset/nuvoton,npcm7xx-reset.h | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm7xx-reset.h

diff --git a/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h b/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
new file mode 100644
index 000000000000..df088e68a9ba
--- /dev/null
+++ b/include/dt-bindings/reset/nuvoton,npcm7xx-reset.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2019 Nuvoton Technology corporation.
+
+#ifndef _DT_BINDINGS_NPCM7XX_RESET_H
+#define _DT_BINDINGS_NPCM7XX_RESET_H
+
+#define NPCM7XX_RESET_IPSRST1          0x20
+#define NPCM7XX_RESET_IPSRST2          0x24
+#define NPCM7XX_RESET_IPSRST3          0x34
+
+/* Reset lines on IP1 reset module (NPCM7XX_RESET_IPSRST1) */
+#define NPCM7XX_RESET_FIU3             1
+#define NPCM7XX_RESET_UDC1             5
+#define NPCM7XX_RESET_EMC1             6
+#define NPCM7XX_RESET_UART_2_3         7
+#define NPCM7XX_RESET_UDC2             8
+#define NPCM7XX_RESET_PECI             9
+#define NPCM7XX_RESET_AES              10
+#define NPCM7XX_RESET_UART_0_1         11
+#define NPCM7XX_RESET_MC               12
+#define NPCM7XX_RESET_SMB2             13
+#define NPCM7XX_RESET_SMB3             14
+#define NPCM7XX_RESET_SMB4             15
+#define NPCM7XX_RESET_SMB5             16
+#define NPCM7XX_RESET_PWM_M0           18
+#define NPCM7XX_RESET_TIMER_0_4                19
+#define NPCM7XX_RESET_TIMER_5_9                20
+#define NPCM7XX_RESET_EMC2             21
+#define NPCM7XX_RESET_UDC4             22
+#define NPCM7XX_RESET_UDC5             23
+#define NPCM7XX_RESET_UDC6             24
+#define NPCM7XX_RESET_UDC3             25
+#define NPCM7XX_RESET_ADC              27
+#define NPCM7XX_RESET_SMB6             28
+#define NPCM7XX_RESET_SMB7             29
+#define NPCM7XX_RESET_SMB0             30
+#define NPCM7XX_RESET_SMB1             31
+
+/* Reset lines on IP2 reset module (NPCM7XX_RESET_IPSRST2) */
+#define NPCM7XX_RESET_MFT0             0
+#define NPCM7XX_RESET_MFT1             1
+#define NPCM7XX_RESET_MFT2             2
+#define NPCM7XX_RESET_MFT3             3
+#define NPCM7XX_RESET_MFT4             4
+#define NPCM7XX_RESET_MFT5             5
+#define NPCM7XX_RESET_MFT6             6
+#define NPCM7XX_RESET_MFT7             7
+#define NPCM7XX_RESET_MMC              8
+#define NPCM7XX_RESET_SDHC             9
+#define NPCM7XX_RESET_GFX_SYS          10
+#define NPCM7XX_RESET_AHB_PCIBRG       11
+#define NPCM7XX_RESET_VDMA             12
+#define NPCM7XX_RESET_ECE              13
+#define NPCM7XX_RESET_VCD              14
+#define NPCM7XX_RESET_OTP              16
+#define NPCM7XX_RESET_SIOX1            18
+#define NPCM7XX_RESET_SIOX2            19
+#define NPCM7XX_RESET_3DES             21
+#define NPCM7XX_RESET_PSPI1            22
+#define NPCM7XX_RESET_PSPI2            23
+#define NPCM7XX_RESET_GMAC2            25
+#define NPCM7XX_RESET_USB_HOST         26
+#define NPCM7XX_RESET_GMAC1            28
+#define NPCM7XX_RESET_CP               31
+
+/* Reset lines on IP3 reset module (NPCM7XX_RESET_IPSRST3) */
+#define NPCM7XX_RESET_PWM_M1           0
+#define NPCM7XX_RESET_SMB12            1
+#define NPCM7XX_RESET_SPIX             2
+#define NPCM7XX_RESET_SMB13            3
+#define NPCM7XX_RESET_UDC0             4
+#define NPCM7XX_RESET_UDC7             5
+#define NPCM7XX_RESET_UDC8             6
+#define NPCM7XX_RESET_UDC9             7
+#define NPCM7XX_RESET_PCI_MAILBOX      9
+#define NPCM7XX_RESET_SMB14            12
+#define NPCM7XX_RESET_SHA              13
+#define NPCM7XX_RESET_SEC_ECC          14
+#define NPCM7XX_RESET_PCIE_RC          15
+#define NPCM7XX_RESET_TIMER_10_14      16
+#define NPCM7XX_RESET_RNG              17
+#define NPCM7XX_RESET_SMB15            18
+#define NPCM7XX_RESET_SMB8             19
+#define NPCM7XX_RESET_SMB9             20
+#define NPCM7XX_RESET_SMB10            21
+#define NPCM7XX_RESET_SMB11            22
+#define NPCM7XX_RESET_ESPI             23
+#define NPCM7XX_RESET_USB_PHY_1                24
+#define NPCM7XX_RESET_USB_PHY_2                25
+
+#endif
--
2.22.0



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
