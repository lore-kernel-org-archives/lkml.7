Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C29C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10662146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553001223;
	bh=0ScjT3AT/QiQulqfdAIfBTI5mEuso9T5dQjPP8NH8i0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=R3y18J76VtP81EHTlMc4X5xASVcF43ESOddgpLp7Wi5NyhlLfqFoPl1tW1bLW8Dgt
	 qgTEzqB1NApQaBJIn89k3bPfdhUNMXLYBCPJyovlFusoZrmziR5PlxA+B94A6G3uK6
	 bdd5LLqRxooKx/YNMIedRkbIrzN8C2mdU/A5ooxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfCSNNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:13:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCSNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dp45jNXyoYbfR1g7f0VLfv9Vj5pIyWjumGy63fsWeuI=; b=RyRoK0l2Kbkj
        Yhsjw9AH0qKWcKGkpdRsg5uMIRk7Y5MPNKiBMAXElTDuHESTiqfG1LoHqULFdKPFIEx69jXn7spem
        mIqF+uz4ngFF7yZ07RSbUxy+nYWox7dquVUPRlhWY7kwimrSompDjvw5bMpzKrZ0U5urS6/Yiudui
        qRYKU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h6EYk-00039U-4M; Tue, 19 Mar 2019 13:13:38 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9905511288DF; Tue, 19 Mar 2019 13:13:37 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Replace code by already existing function" to the regmap tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190319131337.9905511288DF@debutante.sirena.org.uk>
Date:   Tue, 19 Mar 2019 13:13:37 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: debugfs: Replace code by already existing function

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From a1c67d65df0b5a3858741a144cd43f8e62c5c175 Mon Sep 17 00:00:00 2001
From: Lucas Tanure <tanureal@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 09:41:32 +0000
Subject: [PATCH] regmap: debugfs: Replace code by already existing function

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 19eb454f26c3..648779e6df88 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -219,10 +219,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
 
 	for (i = start_reg; i <= to; i += map->reg_stride) {
-		if (!regmap_readable(map, i) && !regmap_cached(map, i))
-			continue;
-
-		if (regmap_precious(map, i))
+		if (!regmap_printable(map, i))
 			continue;
 
 		/* If we're in the region the user is trying to read */
-- 
2.20.1

