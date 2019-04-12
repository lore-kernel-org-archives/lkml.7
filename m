Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77520818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555059224;
	bh=YUlBE0DW962MXyGvmh8St2b4oL4u0+xTLMid5Zf2KMI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=EAyPoE2i17Fi27YjgQw8NMEkp7fqPKBvsXppcXQcH+7XESjh4pr0zeskDrHQfl0fj
	 3j+24zS1zOdxRZQbgemF9krOJrowJmB6lB3ocCGJyCaAzzrViAf8vIxDDMrICBeYnp
	 KRaTeQAdGhJslgvu/8oHlsOqRSKaYRh3NrP1FIjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfDLIx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:53:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfDLIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=kOqLDS9SDh8KZTaLtJ+ZTzxtcgEu7M5Rxyz4uUyusZU=; b=vtXTv/v8bLha
        AOCZ2VN2+3M0xZtTBK5HJYksztPZTKlB4GwsRRLFr71iB1+bHVulX9iSDgoJs9d6Yl7qgujf34uwd
        1gTs7dieSm0X0WdqNL03s+hfFH5jlGG/5/+t6WIM2njdRVmP6gZL2MxFBs8G73va7j0WD+JFoyB+F
        RSw7k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hErw2-00068F-IV; Fri, 12 Apr 2019 08:53:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0B8271127945; Fri, 12 Apr 2019 09:53:22 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Bengt Jonsson <bengt.g.jonsson@stericsson.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Subject: Applied "regulator: dbx500-prcmu: Remove unused fields from struct dbx500_regulator_info" to the regulator tree
In-Reply-To: <20190412015421.27078-3-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190412085322.0B8271127945@debutante.sirena.org.uk>
Date:   Fri, 12 Apr 2019 09:53:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dbx500-prcmu: Remove unused fields from struct dbx500_regulator_info

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

From 2564002abcde7e655bd0bab7f5f3a592ca586e58 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 09:54:21 +0800
Subject: [PATCH] regulator: dbx500-prcmu: Remove unused fields from struct
 dbx500_regulator_info

The *dev is assigned but not used, remove it.
Current driver is using devm_regulator_register(), so no neeed to save
*rdev for clean up. Use a local variable instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/db8500-prcmu.c | 10 +++++-----
 drivers/regulator/dbx500-prcmu.h |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index c2a3ccfc510e..eb317663f875 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -439,6 +439,7 @@ static int db8500_regulator_probe(struct platform_device *pdev)
 	struct regulator_init_data *db8500_init_data;
 	struct dbx500_regulator_info *info;
 	struct regulator_config config = { };
+	struct regulator_dev *rdev;
 	int err, i;
 
 	db8500_init_data = dev_get_platdata(&pdev->dev);
@@ -446,17 +447,16 @@ static int db8500_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(dbx500_regulator_info); i++) {
 		/* assign per-regulator data */
 		info = &dbx500_regulator_info[i];
-		info->dev = &pdev->dev;
 
 		config.driver_data = info;
 		config.dev = &pdev->dev;
 		if (db8500_init_data)
 			config.init_data = &db8500_init_data[i];
 
-		info->rdev = devm_regulator_register(&pdev->dev, &info->desc,
-						     &config);
-		if (IS_ERR(info->rdev)) {
-			err = PTR_ERR(info->rdev);
+		rdev = devm_regulator_register(&pdev->dev, &info->desc,
+					       &config);
+		if (IS_ERR(rdev)) {
+			err = PTR_ERR(rdev);
 			dev_err(&pdev->dev, "failed to register %s: err %i\n",
 				info->desc.name, err);
 			return err;
diff --git a/drivers/regulator/dbx500-prcmu.h b/drivers/regulator/dbx500-prcmu.h
index c8e51ace9f06..6e20dab611ac 100644
--- a/drivers/regulator/dbx500-prcmu.h
+++ b/drivers/regulator/dbx500-prcmu.h
@@ -15,18 +15,14 @@
 
 /**
  * struct dbx500_regulator_info - dbx500 regulator information
- * @dev: device pointer
  * @desc: regulator description
- * @rdev: regulator device pointer
  * @is_enabled: status of the regulator
  * @epod_id: id for EPOD (power domain)
  * @is_ramret: RAM retention switch for EPOD (power domain)
  *
  */
 struct dbx500_regulator_info {
-	struct device *dev;
 	struct regulator_desc desc;
-	struct regulator_dev *rdev;
 	bool is_enabled;
 	u16 epod_id;
 	bool is_ramret;
-- 
2.20.1

