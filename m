Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED371C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF51F205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864350;
	bh=0c6Jh9sp14Lq4lNe2LNf826gtJ4onGQ0WuWN1zlFr50=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=m+8LDzStfmG5jQ0csFeuWQBJLtJtb2B88DGVOQbSi22md5IBck6otOlGXAEutUvS0
	 SA+nxsKlYhz5PTimV5kM2FHpno6s013NF6s9d2Z0ddjJwj63uszINeOj1trj50GKiM
	 erdB400PEfkpufBH3UzbzQUHKhu3/J2Jrfmyq+gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfECGTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:19:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfECGTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=uJRhtLsdNNAJveJ+s2NSgBPxfvfgbqKbRQ8fG+F4ZtQ=; b=EpiYeFc2gBU5
        WCworeBojym7JVod3w8cpM7Bv7QsF9f8ZBSSwpRgjJofdctwIJFRH6FioRGkKM76VngiOy4gsDG7h
        zcW+GBomTWex2MpWPhHplD1b2UfCklyslMqvfDrpp7QqcR5mEmPsoFuyayzXeUmrA73SLnLf1A80i
        ZhYug=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRX6-0000Yg-Ac; Fri, 03 May 2019 06:18:57 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 659BD441D3C; Fri,  3 May 2019 07:18:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab3100: Constify regulator_ops and ab3100_regulator_desc" to the regulator tree
In-Reply-To: <20190502142233.24730-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503061849.659BD441D3C@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:18:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab3100: Constify regulator_ops and ab3100_regulator_desc

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.2

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

From 95602d7d77f502d656e648ab38f8e0586364e7dc Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 2 May 2019 22:22:32 +0800
Subject: [PATCH] regulator: ab3100: Constify regulator_ops and
 ab3100_regulator_desc

These regulator_ops variables and ab3100_regulator_desc array never need
to be modified, make them const so compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab3100.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index c92966a79a7e..edde907a7062 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -353,14 +353,14 @@ static int ab3100_get_voltage_regulator_external(struct regulator_dev *reg)
 		return 0;
 }
 
-static struct regulator_ops regulator_ops_fixed = {
+static const struct regulator_ops regulator_ops_fixed = {
 	.list_voltage = regulator_list_voltage_linear,
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
 };
 
-static struct regulator_ops regulator_ops_variable = {
+static const struct regulator_ops regulator_ops_variable = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -369,7 +369,7 @@ static struct regulator_ops regulator_ops_variable = {
 	.list_voltage = regulator_list_voltage_table,
 };
 
-static struct regulator_ops regulator_ops_variable_sleepable = {
+static const struct regulator_ops regulator_ops_variable_sleepable = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -385,14 +385,14 @@ static struct regulator_ops regulator_ops_variable_sleepable = {
  * is an on/off switch plain an simple. The external
  * voltage is defined in the board set-up if any.
  */
-static struct regulator_ops regulator_ops_external = {
+static const struct regulator_ops regulator_ops_external = {
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
 	.get_voltage = ab3100_get_voltage_regulator_external,
 };
 
-static struct regulator_desc
+static const struct regulator_desc
 ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 	{
 		.name = "LDO_A",
@@ -499,7 +499,7 @@ static int ab3100_regulator_register(struct platform_device *pdev,
 				     struct device_node *np,
 				     unsigned long id)
 {
-	struct regulator_desc *desc;
+	const struct regulator_desc *desc;
 	struct ab3100_regulator *reg;
 	struct regulator_dev *rdev;
 	struct regulator_config config = { };
@@ -688,7 +688,7 @@ static int ab3100_regulators_probe(struct platform_device *pdev)
 
 	/* Register the regulators */
 	for (i = 0; i < AB3100_NUM_REGULATORS; i++) {
-		struct regulator_desc *desc = &ab3100_regulator_desc[i];
+		const struct regulator_desc *desc = &ab3100_regulator_desc[i];
 
 		err = ab3100_regulator_register(pdev, plfdata, NULL, NULL,
 						desc->id);
-- 
2.20.1

