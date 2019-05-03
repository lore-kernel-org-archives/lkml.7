Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE852089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556864635;
	bh=DtRkhsRTEVGy/5JNaQdHrxuwwPT2DKwxYrFqi/4DC/k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=dskptgUl5ixqPMEcpJNHppa8dWOvqu+Yj1xSfBbW7SOVdG2MYVfF/d0ckany27sEA
	 lRWZdHISHpe7xG4C+mR4Rya3el8JS6LG0qZgNc/vILB3jzWZRuEErpiKmG34ZhZ+hr
	 Cn4gm+k4kOK0qSeLJEUJM2gjrkPmexXHSDlfZcUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfECGXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:23:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33838 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfECGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=RUsRVfQr6MguLInMJKL39V77To+2NWYQGfs+Cy74AZc=; b=NkGRGt58nnZO
        IM3V8QdBSWJ8YbKkEu7yNWcvGpSfCMg76nCUyvK3qAFdNkOPCCWwyCyqwAKCGpypNA9oeanyd4+sE
        IQTxBjYE9r4l0E1PJt91E/DMEEAJBS5mXGNPDigv8JBz50uGtv9xv3CbD5CQODsR1w7qa392X6uMI
        M2bpM=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRbn-0000li-4r; Fri, 03 May 2019 06:23:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 63DAA441D57; Fri,  3 May 2019 07:23:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab3100: Set fixed_uV instead of min_uV for fixed regulators" to the regulator tree
In-Reply-To: <20190502142233.24730-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190503062338.63DAA441D57@finisterre.ee.mobilebroadband>
Date:   Fri,  3 May 2019 07:23:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab3100: Set fixed_uV instead of min_uV for fixed regulators

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

From e219c2b3dc773a5a78f88ada9e07e281a9dad06b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 2 May 2019 22:22:33 +0800
Subject: [PATCH] regulator: ab3100: Set fixed_uV instead of min_uV for fixed
 regulators

Slightly better readability by setting fixed_uV instead of min_uV.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab3100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/ab3100.c b/drivers/regulator/ab3100.c
index edde907a7062..438509f55f05 100644
--- a/drivers/regulator/ab3100.c
+++ b/drivers/regulator/ab3100.c
@@ -354,7 +354,6 @@ static int ab3100_get_voltage_regulator_external(struct regulator_dev *reg)
 }
 
 static const struct regulator_ops regulator_ops_fixed = {
-	.list_voltage = regulator_list_voltage_linear,
 	.enable      = ab3100_enable_regulator,
 	.disable     = ab3100_disable_regulator,
 	.is_enabled  = ab3100_is_enabled_regulator,
@@ -401,7 +400,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_A_VOLTAGE,
+		.fixed_uV = LDO_A_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
@@ -411,7 +410,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_C_VOLTAGE,
+		.fixed_uV = LDO_C_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
@@ -421,7 +420,7 @@ ab3100_regulator_desc[AB3100_NUM_REGULATORS] = {
 		.n_voltages = 1,
 		.type = REGULATOR_VOLTAGE,
 		.owner = THIS_MODULE,
-		.min_uV = LDO_D_VOLTAGE,
+		.fixed_uV = LDO_D_VOLTAGE,
 		.enable_time = 200,
 	},
 	{
-- 
2.20.1

