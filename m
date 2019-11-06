Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6625FC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386DE2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573057315;
	bh=VE5vkRe3MFeUD2//s8FzHmt7DQoPZJ0thztKl9CyqPA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=g834Z/IVKIUuQMiXYdT0PbPhHj1e13hhl3ykk4bWNIKlUJbnGKrcqeTxyc50xCeEn
	 vr0BP++UQDf8vHu4E1K7flVDtnfl73ttUDQKlxqG1kw1hGrd7TbW29JWf62Ewuj5PM
	 7+u9EFvAk3TwJA+Py9ugpXc8dsKextDnsh+zKNcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbfKFQVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:21:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53208 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfKFQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sY1LTU5lxUVLEh6S37lvZk7THzZIaZaTQC81eTfTnuk=; b=lg5npjXa7UrM
        o4APQc5VZqHpvfdeQeZpru4dy5KxjKxjwSpUPPY4n3raeWcBZufDG/x2uw8L+nBub+RiRVc7ZdkJg
        fomp+UmMLkCYNjZ4oq4BSSKZFng0+aR9ULXYERCeBkaLQk7FjjHUsWm1OaX7+nXBshQQ7sMPWuLfs
        jtiEw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iSO47-0001pF-NY; Wed, 06 Nov 2019 16:21:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 35F4B2743035; Wed,  6 Nov 2019 16:21:51 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: fan53555: add chip id for Silergy SYR83X" to the regulator tree
In-Reply-To: <20191106161211.1700663-1-anarsoul@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20191106162151.35F4B2743035@ypsilon.sirena.org.uk>
Date:   Wed,  6 Nov 2019 16:21:51 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fan53555: add chip id for Silergy SYR83X

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

From 5365e3df422938e6b34e1afdd2ff1cfc5768290e Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 6 Nov 2019 08:12:11 -0800
Subject: [PATCH] regulator: fan53555: add chip id for Silergy SYR83X

SYR83X is used in Rockpro64 and it has die ID == 9. All other
registers are the same as in SYR82X

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Link: https://lore.kernel.org/r/20191106161211.1700663-1-anarsoul@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fan53555.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index dbe477da4e55..00c83492f774 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -83,6 +83,7 @@ enum {
 
 enum {
 	SILERGY_SYR82X = 8,
+	SILERGY_SYR83X = 9,
 };
 
 struct fan53555_device_info {
@@ -302,6 +303,7 @@ static int fan53555_voltages_setup_silergy(struct fan53555_device_info *di)
 	/* Init voltage range and step */
 	switch (di->chip_id) {
 	case SILERGY_SYR82X:
+	case SILERGY_SYR83X:
 		di->vsel_min = 712500;
 		di->vsel_step = 12500;
 		break;
-- 
2.20.1

