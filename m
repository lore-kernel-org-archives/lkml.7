Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AE9C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B7823402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbfHVJe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:34:26 -0400
Received: from shell.v3.sk ([90.176.6.54]:35932 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbfHVJeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:34:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 97BDCD7571;
        Thu, 22 Aug 2019 11:34:20 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WbfmEja5f17y; Thu, 22 Aug 2019 11:33:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1BFA0D7559;
        Thu, 22 Aug 2019 11:33:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RuJLNjcmgr2X; Thu, 22 Aug 2019 11:33:00 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 44759D756C;
        Thu, 22 Aug 2019 11:26:52 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 18/20] ARM: mmp: remove MMP3 USB PHY registers from regs-usb.h
Date:   Thu, 22 Aug 2019 11:26:41 +0200
Message-Id: <20190822092643.593488-19-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822092643.593488-1-lkundrak@v3.sk>
References: <20190822092643.593488-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in mach-mmp/ uses them and they belong to the PHY driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/regs-usb.h | 94 ------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/arch/arm/mach-mmp/regs-usb.h b/arch/arm/mach-mmp/regs-usb.h
index d9f08c1601542..ed0d1aa0ad6c9 100644
--- a/arch/arm/mach-mmp/regs-usb.h
+++ b/arch/arm/mach-mmp/regs-usb.h
@@ -121,100 +121,6 @@
=20
 #define UTMI_OTG_ADDON_OTG_ON			(1 << 0)
=20
-/* For MMP3 USB Phy */
-#define USB2_PLL_REG0		0x4
-#define USB2_PLL_REG1		0x8
-#define USB2_TX_REG0		0x10
-#define USB2_TX_REG1		0x14
-#define USB2_TX_REG2		0x18
-#define USB2_RX_REG0		0x20
-#define USB2_RX_REG1		0x24
-#define USB2_RX_REG2		0x28
-#define USB2_ANA_REG0		0x30
-#define USB2_ANA_REG1		0x34
-#define USB2_ANA_REG2		0x38
-#define USB2_DIG_REG0		0x3C
-#define USB2_DIG_REG1		0x40
-#define USB2_DIG_REG2		0x44
-#define USB2_DIG_REG3		0x48
-#define USB2_TEST_REG0		0x4C
-#define USB2_TEST_REG1		0x50
-#define USB2_TEST_REG2		0x54
-#define USB2_CHARGER_REG0	0x58
-#define USB2_OTG_REG0		0x5C
-#define USB2_PHY_MON0		0x60
-#define USB2_RESETVE_REG0	0x64
-#define USB2_ICID_REG0		0x78
-#define USB2_ICID_REG1		0x7C
-
-/* USB2_PLL_REG0 */
-/* This is for Ax stepping */
-#define USB2_PLL_FBDIV_SHIFT_MMP3		0
-#define USB2_PLL_FBDIV_MASK_MMP3		(0xFF << 0)
-
-#define USB2_PLL_REFDIV_SHIFT_MMP3		8
-#define USB2_PLL_REFDIV_MASK_MMP3		(0xF << 8)
-
-#define USB2_PLL_VDD12_SHIFT_MMP3		12
-#define USB2_PLL_VDD18_SHIFT_MMP3		14
-
-/* This is for B0 stepping */
-#define USB2_PLL_FBDIV_SHIFT_MMP3_B0		0
-#define USB2_PLL_REFDIV_SHIFT_MMP3_B0		9
-#define USB2_PLL_VDD18_SHIFT_MMP3_B0		14
-#define USB2_PLL_FBDIV_MASK_MMP3_B0		0x01FF
-#define USB2_PLL_REFDIV_MASK_MMP3_B0		0x3E00
-
-#define USB2_PLL_CAL12_SHIFT_MMP3		0
-#define USB2_PLL_CALI12_MASK_MMP3		(0x3 << 0)
-
-#define USB2_PLL_VCOCAL_START_SHIFT_MMP3	2
-
-#define USB2_PLL_KVCO_SHIFT_MMP3		4
-#define USB2_PLL_KVCO_MASK_MMP3			(0x7<<4)
-
-#define USB2_PLL_ICP_SHIFT_MMP3			8
-#define USB2_PLL_ICP_MASK_MMP3			(0x7<<8)
-
-#define USB2_PLL_LOCK_BYPASS_SHIFT_MMP3		12
-
-#define USB2_PLL_PU_PLL_SHIFT_MMP3		13
-#define USB2_PLL_PU_PLL_MASK			(0x1 << 13)
-
-#define USB2_PLL_READY_MASK_MMP3		(0x1 << 15)
-
-/* USB2_TX_REG0 */
-#define USB2_TX_IMPCAL_VTH_SHIFT_MMP3		8
-#define USB2_TX_IMPCAL_VTH_MASK_MMP3		(0x7 << 8)
-
-#define USB2_TX_RCAL_START_SHIFT_MMP3		13
-
-/* USB2_TX_REG1 */
-#define USB2_TX_CK60_PHSEL_SHIFT_MMP3		0
-#define USB2_TX_CK60_PHSEL_MASK_MMP3		(0xf << 0)
-
-#define USB2_TX_AMP_SHIFT_MMP3			4
-#define USB2_TX_AMP_MASK_MMP3			(0x7 << 4)
-
-#define USB2_TX_VDD12_SHIFT_MMP3		8
-#define USB2_TX_VDD12_MASK_MMP3			(0x3 << 8)
-
-/* USB2_TX_REG2 */
-#define USB2_TX_DRV_SLEWRATE_SHIFT		10
-
-/* USB2_RX_REG0 */
-#define USB2_RX_SQ_THRESH_SHIFT_MMP3		4
-#define USB2_RX_SQ_THRESH_MASK_MMP3		(0xf << 4)
-
-#define USB2_RX_SQ_LENGTH_SHIFT_MMP3		10
-#define USB2_RX_SQ_LENGTH_MASK_MMP3		(0x3 << 10)
-
-/* USB2_ANA_REG1*/
-#define USB2_ANA_PU_ANA_SHIFT_MMP3		14
-
-/* USB2_OTG_REG0 */
-#define USB2_OTG_PU_OTG_SHIFT_MMP3		3
-
 /* fsic registers */
 #define FSIC_MISC			0x4
 #define FSIC_INT			0x28
--=20
2.21.0

