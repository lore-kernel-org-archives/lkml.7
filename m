Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D3B2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568736184;
	bh=SC9A9SL+WnYZPaoUvCIxeEzZuU3RwiQigj0dk2pI45s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=BXLArq7SFpglLGLV2XIkECcIcTQnkkpMMQEYv9fBifY8z2B5E6meclBHMcy8oVdpS
	 Y3LSRMpdzR3bPw0rTO9diBtLESBJBlVfaOPgmFedWguj2xkT31lK0JM/32JDQD1DcC
	 ayV/jIbLR9GbQFI8KAJ2ZN2zKAS+GgcWIQ+xvv8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfIQQDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:03:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56602 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfIQQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=/M/fOjDQ+Zo+8bebbcMVeC86g6OVbUO01r27K1imY6I=; b=kadmkpxV7Yno
        2ncoDn7rKzErK7JRTxVmQqRSyG9wfWjifYIzayUTLZzH64dxXFwrTfCUCG+7vx1SMXQq7Xv0k00dV
        T3gcJmzXVH/yFAB1JuIxi3xcMODzPwtKRG3HUFn/tigwbJr739KboGCMGmfCwoXhER9iSkvdRy9s4
        xXd7k=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iAFwO-0008OP-3c; Tue, 17 Sep 2019 16:02:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2340427428EA; Tue, 17 Sep 2019 17:02:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     broonie@kernel.org, ckeepax@opensource.cirrus.com,
        dianders@chromium.org, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        zhang.chunyan@linaro.org
Subject: Applied "regulator: core: make regulator_register() EPROBE_DEFER aware" to the regulator tree
In-Reply-To: <20190917154021.14693-4-m.felsch@pengutronix.de>
X-Patchwork-Hint: ignore
Message-Id: <20190917160255.2340427428EA@ypsilon.sirena.org.uk>
Date:   Tue, 17 Sep 2019 17:02:55 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: make regulator_register() EPROBE_DEFER aware

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

From f8970d341eec73c976a3462b9ecdb02b60b84dd6 Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Tue, 17 Sep 2019 17:40:21 +0200
Subject: [PATCH] regulator: core: make regulator_register() EPROBE_DEFER aware

Sometimes it can happen that the regulator_of_get_init_data() can't
retrieve the config due to a not probed device the regulator depends on.
Fix that by checking the return value of of_parse_cb() and return
EPROBE_DEFER in such cases.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20190917154021.14693-4-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 13 +++++++++++++
 drivers/regulator/of_regulator.c | 19 ++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index afe94470b67f..a46be221dbdc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5053,6 +5053,19 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
 					       &rdev->dev.of_node);
+
+	/*
+	 * Sometimes not all resources are probed already so we need to take
+	 * that into account. This happens most the time if the ena_gpiod comes
+	 * from a gpio extender or something else.
+	 */
+	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
+		kfree(config);
+		kfree(rdev);
+		ret = -EPROBE_DEFER;
+		goto rinse;
+	}
+
 	/*
 	 * We need to keep track of any GPIO descriptor coming from the
 	 * device tree until we have handled it over to the core. If the
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 38dd06fbab38..ef7198b76e50 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -445,11 +445,20 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		goto error;
 	}
 
-	if (desc->of_parse_cb && desc->of_parse_cb(child, desc, config)) {
-		dev_err(dev,
-			"driver callback failed to parse DT for regulator %pOFn\n",
-			child);
-		goto error;
+	if (desc->of_parse_cb) {
+		int ret;
+
+		ret = desc->of_parse_cb(child, desc, config);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(child);
+				return ERR_PTR(-EPROBE_DEFER);
+			}
+			dev_err(dev,
+				"driver callback failed to parse DT for regulator %pOFn\n",
+				child);
+			goto error;
+		}
 	}
 
 	*node = child;
-- 
2.20.1

