Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FA4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029DE21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570211584;
	bh=D48/gZdSPpXgBlPNLO3NoJizQlbXv3x/q5xuF5rUphQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Qr0vPvsTZHHlhmxwpHi8fhF3wZ4JunCYA7QNelQGQLinGyF6yfc8IWJUwQ7j1PvIU
	 wsvYMQ9t4614H8+hrrKFfR2/EHbR1yZyEeqHa2LxWHcqpABkVkgi3n8gCPR7z412uL
	 CvoxVOQ1OLuZnt+9cYaWwB/mAte5aGxPrbZsYV2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389046AbfJDRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:53:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51398 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389012AbfJDRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9rMD/iIRt+AstMhHvit3hB7IN7ex8Ugxf6OLt9MXTjw=; b=DGL87zhYsfQq
        Q6fWG2jJZXD8hMQtWWddWRzLFW2gdL8ciheUJKNIb09GW5eDofezelfeLSj5rvsdlhSOQsVyVYlaI
        mwGdxG2YpnKu8rup3WlrOgGYyf9Bea8/TiFfC5LkDYc5tYd11TuarP1rA9saitkF+d0O9G5opUCVs
        mdc2k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iGRkq-0003v7-5d; Fri, 04 Oct 2019 17:52:36 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A47FE2741EF2; Fri,  4 Oct 2019 18:52:35 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     alsa-devel@alsa-project.org, Frank Shi <shifu0704@thundersoft.com>,
        Jaroslav Kysela <perex@perex.cz>, kbuild-all@01.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "tas2770: fix platform_no_drv_owner.cocci warnings" to the asoc tree
In-Reply-To: <20191001175504.ufhyxh66psrht42k@332d0cec05f4>
X-Patchwork-Hint: ignore
Message-Id: <20191004175235.A47FE2741EF2@ypsilon.sirena.org.uk>
Date:   Fri,  4 Oct 2019 18:52:35 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   tas2770: fix platform_no_drv_owner.cocci warnings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From 5a7423993007d08bfc7b982451eca0526f51744d Mon Sep 17 00:00:00 2001
From: kbuild test robot <lkp@intel.com>
Date: Wed, 2 Oct 2019 01:55:04 +0800
Subject: [PATCH] tas2770: fix platform_no_drv_owner.cocci warnings

sound/soc/codecs/tas2770.c:796:3-8: No need to set .owner here. The core will do it.

 Remove .owner field if calls are used which set it automatically

Generated by: scripts/coccinelle/api/platform_no_drv_owner.cocci

Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
CC: Frank Shi <shifu0704@thundersoft.com>
Signed-off-by: kbuild test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20191001175504.ufhyxh66psrht42k@332d0cec05f4
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2770.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9da88ccb1d51..dbbb21fe0548 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -793,7 +793,6 @@ MODULE_DEVICE_TABLE(of, tas2770_of_match);
 static struct i2c_driver tas2770_i2c_driver = {
 	.driver = {
 		.name   = "tas2770",
-		.owner  = THIS_MODULE,
 		.of_match_table = of_match_ptr(tas2770_of_match),
 	},
 	.probe      = tas2770_i2c_probe,
-- 
2.20.1

