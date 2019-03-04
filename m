Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB020657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551713539;
	bh=9LA78jFKqLuj0A3b4AFtYkf2IODbBqKzsN9DmPj8Cew=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s+pC6iZNAdtsywZrpiYNucAXAyqfYXtC71i2NlQ3OJ0qMZQ58NO9qjt5ZyxMpuD0E
	 FvT162B0EZtlXH9v1SbIpwGc9ec2pBpcQjtQKiTMRbfTHigtR6MhFaN1RaBMZMSlnf
	 XCJC7iSR3qQNtvDqDOAtUpgBXtJvxndfJnitvdes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfCDPcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:32:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54814 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jiVWuDT/GQk6Wlskt4mJQBm18D9PbJVEOjeeu06zrvA=; b=QQiKmKF8z2Fu
        OqRXoxgR4g7Cv6ehq6FQ1qK90axTBNL/iSHZgUFBNgHIyMFiiPdfkL2Lu1L3TTyVHj0G+SMgnqlTi
        s1OpzVzRQ+FVokFLF3ELK9FkKqf8hk/ghtdBGXPWf11c3bre1yMBK1xtEtBqJtuEZivDhUCdIPBCV
        ghgB0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h0pZW-000307-GW; Mon, 04 Mar 2019 15:32:06 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F5D71128814; Mon,  4 Mar 2019 15:32:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@google.com>,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: soc-core: Fix probe deferral following prelink failure" to the asoc tree
In-Reply-To:  <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190304153205.4F5D71128814@debutante.sirena.org.uk>
Date:   Mon,  4 Mar 2019 15:32:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-core: Fix probe deferral following prelink failure

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From c342febcde452f817cbd3896dc40953ab17c309d Mon Sep 17 00:00:00 2001
From: Jonathan Hunter <jonathanh@nvidia.com>
Date: Mon, 4 Mar 2019 13:31:14 +0000
Subject: [PATCH] ASoC: soc-core: Fix probe deferral following prelink failure

Commit 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
re-worked the clean-up of any platform pointers that may have been
initialised by the function snd_soc_init_platform(). This commit missed
one error path where if any of the prelinks for a soundcard failed to
initialise, then these platform pointers would not be cleaned-up. This
then prevents the soundcard from being initialised following a probe
deferral when any of the soundcard prelinks cannot be found.

Fix this by ensuring that soc_cleanup_platform() is called when
initialising the soundcard prelinks fails.

Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")

Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 93d316d5bf8e..5a5764dba147 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2797,6 +2797,7 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 		ret = soc_init_dai_link(card, link);
 		if (ret) {
+			soc_cleanup_platform(card);
 			dev_err(card->dev, "ASoC: failed to init link %s\n",
 				link->name);
 			mutex_unlock(&client_mutex);
-- 
2.20.1

