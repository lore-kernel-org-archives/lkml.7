Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC45C06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FFC218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562243124;
	bh=1CUK3irh/73Kz2Z4/gjX6kWZ9RET22dA24YyyRYKa8c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=K5jIOeEUwWVhbJ1MqZ5Snd6fx/TEW2HeH4ReFkEDxbgvarh6h8wCwxuT+GnjDR5yQ
	 AvBaB4O10L/HYdYY2qHkOhA1cvsF1/wwv5k4g//gvL7xssjoRB0YUBpCOxSq3D97t8
	 3hzQXeW5X1NP2sbMKkU9aQT7M9CUQ9jh85kbdH5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfGDMZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:25:23 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35562 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGDMZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Y/uabhd3emfe7XPsaHIK1+FGOSTXpQE94AD/6SuEfgE=; b=ezkYFefEQmYe
        rGWCMpdXPmuNyXgIK0V7tI0X0lIFxDRzeovtryDyWogcRzPyGuDo0ycyik4wXYWn2J9/ydRDgn5bc
        RzJIH5sV6Mx3xtnOPQ7p9zgBEZjSGXwaZyNHhE6YQf6qfYc0ijCh2+/BSSjbaT2PK7lAETMI3INkQ
        F5gU4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hj0nS-0000jZ-EO; Thu, 04 Jul 2019 12:25:06 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D03D92743897; Thu,  4 Jul 2019 13:25:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: max77620: remove redundant assignment to variable ret" to the regulator tree
In-Reply-To: <20190703082009.18779-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190704122505.D03D92743897@ypsilon.sirena.org.uk>
Date:   Thu,  4 Jul 2019 13:25:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: max77620: remove redundant assignment to variable ret

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.3

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

From a3c7c029c3da01645f2db1bf7737668d17c2c78a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 3 Jul 2019 09:20:09 +0100
Subject: [PATCH] regulator: max77620: remove redundant assignment to variable
 ret

The variable ret is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190703082009.18779-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/max77620-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 2ae2d319321b..8d9731e4052b 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -467,7 +467,7 @@ static int max77620_regulator_is_enabled(struct regulator_dev *rdev)
 {
 	struct max77620_regulator *pmic = rdev_get_drvdata(rdev);
 	int id = rdev_get_id(rdev);
-	int ret = 1;
+	int ret;
 
 	if (pmic->active_fps_src[id] != MAX77620_FPS_SRC_NONE)
 		return 1;
-- 
2.20.1

