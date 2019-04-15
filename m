Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5319FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A6720833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555318434;
	bh=Umlcx838bxRueMAKJ81E4zM0lftOx5Boa69vPav+NHg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=L8Er47ieYwMqEi/gfP5pqxs+NX3QLawP5O7DZjjPQk2R4/D6lmHK8CZpbglL2cSAt
	 T7WcPD9khrdhaVn8RxHjCnznU4hwOG1RF7D0vCwM9hny/JLJwO+MBBH5Wnjxu3WEjC
	 WW7Gq/zAUSLDtXp0cJcyGahUz/fyavv9DSkL2/Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfDOIxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:53:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35734 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfDOIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=LZwf/acHI+kQRSbyMjJZdqwVrcq8eOnfC/goSW/c9mA=; b=QigTeadmbR0r
        cY6cEp4N/GzKAKgmIDZis/Iujiu0eRqd0k5K1npQkXoasuj82PbTGQxQxSk1ZiwaouXgDBMs1pjWY
        pR1LwLvOVRloPOlAi/eLjTtKC/ajYo5jZTLCa0vb/5rAFuXVkiFLYBknXwy/luLHQH7lOKWZNY2N9
        GTh2M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hFxMv-0007j6-UC; Mon, 15 Apr 2019 08:53:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E40BF11279F6; Mon, 15 Apr 2019 09:53:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ab8500: Constify regulator_ops" to the regulator tree
In-Reply-To: <20190412141158.21246-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190415085331.E40BF11279F6@debutante.sirena.org.uk>
Date:   Mon, 15 Apr 2019 09:53:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ab8500: Constify regulator_ops

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

From 6d66d9952ec06f12197174018be76538150aea05 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 12 Apr 2019 22:11:57 +0800
Subject: [PATCH] regulator: ab8500: Constify regulator_ops

These regulator_ops variables never need to be modified, make them const so
compiler can put them to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ab8500.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 83dba3fbfe0c..6b9a3463f1fd 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -510,7 +510,7 @@ static int ab8500_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static struct regulator_ops ab8500_regulator_volt_mode_ops = {
+static const struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -522,7 +522,7 @@ static struct regulator_ops ab8500_regulator_volt_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_volt_ops = {
+static const struct regulator_ops ab8500_regulator_volt_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
@@ -531,7 +531,7 @@ static struct regulator_ops ab8500_regulator_volt_ops = {
 	.list_voltage	= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_mode_ops = {
+static const struct regulator_ops ab8500_regulator_mode_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
@@ -541,14 +541,14 @@ static struct regulator_ops ab8500_regulator_mode_ops = {
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_ops = {
+static const struct regulator_ops ab8500_regulator_ops = {
 	.enable			= ab8500_regulator_enable,
 	.disable		= ab8500_regulator_disable,
 	.is_enabled		= ab8500_regulator_is_enabled,
 	.list_voltage		= regulator_list_voltage_table,
 };
 
-static struct regulator_ops ab8500_regulator_anamic_mode_ops = {
+static const struct regulator_ops ab8500_regulator_anamic_mode_ops = {
 	.enable		= ab8500_regulator_enable,
 	.disable	= ab8500_regulator_disable,
 	.is_enabled	= ab8500_regulator_is_enabled,
-- 
2.20.1

