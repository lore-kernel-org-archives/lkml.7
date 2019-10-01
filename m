Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4863C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AA321924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569952623;
	bh=+UAQcsuPkgHp4/EgGQDvPMJm7y4eaiFHdIQbJylvblE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=GqDjVk3HuZAK1mbVNTVTlPSp0EkzZk4FaZ1eMsTA2XJPPo9HXWrX3Kw1hA7wQklvq
	 JpDxZ+mY9/QVPHOoiuzRTPes1/AL3PTs+IeINP5LLMOiKRD8wCxbF+UbE5CsTJ82ll
	 yWZ9G56DsjNG/x4FwjjeEXu2/w4r+LsR3weQDPx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfJAR5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:57:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52034 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJAR5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=D7ujo6plX3S7fzgUrhxaeYkQb7VKPy3SwTAx2uSQ3KM=; b=CCWsaypF77Y2
        7ClPseKxCqhJU+6yH7KHErlf21R3L01IFTurfFfPBN+VSADdS60p3ZY7mc0YXY/5aWfNpIKOKwfNS
        /rccFu9gzudbc6iQ6do+M6G78tod677hwmHjEwuxzWwNn+DBUy5mAekWgweYGA8NcVRPHKE6XFFgN
        pCi4w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFMOO-0005ui-1a; Tue, 01 Oct 2019 17:56:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 888452742A10; Tue,  1 Oct 2019 18:56:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     "Cc:"@sirena.co.uk, "Cc:"@sirena.co.uk, csong@cs.ucr.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhiyunq@cs.ucr.edu
Subject: Applied "regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized" to the regulator tree
In-Reply-To: <20190929170957.14775-1-yzhai003@ucr.edu>
X-Patchwork-Hint: ignore
Message-Id: <20191001175655.888452742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 18:56:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized

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

From 1252b283141f03c3dffd139292c862cae10e174d Mon Sep 17 00:00:00 2001
From: Yizhuo <yzhai003@ucr.edu>
Date: Sun, 29 Sep 2019 10:09:57 -0700
Subject: [PATCH] regulator: pfuze100-regulator: Variable "val" in
 pfuze100_regulator_probe() could be uninitialized

In function pfuze100_regulator_probe(), variable "val" could be
initialized if regmap_read() fails. However, "val" is used to
decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Link: https://lore.kernel.org/r/20190929170957.14775-1-yzhai003@ucr.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index df5df1c495ad..689537927f6f 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -788,7 +788,13 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 
 		/* SW2~SW4 high bit check and modify the voltage value table */
 		if (i >= sw_check_start && i <= sw_check_end) {
-			regmap_read(pfuze_chip->regmap, desc->vsel_reg, &val);
+			ret = regmap_read(pfuze_chip->regmap,
+						desc->vsel_reg, &val);
+			if (ret) {
+				dev_err(&client->dev, "Fails to read from the register.\n");
+				return ret;
+			}
+
 			if (val & sw_hi) {
 				if (pfuze_chip->chip_id == PFUZE3000 ||
 					pfuze_chip->chip_id == PFUZE3001) {
-- 
2.20.1

