Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F66C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D50A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563798188;
	bh=3e9NuREs1eC1WwvujAzu78fkbGAfB66CEEGjBMrkThc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Fym25AWjo4rIJCBoAmYLLVUlqW2EJtwbhqpLrcdBGMSEU2wcFv91H8QikXjcpAV0M
	 uxlE7phkqSLipKziMTjwmEsSN2BFYR3tynZEXVHZyeaAbodAoyw5WlnDL3SRyFQy1S
	 I6/wL3pXr0DhvkS8dm4XpMBIbbF+i+jjTIsZgddg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfGVMXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:23:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58692 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfGVMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1YYrtFyJ0Ttd+Xvk2FDy/peCTQJ9kNEyVkmLdHZHaaw=; b=GNzBsxDEPi6a
        xf9G6VnPq18D+IFFzeNvK+3XopxYY/oi5xJEomTbe5BEZrOG9l1lQ2nXvivuRnRVkFgLMZ4gFWaFV
        oZI/RBCQ8QJYngoR6l9HLqJQ8csD+UMJk4Sq1IRiGo0CL79BYlbM1H/DFU8/ypDZx7/QKTyeou7Zl
        eileM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpXKa-0007fa-Dq; Mon, 22 Jul 2019 12:22:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D4340274046A; Mon, 22 Jul 2019 13:22:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Milo Kim <milo.kim@ti.com>
Subject: Applied "regulator: lm363x: Fix n_voltages setting for lm36274" to the regulator tree
In-Reply-To: <20190626132632.32629-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190722122215.D4340274046A@ypsilon.sirena.org.uk>
Date:   Mon, 22 Jul 2019 13:22:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lm363x: Fix n_voltages setting for lm36274

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 962f170d9344e5d9edb3903971c591f42d55e226 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 26 Jun 2019 21:26:32 +0800
Subject: [PATCH] regulator: lm363x: Fix n_voltages setting for lm36274
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

According to the datasheet http://www.ti.com/lit/ds/symlink/lm36274.pdf:
Table 23. VPOS Bias Register Field Descriptions VPOS[5:0]:
VPOS voltage (50-mV steps): VPOS = 4 V + (Code × 50 mV), 6.5 V max
000000 = 4 V
000001 = 4.05 V
:
011110 = 5.5 V (Default)
:
110010 = 6.5 V
110011 to 111111 map to 6.5 V

So the LM36274_LDO_VSEL_MAX should be 0b110010 (0x32).
The valid selectors are 0 ... LM36274_LDO_VSEL_MAX, n_voltages should be
LM36274_LDO_VSEL_MAX + 1. Similarly, the n_voltages should be
LM36274_BOOST_VSEL_MAX + 1 for LM36274_BOOST.

Fixes: bff5e8071533 ("regulator: lm363x: Add support for LM36274")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20190626132632.32629-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lm363x-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index e4a27d63bf90..4b9f618b07e9 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -36,7 +36,7 @@
 
 /* LM36274 */
 #define LM36274_BOOST_VSEL_MAX		0x3f
-#define LM36274_LDO_VSEL_MAX		0x34
+#define LM36274_LDO_VSEL_MAX		0x32
 #define LM36274_VOLTAGE_MIN		4000000
 
 /* Common */
@@ -226,7 +226,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vboost",
 		.id             = LM36274_BOOST,
 		.ops            = &lm363x_boost_voltage_table_ops,
-		.n_voltages     = LM36274_BOOST_VSEL_MAX,
+		.n_voltages     = LM36274_BOOST_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
@@ -239,7 +239,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vpos",
 		.id             = LM36274_LDO_POS,
 		.ops            = &lm363x_regulator_voltage_table_ops,
-		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
@@ -254,7 +254,7 @@ static const struct regulator_desc lm363x_regulator_desc[] = {
 		.of_match	= "vneg",
 		.id             = LM36274_LDO_NEG,
 		.ops            = &lm363x_regulator_voltage_table_ops,
-		.n_voltages     = LM36274_LDO_VSEL_MAX,
+		.n_voltages     = LM36274_LDO_VSEL_MAX + 1,
 		.min_uV         = LM36274_VOLTAGE_MIN,
 		.uV_step        = LM363X_STEP_50mV,
 		.type           = REGULATOR_VOLTAGE,
-- 
2.20.1

