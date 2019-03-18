Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AD62082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCRKvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:51:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48761 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:51:01 -0400
IronPort-Data: A9a23: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
X-IronPort-AV: E=Sophos;i="5.58,493,1544511600"; 
   d="scan'208";a="28422467"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Mar 2019 03:51:00 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Mar 2019 03:50:59 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <matthias.wieloch@few-bauer.de>, <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2] clk: at91: fix programmable clock for sama5d2
Date:   Mon, 18 Mar 2019 11:50:45 +0100
Message-ID: <20190318105045.26943-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Wieloch <matthias.wieloch@few-bauer.de>

The prescaler formula of the programmable clock has changed for sama5d2. Update
the driver accordingly.

Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[nicolas.ferre@microchip.com: adapt the prescaler range,
		fix clk_programmable_recalc_rate, split patch]
Signed-off-by: Matthias Wieloch <matthias.wieloch@few-bauer.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
v2: adapt to v5.1-rc1
    remove unneeded sentence about DT in commit message

Stephen,

I think it would be good to see this fix going upstream during v5.1-rc phase.

Best regards,
  Nicolas


 drivers/clk/at91/clk-programmable.c | 57 ++++++++++++++++++++++-------
 drivers/clk/at91/pmc.h              |  2 +
 drivers/clk/at91/sama5d2.c          | 10 ++++-
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 89d6f3736dbf..f8edbb65eda3 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -20,8 +20,7 @@
 #define PROG_ID_MAX		7
 
 #define PROG_STATUS_MASK(id)	(1 << ((id) + 8))
-#define PROG_PRES_MASK		0x7
-#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & PROG_PRES_MASK)
+#define PROG_PRES(layout, pckr)	((pckr >> layout->pres_shift) & layout->pres_mask)
 #define PROG_MAX_RM9200_CSS	3
 
 struct clk_programmable {
@@ -37,20 +36,29 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 						  unsigned long parent_rate)
 {
 	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	unsigned int pckr;
+	unsigned long rate;
 
 	regmap_read(prog->regmap, AT91_PMC_PCKR(prog->id), &pckr);
 
-	return parent_rate >> PROG_PRES(prog->layout, pckr);
+	if (layout->is_pres_direct)
+		rate = parent_rate / (PROG_PRES(layout, pckr) + 1);
+	else
+		rate = parent_rate >> PROG_PRES(layout, pckr);
+
+	return rate;
 }
 
 static int clk_programmable_determine_rate(struct clk_hw *hw,
 					   struct clk_rate_request *req)
 {
+	struct clk_programmable *prog = to_clk_programmable(hw);
+	const struct clk_programmable_layout *layout = prog->layout;
 	struct clk_hw *parent;
 	long best_rate = -EINVAL;
 	unsigned long parent_rate;
-	unsigned long tmp_rate;
+	unsigned long tmp_rate = 0;
 	int shift;
 	int i;
 
@@ -60,10 +68,18 @@ static int clk_programmable_determine_rate(struct clk_hw *hw,
 			continue;
 
 		parent_rate = clk_hw_get_rate(parent);
-		for (shift = 0; shift < PROG_PRES_MASK; shift++) {
-			tmp_rate = parent_rate >> shift;
-			if (tmp_rate <= req->rate)
-				break;
+		if (layout->is_pres_direct) {
+			for (shift = 0; shift <= layout->pres_mask; shift++) {
+				tmp_rate = parent_rate / (shift + 1);
+				if (tmp_rate <= req->rate)
+					break;
+			}
+		} else {
+			for (shift = 0; shift < layout->pres_mask; shift++) {
+				tmp_rate = parent_rate >> shift;
+				if (tmp_rate <= req->rate)
+					break;
+			}
 		}
 
 		if (tmp_rate > req->rate)
@@ -137,16 +153,23 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!div)
 		return -EINVAL;
 
-	shift = fls(div) - 1;
+	if (layout->is_pres_direct) {
+		shift = div - 1;
 
-	if (div != (1 << shift))
-		return -EINVAL;
+		if (shift > layout->pres_mask)
+			return -EINVAL;
+	} else {
+		shift = fls(div) - 1;
 
-	if (shift >= PROG_PRES_MASK)
-		return -EINVAL;
+		if (div != (1 << shift))
+			return -EINVAL;
+
+		if (shift >= layout->pres_mask)
+			return -EINVAL;
+	}
 
 	regmap_update_bits(prog->regmap, AT91_PMC_PCKR(prog->id),
-			   PROG_PRES_MASK << layout->pres_shift,
+			   layout->pres_mask << layout->pres_shift,
 			   shift << layout->pres_shift);
 
 	return 0;
@@ -202,19 +225,25 @@ at91_clk_register_programmable(struct regmap *regmap,
 }
 
 const struct clk_programmable_layout at91rm9200_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9g45_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 2,
 	.css_mask = 0x3,
 	.have_slck_mck = 1,
+	.is_pres_direct = 0,
 };
 
 const struct clk_programmable_layout at91sam9x5_programmable_layout = {
+	.pres_mask = 0x7,
 	.pres_shift = 4,
 	.css_mask = 0x7,
 	.have_slck_mck = 0,
+	.is_pres_direct = 0,
 };
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 672a79bda88c..a0e5ce9c9b9e 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -71,9 +71,11 @@ struct clk_pll_characteristics {
 };
 
 struct clk_programmable_layout {
+	u8 pres_mask;
 	u8 pres_shift;
 	u8 css_mask;
 	u8 have_slck_mck;
+	u8 is_pres_direct;
 };
 
 extern const struct clk_programmable_layout at91rm9200_programmable_layout;
diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index 1f70cb164b06..81943fac4537 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -125,6 +125,14 @@ static const struct {
 	  .pll = true },
 };
 
+static const struct clk_programmable_layout sama5d2_programmable_layout = {
+	.pres_mask = 0xff,
+	.pres_shift = 4,
+	.css_mask = 0x7,
+	.have_slck_mck = 0,
+	.is_pres_direct = 1,
+};
+
 static void __init sama5d2_pmc_setup(struct device_node *np)
 {
 	struct clk_range range = CLK_RANGE(0, 0);
@@ -249,7 +257,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 
 		hw = at91_clk_register_programmable(regmap, name,
 						    parent_names, 6, i,
-						    &at91sam9x5_programmable_layout);
+						    &sama5d2_programmable_layout);
 		if (IS_ERR(hw))
 			goto err_free;
 	}
-- 
2.17.1

