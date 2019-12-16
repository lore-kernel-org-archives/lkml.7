Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C0A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hGgFG2xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLPJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:56:25 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36500 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfLPJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:56:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uE39056765;
        Mon, 16 Dec 2019 03:56:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576490174;
        bh=jhwu9vb8HP8nAIfykGv+pt0vdo/1Nu+RVLPQfa9+g5k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hGgFG2xxApG2qi1VT886GXFoWiFmA5SiVxjLdE/1N5FFFfF3cjFHtvlWl2SC7slWD
         JG9M+2pC6r+sjv0rP/L3FEyENiKPlxib/NG7rXdhKQjMJN7UtuJeDSB/tMeEt5zVIb
         RvNl4erroGanRZbU1tvGDCpmpvRd72OObyftl7fk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9uEc3038130;
        Mon, 16 Dec 2019 03:56:14 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Dec 2019 03:56:14 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Dec 2019 03:56:14 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBG9tsJP084408;
        Mon, 16 Dec 2019 03:56:11 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 06/14] phy: cadence: Sierra: Modify register macro names to be in sync with Sierra user guide
Date:   Mon, 16 Dec 2019 15:27:04 +0530
Message-ID: <20191216095712.13266-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216095712.13266-1-kishon@ti.com>
References: <20191216095712.13266-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Modify register offset macro names to be in sync with
Sierra user guide.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 167 ++++++++++++-----------
 1 file changed, 84 insertions(+), 83 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index bc2ae260359c..d490e1641cf9 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -22,57 +22,58 @@
 #include <dt-bindings/phy/phy.h>
 
 /* PHY register offsets */
-#define SIERRA_COMMON_CDB_OFFSET	0x0
-#define SIERRA_MACRO_ID_REG		0x0
+#define SIERRA_COMMON_CDB_OFFSET		0x0
+#define SIERRA_MACRO_ID_REG			0x0
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
 				 (((ln) << 9) << (reg_offset)))
-#define SIERRA_DET_STANDEC_A		0x000
-#define SIERRA_DET_STANDEC_B		0x001
-#define SIERRA_DET_STANDEC_C		0x002
-#define SIERRA_DET_STANDEC_D		0x003
-#define SIERRA_DET_STANDEC_E		0x004
-#define SIERRA_PSM_LANECAL		0x008
-#define SIERRA_PSM_DIAG			0x015
-#define SIERRA_PSC_TX_A0		0x028
-#define SIERRA_PSC_TX_A1		0x029
-#define SIERRA_PSC_TX_A2		0x02A
-#define SIERRA_PSC_TX_A3		0x02B
-#define SIERRA_PSC_RX_A0		0x030
-#define SIERRA_PSC_RX_A1		0x031
-#define SIERRA_PSC_RX_A2		0x032
-#define SIERRA_PSC_RX_A3		0x033
-#define SIERRA_PLLCTRL_SUBRATE		0x03A
-#define SIERRA_PLLCTRL_GEN_D		0x03E
-#define SIERRA_DRVCTRL_ATTEN		0x06A
-#define SIERRA_CLKPATHCTRL_TMR		0x081
-#define SIERRA_RX_CREQ_FLTR_A_MODE1	0x087
-#define SIERRA_RX_CREQ_FLTR_A_MODE0	0x088
-#define SIERRA_CREQ_CCLKDET_MODE01	0x08E
-#define SIERRA_RX_CTLE_MAINTENANCE	0x091
-#define SIERRA_CREQ_FSMCLK_SEL		0x092
-#define SIERRA_CTLELUT_CTRL		0x098
-#define SIERRA_DFE_ECMP_RATESEL		0x0C0
-#define SIERRA_DFE_SMP_RATESEL		0x0C1
-#define SIERRA_DEQ_VGATUNE_CTRL		0x0E1
-#define SIERRA_TMRVAL_MODE3		0x16E
-#define SIERRA_TMRVAL_MODE2		0x16F
-#define SIERRA_TMRVAL_MODE1		0x170
-#define SIERRA_TMRVAL_MODE0		0x171
-#define SIERRA_PICNT_MODE1		0x174
-#define SIERRA_CPI_OUTBUF_RATESEL	0x17C
-#define SIERRA_LFPSFILT_NS		0x18A
-#define SIERRA_LFPSFILT_RD		0x18B
-#define SIERRA_LFPSFILT_MP		0x18C
-#define SIERRA_SDFILT_H2L_A		0x191
+
+#define SIERRA_DET_STANDEC_A_PREG		0x000
+#define SIERRA_DET_STANDEC_B_PREG		0x001
+#define SIERRA_DET_STANDEC_C_PREG		0x002
+#define SIERRA_DET_STANDEC_D_PREG		0x003
+#define SIERRA_DET_STANDEC_E_PREG		0x004
+#define SIERRA_PSM_LANECAL_PREG			0x008
+#define SIERRA_PSM_DIAG_PREG			0x015
+#define SIERRA_PSC_TX_A0_PREG			0x028
+#define SIERRA_PSC_TX_A1_PREG			0x029
+#define SIERRA_PSC_TX_A2_PREG			0x02A
+#define SIERRA_PSC_TX_A3_PREG			0x02B
+#define SIERRA_PSC_RX_A0_PREG			0x030
+#define SIERRA_PSC_RX_A1_PREG			0x031
+#define SIERRA_PSC_RX_A2_PREG			0x032
+#define SIERRA_PSC_RX_A3_PREG			0x033
+#define SIERRA_PLLCTRL_SUBRATE_PREG		0x03A
+#define SIERRA_PLLCTRL_GEN_D_PREG		0x03E
+#define SIERRA_DRVCTRL_ATTEN_PREG		0x06A
+#define SIERRA_CLKPATHCTRL_TMR_PREG		0x081
+#define SIERRA_RX_CREQ_FLTR_A_MODE1_PREG	0x087
+#define SIERRA_RX_CREQ_FLTR_A_MODE0_PREG	0x088
+#define SIERRA_CREQ_CCLKDET_MODE01_PREG		0x08E
+#define SIERRA_RX_CTLE_MAINTENANCE_PREG		0x091
+#define SIERRA_CREQ_FSMCLK_SEL_PREG		0x092
+#define SIERRA_CTLELUT_CTRL_PREG		0x098
+#define SIERRA_DFE_ECMP_RATESEL_PREG		0x0C0
+#define SIERRA_DFE_SMP_RATESEL_PREG		0x0C1
+#define SIERRA_DEQ_VGATUNE_CTRL_PREG		0x0E1
+#define SIERRA_TMRVAL_MODE3_PREG		0x16E
+#define SIERRA_TMRVAL_MODE2_PREG		0x16F
+#define SIERRA_TMRVAL_MODE1_PREG		0x170
+#define SIERRA_TMRVAL_MODE0_PREG		0x171
+#define SIERRA_PICNT_MODE1_PREG			0x174
+#define SIERRA_CPI_OUTBUF_RATESEL_PREG		0x17C
+#define SIERRA_LFPSFILT_NS_PREG			0x18A
+#define SIERRA_LFPSFILT_RD_PREG			0x18B
+#define SIERRA_LFPSFILT_MP_PREG			0x18C
+#define SIERRA_SDFILT_H2L_A_PREG		0x191
 
 #define SIERRA_PHY_CONFIG_CTRL_OFFSET(block_offset)	\
 				      (0xc000 << (block_offset))
-#define SIERRA_PHY_PLL_CFG		0xe
+#define SIERRA_PHY_PLL_CFG			0xe
 
-#define SIERRA_MACRO_ID			0x00007364
-#define SIERRA_MAX_LANES		4
+#define SIERRA_MACRO_ID				0x00007364
+#define SIERRA_MAX_LANES			4
 
 static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
@@ -496,42 +497,42 @@ static struct cdns_reg_pairs cdns_usb_regs[] = {
 	 * These values are specific to this specific hardware
 	 * configuration.
 	 */
-	{0xFE0A, SIERRA_DET_STANDEC_A},
-	{0x000F, SIERRA_DET_STANDEC_B},
-	{0x55A5, SIERRA_DET_STANDEC_C},
-	{0x69AD, SIERRA_DET_STANDEC_D},
-	{0x0241, SIERRA_DET_STANDEC_E},
-	{0x0110, SIERRA_PSM_LANECAL},
-	{0xCF00, SIERRA_PSM_DIAG},
-	{0x001F, SIERRA_PSC_TX_A0},
-	{0x0007, SIERRA_PSC_TX_A1},
-	{0x0003, SIERRA_PSC_TX_A2},
-	{0x0003, SIERRA_PSC_TX_A3},
-	{0x0FFF, SIERRA_PSC_RX_A0},
-	{0x0003, SIERRA_PSC_RX_A1},
-	{0x0003, SIERRA_PSC_RX_A2},
-	{0x0001, SIERRA_PSC_RX_A3},
-	{0x0001, SIERRA_PLLCTRL_SUBRATE},
-	{0x0406, SIERRA_PLLCTRL_GEN_D},
-	{0x0000, SIERRA_DRVCTRL_ATTEN},
-	{0x823E, SIERRA_CLKPATHCTRL_TMR},
-	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
-	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
-	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
-	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
-	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
-	{0x8452, SIERRA_CTLELUT_CTRL},
-	{0x4121, SIERRA_DFE_ECMP_RATESEL},
-	{0x4121, SIERRA_DFE_SMP_RATESEL},
-	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
-	{0x0330, SIERRA_TMRVAL_MODE0},
-	{0x01FF, SIERRA_PICNT_MODE1},
-	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
-	{0x000F, SIERRA_LFPSFILT_NS},
-	{0x0009, SIERRA_LFPSFILT_RD},
-	{0x0001, SIERRA_LFPSFILT_MP},
-	{0x8013, SIERRA_SDFILT_H2L_A},
-	{0x0400, SIERRA_TMRVAL_MODE1},
+	{0xFE0A, SIERRA_DET_STANDEC_A_PREG},
+	{0x000F, SIERRA_DET_STANDEC_B_PREG},
+	{0x55A5, SIERRA_DET_STANDEC_C_PREG},
+	{0x69AD, SIERRA_DET_STANDEC_D_PREG},
+	{0x0241, SIERRA_DET_STANDEC_E_PREG},
+	{0x0110, SIERRA_PSM_LANECAL_PREG},
+	{0xCF00, SIERRA_PSM_DIAG_PREG},
+	{0x001F, SIERRA_PSC_TX_A0_PREG},
+	{0x0007, SIERRA_PSC_TX_A1_PREG},
+	{0x0003, SIERRA_PSC_TX_A2_PREG},
+	{0x0003, SIERRA_PSC_TX_A3_PREG},
+	{0x0FFF, SIERRA_PSC_RX_A0_PREG},
+	{0x0003, SIERRA_PSC_RX_A1_PREG},
+	{0x0003, SIERRA_PSC_RX_A2_PREG},
+	{0x0001, SIERRA_PSC_RX_A3_PREG},
+	{0x0001, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0406, SIERRA_PLLCTRL_GEN_D_PREG},
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x3232, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x8452, SIERRA_CTLELUT_CTRL_PREG},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL_PREG},
+	{0x4121, SIERRA_DFE_SMP_RATESEL_PREG},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL_PREG},
+	{0x0330, SIERRA_TMRVAL_MODE0_PREG},
+	{0x01FF, SIERRA_PICNT_MODE1_PREG},
+	{0x0009, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x000F, SIERRA_LFPSFILT_NS_PREG},
+	{0x0009, SIERRA_LFPSFILT_RD_PREG},
+	{0x0001, SIERRA_LFPSFILT_MP_PREG},
+	{0x8013, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0400, SIERRA_TMRVAL_MODE1_PREG},
 };
 
 static struct cdns_reg_pairs cdns_pcie_regs[] = {
@@ -540,10 +541,10 @@ static struct cdns_reg_pairs cdns_pcie_regs[] = {
 	 * These values are specific to this specific hardware
 	 * configuration.
 	 */
-	{0x891f, SIERRA_DET_STANDEC_D},
-	{0x0053, SIERRA_DET_STANDEC_E},
-	{0x0400, SIERRA_TMRVAL_MODE2},
-	{0x0200, SIERRA_TMRVAL_MODE3},
+	{0x891f, SIERRA_DET_STANDEC_D_PREG},
+	{0x0053, SIERRA_DET_STANDEC_E_PREG},
+	{0x0400, SIERRA_TMRVAL_MODE2_PREG},
+	{0x0200, SIERRA_TMRVAL_MODE3_PREG},
 };
 
 static const struct cdns_sierra_data cdns_map_sierra = {
-- 
2.17.1

