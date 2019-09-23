Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE4C47E48
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32A221D7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569273793;
	bh=pCKg+2PogolszkaY7ZsYq/p4t00jT/BUvnHEy609X5E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ecuGKX1RonSWeo89451DIZ4E3skQXe2ASmgc7hPjb+7Ev05XgL0jmT2ZnjdBa7hqG
	 n8MJtxJzkNzE1i99DCTagXmbq+MLUIK9ZRBDzgCyngy85E8GEXWX9tQuMtzi2OVXNg
	 X1lcm30g6KHWn6urs7VdVXlUq/BvtbllSB/C82D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503012AbfIWVXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:23:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbfIWVXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0RChqD8gufqrC52I0W7my4ugNN03wWJCMZqZC40eNIs=; b=Va5BDDrVg2t+
        U4Yav0A2EiOeMbHZkmUFajYv/LmKTBlI5tNReHgN3OA53uZPAveYKacTgPr/zkN3h5GSe5Lm9Ki5E
        SmjnhDbDX+A1EY+kHVVymNGg80D1wD/ixNBQPVYbsfhqIxKTKS0wW0vUNhe+fygsptXmbb5ZxkMEq
        eMdKg=;
Received: from [12.157.10.114] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iCVnX-0005Wr-MK; Mon, 23 Sep 2019 21:23:07 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CFB9ED02FE4; Mon, 23 Sep 2019 22:23:05 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Applied "regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF" to the regulator tree
In-Reply-To: <20190922022928.28355-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Message-Id: <20190923212305.CFB9ED02FE4@fitzroy.sirena.org.uk>
Date:   Mon, 23 Sep 2019 22:23:05 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: fixed: Prevent NULL pointer dereference when !CONFIG_OF

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

From 1d6db22ff7d67a17c571543c69c63b1d261249b0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 22 Sep 2019 10:29:28 +0800
Subject: [PATCH] regulator: fixed: Prevent NULL pointer dereference when
 !CONFIG_OF

Use of_device_get_match_data which has NULL test for match before
dereference match->data. Add NULL test for drvtype so it still works
for fixed_voltage_ops when !CONFIG_OF.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Philippe Schenker <philippe.schenker@toradex.com>
Link: https://lore.kernel.org/r/20190922022928.28355-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/fixed.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d90a6fd8cbc7..f81533070058 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -144,8 +144,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fixed_voltage_config *config;
 	struct fixed_voltage_data *drvdata;
-	const struct fixed_dev_type *drvtype =
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	const struct fixed_dev_type *drvtype = of_device_get_match_data(dev);
 	struct regulator_config cfg = { };
 	enum gpiod_flags gflags;
 	int ret;
@@ -177,7 +176,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	drvdata->desc.type = REGULATOR_VOLTAGE;
 	drvdata->desc.owner = THIS_MODULE;
 
-	if (drvtype->has_enable_clock) {
+	if (drvtype && drvtype->has_enable_clock) {
 		drvdata->desc.ops = &fixed_voltage_clkenabled_ops;
 
 		drvdata->enable_clock = devm_clk_get(dev, NULL);
-- 
2.20.1

