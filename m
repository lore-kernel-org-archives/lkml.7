Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC12C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E6D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gneXIM13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfDBEEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:04:40 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:18540 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfDBEEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:04:34 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3243Hac021871;
        Tue, 2 Apr 2019 13:03:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3243Hac021871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554177808;
        bh=C3agGISh5AFOPVjBW4d42bvXksgwWXRAdbYdrU8Tm6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gneXIM133PaPP0QZVe641Zqg88uAheIW781KBR2xJIYt23hr1eAcMTIimIiq7RJak
         U2Kazaa7aDAYY0He8NqwbYMpKhg+tFcaHj96zc973DgWEoJjOFiHFdCehqxe1WIa5o
         mL93DyCPepjK2PMjn5fOgK5ItegrOHbwyn09Mpur7njvRX5mL5p+5CcEUoguy+5hUH
         WIAU3hse0TzJcYRReWfAsjg6W14VA2RdtqtfS+CbbwTHUci2gttLwSbRT+S6dBW0+n
         3k0XU8t5RpyllQX3Mn4xPEQfbLXX2ATcxLykS10EVh5KnNZxyGKK70AuljUpmQiFAL
         yrWnCuXKvushQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v5 9/9] mtd: rawnand: denali: clean up coding style
Date:   Tue,  2 Apr 2019 13:03:09 +0900
Message-Id: <1554177789-15414-10-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
References: <1554177789-15414-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following reports from 'scripts/checkpatch.pl --strict'.

  CHECK: Prefer kernel type 'u8' over 'uint8_t'
  CHECK: Prefer kernel type 'u32' over 'uint32_t'
  CHECK: Alignment should match open parenthesis

I slightly changed denali_check_erased_page() to shorten it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 54 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index e918c3d..132956d 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -106,7 +106,7 @@ static void denali_disable_irq(struct denali_controller *denali)
 }
 
 static void denali_clear_irq(struct denali_controller *denali,
-			     int bank, uint32_t irq_status)
+			     int bank, u32 irq_status)
 {
 	/* write one to clear bits */
 	iowrite32(irq_status, denali->reg + INTR_STATUS(bank));
@@ -124,7 +124,7 @@ static irqreturn_t denali_isr(int irq, void *dev_id)
 {
 	struct denali_controller *denali = dev_id;
 	irqreturn_t ret = IRQ_NONE;
-	uint32_t irq_status;
+	u32 irq_status;
 	int i;
 
 	spin_lock(&denali->irq_lock);
@@ -163,7 +163,7 @@ static void denali_reset_irq(struct denali_controller *denali)
 static u32 denali_wait_for_irq(struct denali_controller *denali, u32 irq_mask)
 {
 	unsigned long time_left, flags;
-	uint32_t irq_status;
+	u32 irq_status;
 
 	spin_lock_irqsave(&denali->irq_lock, flags);
 
@@ -411,20 +411,17 @@ static int denali_check_erased_page(struct nand_chip *chip, u8 *buf,
 {
 	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
-	uint8_t *ecc_code = chip->oob_poi + denali->oob_skip_bytes;
-	int ecc_steps = chip->ecc.steps;
-	int ecc_size = chip->ecc.size;
-	int ecc_bytes = chip->ecc.bytes;
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	u8 *ecc_code = chip->oob_poi + denali->oob_skip_bytes;
 	int i, stat;
 
-	for (i = 0; i < ecc_steps; i++) {
+	for (i = 0; i < ecc->steps; i++) {
 		if (!(uncor_ecc_flags & BIT(i)))
 			continue;
 
-		stat = nand_check_erased_ecc_chunk(buf, ecc_size,
-						  ecc_code, ecc_bytes,
-						  NULL, 0,
-						  chip->ecc.strength);
+		stat = nand_check_erased_ecc_chunk(buf, ecc->size, ecc_code,
+						   ecc->bytes, NULL, 0,
+						   ecc->strength);
 		if (stat < 0) {
 			ecc_stats->failed++;
 		} else {
@@ -432,8 +429,8 @@ static int denali_check_erased_page(struct nand_chip *chip, u8 *buf,
 			max_bitflips = max_t(unsigned int, max_bitflips, stat);
 		}
 
-		buf += ecc_size;
-		ecc_code += ecc_bytes;
+		buf += ecc->size;
+		ecc_code += ecc->bytes;
 	}
 
 	return max_bitflips;
@@ -445,7 +442,7 @@ static int denali_hw_ecc_fixup(struct nand_chip *chip,
 	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
 	int bank = denali->active_bank;
-	uint32_t ecc_cor;
+	u32 ecc_cor;
 	unsigned int max_bitflips;
 
 	ecc_cor = ioread32(denali->reg + ECC_COR_INFO(bank));
@@ -475,18 +472,18 @@ static int denali_hw_ecc_fixup(struct nand_chip *chip,
 }
 
 static int denali_sw_ecc_fixup(struct nand_chip *chip,
-			       unsigned long *uncor_ecc_flags, uint8_t *buf)
+			       unsigned long *uncor_ecc_flags, u8 *buf)
 {
 	struct denali_controller *denali = to_denali_controller(chip);
 	struct mtd_ecc_stats *ecc_stats = &nand_to_mtd(chip)->ecc_stats;
 	unsigned int ecc_size = chip->ecc.size;
 	unsigned int bitflips = 0;
 	unsigned int max_bitflips = 0;
-	uint32_t err_addr, err_cor_info;
+	u32 err_addr, err_cor_info;
 	unsigned int err_byte, err_sector, err_device;
-	uint8_t err_cor_value;
+	u8 err_cor_value;
 	unsigned int prev_sector = 0;
-	uint32_t irq_status;
+	u32 irq_status;
 
 	denali_reset_irq(denali);
 
@@ -551,7 +548,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 static void denali_setup_dma64(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
-	uint32_t mode;
+	u32 mode;
 	const int page_count = 1;
 
 	mode = DENALI_MAP10 | DENALI_BANK(denali) | page;
@@ -576,7 +573,7 @@ static void denali_setup_dma64(struct denali_controller *denali,
 static void denali_setup_dma32(struct denali_controller *denali,
 			       dma_addr_t dma_addr, int page, bool write)
 {
-	uint32_t mode;
+	u32 mode;
 	const int page_count = 1;
 
 	mode = DENALI_MAP10 | DENALI_BANK(denali);
@@ -601,7 +598,7 @@ static int denali_pio_read(struct denali_controller *denali, u32 *buf,
 			   size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	uint32_t irq_status, ecc_err_mask;
+	u32 irq_status, ecc_err_mask;
 	int i;
 
 	if (denali->caps & DENALI_CAP_HW_ECC_FIXUP)
@@ -628,7 +625,7 @@ static int denali_pio_write(struct denali_controller *denali, const u32 *buf,
 			    size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	uint32_t irq_status;
+	u32 irq_status;
 	int i;
 
 	denali_reset_irq(denali);
@@ -637,7 +634,8 @@ static int denali_pio_write(struct denali_controller *denali, const u32 *buf,
 		denali->host_write(denali, addr, buf[i]);
 
 	irq_status = denali_wait_for_irq(denali,
-				INTR__PROGRAM_COMP | INTR__PROGRAM_FAIL);
+					 INTR__PROGRAM_COMP |
+					 INTR__PROGRAM_FAIL);
 	if (!(irq_status & INTR__PROGRAM_COMP))
 		return -EIO;
 
@@ -657,7 +655,7 @@ static int denali_dma_xfer(struct denali_controller *denali, void *buf,
 			   size_t size, int page, bool write)
 {
 	dma_addr_t dma_addr;
-	uint32_t irq_mask, irq_status, ecc_err_mask;
+	u32 irq_mask, irq_status, ecc_err_mask;
 	enum dma_data_direction dir = write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 	int ret = 0;
 
@@ -723,7 +721,7 @@ static int denali_page_xfer(struct nand_chip *chip, void *buf, size_t size,
 		return denali_pio_xfer(denali, buf, size, page, write);
 }
 
-static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
+static int denali_read_page(struct nand_chip *chip, u8 *buf,
 			    int oob_required, int page)
 {
 	struct denali_controller *denali = to_denali_controller(chip);
@@ -756,7 +754,7 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	return stat;
 }
 
-static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
+static int denali_write_page(struct nand_chip *chip, const u8 *buf,
 			     int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -774,7 +772,7 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	int acc_clks, re_2_we, re_2_re, we_2_re, addr_2_data;
 	int rdwr_en_lo, rdwr_en_hi, rdwr_en_lo_hi, cs_setup;
 	int addr_2_data_mask;
-	uint32_t tmp;
+	u32 tmp;
 
 	timings = nand_get_sdr_timings(conf);
 	if (IS_ERR(timings))
-- 
2.7.4

