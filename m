Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA9C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528A6222C7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569930055;
	bh=gWLGKFAVaPVUPdR7wZMSfqjVF5L9izPGWIc1RsW7g9Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DA4/TYbWkSNFucoD4tTubB+QLIgS3J8icMwpYIlwLK1PwaX67UwURvdkbr0fNPgyb
	 ysTTCcjJOBPbR19c7daDt2o1qH+GkWngPm9IWjKfs8W25Pg4QjfOGeHeWwZ5tqlx8l
	 aIEJ+HU+POxRzdiI43xGCZ/vpAKnW8A35YySPl/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfJALky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:40:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbfJALky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=+gqFQySrShV/ToSh8YGHlEnWI1hCCq31xeGoKbe2xP8=; b=W6+VhIelim16
        88zCkz/rOj4zN0jeG1fTJB2sQdqgKIRWUbskh8rnG2yZOw3/dzTeSqk3/AkE03V52p9H5WIc2T32r
        zbQTwiI49zMC75YmcNFGM73DgP5pKKXqv0qI/H4cM7CfKlYsi6blQdfAPmFZjTg1qOthqj0ce+ZVv
        JEDPc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iFGWN-0004Sl-FO; Tue, 01 Oct 2019 11:40:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E68622742A10; Tue,  1 Oct 2019 12:40:46 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pierre-louis.bossart@intel.com, ranjani.sridharan@intel.com
Subject: Applied "ASoC: core: Clarify usage of ignore_machine" to the asoc tree
In-Reply-To: <20190925183358.11955-1-daniel.baluta@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20191001114046.E68622742A10@ypsilon.sirena.org.uk>
Date:   Tue,  1 Oct 2019 12:40:46 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: Clarify usage of ignore_machine

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

From 49f9c4f2e83cf562f1a6e3f62eafa4ede5343e4a Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 25 Sep 2019 21:33:58 +0300
Subject: [PATCH] ASoC: core: Clarify usage of ignore_machine

For a sound card ignore_machine means that existing FEs links should be
ignored and existing BEs links should be overridden with some information
from the matching component driver.

Current code make some confusions about this so fix it!

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20190925183358.11955-1-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d2842a383846..4a47ba94559f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1859,7 +1859,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 
 	for_each_component(component) {
 
-		/* does this component override FEs ? */
+		/* does this component override BEs ? */
 		if (!component->driver->ignore_machine)
 			continue;
 
@@ -1880,7 +1880,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 				continue;
 			}
 
-			dev_info(card->dev, "info: override FE DAI link %s\n",
+			dev_info(card->dev, "info: override BE DAI link %s\n",
 				 card->dai_link[i].name);
 
 			/* override platform component */
-- 
2.20.1

