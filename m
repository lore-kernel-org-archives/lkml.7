Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6407C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6FF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573820782;
	bh=6DHLSqXIf4J3iwTdc7lXQp2Fc5+t7djvLaP5nivb9EU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=mRftilgOoL47ndD8IA/FT2gy+tBN7T3AluEj2f4pgzzjJmcQ/a8+EV4bOaf8JwpCU
	 Odb2vpr/X9wmNdlkeLYUz/oM4Nofypq5g/1gqMmMao0O5yACW++VS1nkJwklIr27pt
	 CHXv2S/pv7pRmaO95VZ3iVY8Bnm8LdoRqYIkMQk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKOMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:25:15 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32832 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbfKOMZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=WhivmarhjnWVrpuxW2+0Mno7dKVQIUl8/k+Us9L6ZW0=; b=Y1lX6qjjYG+D
        39zSRf/fkQPMr5uJhN+oiJiEqE0j8yzY8AolT5jHTIrrpJRE9avhmVSGqAuILtg2TfnaHaO29WsPi
        me24IQ5zdJMSD2CH3J3Z16WvTiO7Q9VxmXXmjNTLClAzKyA85cr1Fp4P+1AmzgWHC45SOeESaCCsk
        HwN7Y=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVaey-0000Kz-Vt; Fri, 15 Nov 2019 12:25:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 79111274162A; Fri, 15 Nov 2019 12:25:08 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: core: Don't try to remove device links if add failed" to the regulator tree
In-Reply-To: <20191115000438.45970-1-saravanak@google.com>
X-Patchwork-Hint: ignore
Message-Id: <20191115122508.79111274162A@ypsilon.sirena.org.uk>
Date:   Fri, 15 Nov 2019 12:25:08 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Don't try to remove device links if add failed

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

From b59b654478093fa429ad4c7897ae29f201146a00 Mon Sep 17 00:00:00 2001
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 14 Nov 2019 16:04:38 -0800
Subject: [PATCH] regulator: core: Don't try to remove device links if add
 failed

device_link_add() might not always succeed depending on the type of
device link and the rest of the dependencies in the system. If
device_link_add() didn't succeed, then we shouldn't try to remove the
link later on as it might remove a link someone else created.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20191115000438.45970-1-saravanak@google.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c     | 8 ++++++--
 drivers/regulator/internal.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 51ce280c1ce1..df49f35ae20f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1844,6 +1844,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
 	const char *devname = dev ? dev_name(dev) : "deviceless";
+	struct device_link *link;
 	int ret;
 
 	if (get_type >= MAX_GET_TYPE) {
@@ -1951,7 +1952,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			rdev->use_count = 0;
 	}
 
-	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+	link = device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+	if (!IS_ERR_OR_NULL(link))
+		regulator->device_link = true;
 
 	return regulator;
 }
@@ -2046,7 +2049,8 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
-		device_link_remove(regulator->dev, &rdev->dev);
+		if (regulator->device_link)
+			device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 83ae442f515b..2391b565ef11 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -36,6 +36,7 @@ struct regulator {
 	struct list_head list;
 	unsigned int always_on:1;
 	unsigned int bypass:1;
+	unsigned int device_link:1;
 	int uA_load;
 	unsigned int enable_count;
 	unsigned int deferred_disables;
-- 
2.20.1

