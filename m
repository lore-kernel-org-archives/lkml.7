Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43BC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691B720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfGHEZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:25:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:10931 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfGHEZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:25:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 21:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="155760951"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2019 21:25:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkLDq-0004gP-DF; Mon, 08 Jul 2019 12:25:50 +0800
Date:   Mon, 8 Jul 2019 12:25:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     kbuild-all@01.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] mfd: bd70528: bit0_offsets[] can be static
Message-ID: <20190708042548.GA30795@lkp-kbuild12>
References: <201907081224.B6QvwFVw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907081224.B6QvwFVw%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 21b7c58fc194 ("mfd: bd70528: Support ROHM bd70528 PMIC core")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 rohm-bd70528.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/rohm-bd70528.c b/drivers/mfd/rohm-bd70528.c
index 55599d5..43c859f 100644
--- a/drivers/mfd/rohm-bd70528.c
+++ b/drivers/mfd/rohm-bd70528.c
@@ -106,14 +106,14 @@ static struct regmap_config bd70528_regmap = {
  */
 
 /* bit [0] - Shutdown register */
-unsigned int bit0_offsets[] = {0};	/* Shutdown register */
-unsigned int bit1_offsets[] = {1};	/* Power failure register */
-unsigned int bit2_offsets[] = {2};	/* VR FAULT register */
-unsigned int bit3_offsets[] = {3};	/* PMU register interrupts */
-unsigned int bit4_offsets[] = {4, 5};	/* Charger 1 and Charger 2 registers */
-unsigned int bit5_offsets[] = {6};	/* RTC register */
-unsigned int bit6_offsets[] = {7};	/* GPIO register */
-unsigned int bit7_offsets[] = {8};	/* Invalid operation register */
+static unsigned int bit0_offsets[] = {0};	/* Shutdown register */
+static unsigned int bit1_offsets[] = {1};	/* Power failure register */
+static unsigned int bit2_offsets[] = {2};	/* VR FAULT register */
+static unsigned int bit3_offsets[] = {3};	/* PMU register interrupts */
+static unsigned int bit4_offsets[] = {4, 5};	/* Charger 1 and Charger 2 registers */
+static unsigned int bit5_offsets[] = {6};	/* RTC register */
+static unsigned int bit6_offsets[] = {7};	/* GPIO register */
+static unsigned int bit7_offsets[] = {8};	/* Invalid operation register */
 
 static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
