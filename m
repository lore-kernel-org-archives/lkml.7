Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40738C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E2120835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519359;
	bh=DzUet4X2fI4SkxxaKmcA4XHUE4zPR7wtw+CIim1LrsA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=beKFYEk7HTW74zs85ZS+v5aw4k4930eeJtnei9FArl0AuNjR3mX9VTO+Xu+b8z8hg
	 hYmkWaI8vaKtddt1TUuEQnJte+1r4YYyv7owh36ZuVmycMiXRvtZONvlTjThFfukzv
	 UBmP55mugL/4aKciRhKKn7rUT0qLqSj5/75lTYaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbfDQQmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:42:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37624 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732937AbfDQQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vll6DizoBPDWtabXDDVM5zbIdbu41auEcnb2SRX+tqg=; b=tLTjGRAfCxKE
        Tai8SYbb6vQoZiC5NxoD2gHIItGWOQ/95H2ChyZkvH3Wxvrg1RSnjALFyRkmUEYPQjaEkJHwqmSY/
        O2zIbTlML/VJSYrt7s3Z4W0oZigkgCf1LEUHebEtvkL31w71LYZDf9qTRMQiUZn4PPw2CSpHEHYyE
        0OYHA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGndY-000155-LL; Wed, 17 Apr 2019 16:42:16 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 64D971128FC8; Wed, 17 Apr 2019 17:42:16 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>, kbuild-all@01.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Applied "regulator: ready_mask_table[] can be static" to the regulator tree
In-Reply-To: <20190415165238.GA71613@lkp-sb05>
X-Patchwork-Hint: ignore
Message-Id: <20190417164216.64D971128FC8@debutante.sirena.org.uk>
Date:   Wed, 17 Apr 2019 17:42:16 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ready_mask_table[] can be static

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

From 82f26185a91298a21aa33a985893dd5f8ed4c75a Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Tue, 16 Apr 2019 00:52:38 +0800
Subject: [PATCH] regulator: ready_mask_table[] can be static

Fixes: 6cdae8173f67 ("regulator: Add support for stm32 power regulators")
Signed-off-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stm32-pwr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index e434b26d4c8b..222d593d76a2 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -32,7 +32,7 @@ enum {
 	STM32PWR_REG_NUM_REGS
 };
 
-u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
+static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
 	[PWR_REG11] = REG_1_1_RDY,
 	[PWR_REG18] = REG_1_8_RDY,
 	[PWR_USB33] = USB_3_3_RDY,
@@ -44,7 +44,7 @@ struct stm32_pwr_reg {
 	u32 ready_mask;
 };
 
-int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
@@ -54,7 +54,7 @@ int stm32_pwr_reg_is_ready(struct regulator_dev *rdev)
 	return (val & priv->ready_mask);
 }
 
-int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
+static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
 {
 	struct stm32_pwr_reg *priv = rdev_get_drvdata(rdev);
 	u32 val;
-- 
2.20.1

