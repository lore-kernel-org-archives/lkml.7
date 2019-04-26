Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CFC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3302084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556271659;
	bh=8VuQpOA4jISLuYFOK4XE94BQW08uJOWkMHofL24Q9kg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gc62y791n0XQAhc4LrmoTyrQapzCLs7kx4o4Ud8XF0Bx6xX7xqbthu+dYVnIppIJl
	 Uti182Z3w2xCr2BjmbxTl4ZqjfIGgG62Wt37kbquOOaoeIJtejEw4BRBjMVnHTpeat
	 goCKErzLpt0jtTs7VlVYV1/VXTSvBmZvzIYx4SJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDZJk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:40:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46294 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfDZJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=axDDG7PwE6M2jCoK5T7mMY0IW7GHNhqDrSLPGCwYrMQ=; b=L/Q33884yb0W
        RhA23ee16Y+A9m//VqDmjanS2bxIn+ZYJ8amMW96qmQ6B+hQaQmMUq3bfOss7mEjymts58mTFjxab
        GMYRtriooGRRIfyux/Jpb4xpEUUg0xaotDrpD/OLgNfQ+ADGaD7p00HIqbXSXVC9NXJpeBetm/vGa
        3QDwA=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJxLT-0003Jq-LM; Fri, 26 Apr 2019 09:40:39 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4A560441D3B; Fri, 26 Apr 2019 10:40:38 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: ready_mask_table[] can be static" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190426094038.4A560441D3B@finisterre.ee.mobilebroadband>
Date:   Fri, 26 Apr 2019 10:40:38 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: ready_mask_table[] can be static

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

