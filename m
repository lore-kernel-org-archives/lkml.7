Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F36206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381586;
	bh=udDeJmUAQ5LIgp6a6OmWCs4xJNTOv3isJQb3qVPwmJE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=SCtku0RKp3ixW8OHLLcjLxgjY1PnUHjYe3K3nd1zbBBmUhQw6XMRT++Y/oqGpTDPK
	 lIpeqT6aeKmludKFO98YD1N2qeBsE5f/EaCaYT95RpAdXsSN7mb8koWdb2xvA4adnd
	 av0/Ade2ML6O7aubI6UaoifKUEBvPZRy7NGpUPXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLCN7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:59:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37932 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfLCN7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=23pZh/k+1l1O15MY03oxgfdLXRGpMmkK+UR833sf8QM=; b=F0pDfev0fmA7
        4sJknH81OhIqcqBwA8QKCl86AJBy3TFzmYFLxdvIpV97Ou5RMY2OT6pEoxUjph2RzdFFvuQhLwH4O
        PYONvHjlQHnVuBqcPAiDPGCr/Priv0mlr/X0LT9q8bfIfaQ48lQ247vGtZxvMGM6c2eFenPUdyvi5
        Qpd2s=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic8iK-0002bs-7v; Tue, 03 Dec 2019 13:59:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id F2E28D002FA; Tue,  3 Dec 2019 13:59:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, xlpang@linux.alibaba.com
Subject: Applied "regulator: core: fix regulator_register() error paths to properly release rdev" to the regulator tree
In-Reply-To: <20191201030250.38074-1-wenyang@linux.alibaba.com>
Message-Id: <applied-20191201030250.38074-1-wenyang@linux.alibaba.com>
X-Patchwork-Hint: ignore
Date:   Tue,  3 Dec 2019 13:59:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: fix regulator_register() error paths to properly release rdev

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.5

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

From a3cde9534ebdafe18a9bbab208df724c57e6c8e8 Mon Sep 17 00:00:00 2001
From: Wen Yang <wenyang@linux.alibaba.com>
Date: Sun, 1 Dec 2019 11:02:50 +0800
Subject: [PATCH] regulator: core: fix regulator_register() error paths to
 properly release rdev

There are several issues with the error handling code of
the regulator_register() function:
        ret = device_register(&rdev->dev);
        if (ret != 0) {
                put_device(&rdev->dev); --> rdev released
                goto unset_supplies;
        }
...
unset_supplies:
...
        unset_regulator_supplies(rdev); --> use-after-free
...
clean:
        if (dangling_of_gpiod)
                gpiod_put(config->ena_gpiod);
        kfree(rdev);                     --> double free

We add a variable to record the failure of device_register() and
move put_device() down a bit to avoid the above issues.

Fixes: c438b9d01736 ("regulator: core: Move registration of regulator device")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20191201030250.38074-1-wenyang@linux.alibaba.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c80f3fd9532d..2c3a03cfd381 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4998,6 +4998,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	struct regulator_dev *rdev;
 	bool dangling_cfg_gpiod = false;
 	bool dangling_of_gpiod = false;
+	bool reg_device_fail = false;
 	struct device *dev;
 	int ret, i;
 
@@ -5183,7 +5184,7 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
-		put_device(&rdev->dev);
+		reg_device_fail = true;
 		goto unset_supplies;
 	}
 
@@ -5213,7 +5214,10 @@ regulator_register(const struct regulator_desc *regulator_desc,
 clean:
 	if (dangling_of_gpiod)
 		gpiod_put(config->ena_gpiod);
-	kfree(rdev);
+	if (reg_device_fail)
+		put_device(&rdev->dev);
+	else
+		kfree(rdev);
 	kfree(config);
 rinse:
 	if (dangling_cfg_gpiod)
-- 
2.20.1

