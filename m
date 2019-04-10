Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B76C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7436C2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899210;
	bh=fKhcKM7hDmndjlLPsNJ09h7JGdAh/vVWvSdyPyZlRo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yFi8hWgssA9NjZgqJwA7zPKaX3cxvYzsk1EvXKllxPH+04hegoBkIlAAPH9D/TAuK
	 vJNdZn/vfEXb8njyPDtpkmYgWjUtXkDBut+HPdp5O0x/9q+RLedQ1jW5h/Wqg1faYE
	 +ltouLssq5rByzcl7xprja7/D6T4Ahc6RlRlpdDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbfDJM0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:26:49 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35312 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDJM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Vq7pQjXmIhtA1U4IHIsm3JYCx5WSWVuu6fnOjPuoyUs=; b=sn939UOpyuVp
        z7ZUpL+d/pDP1K6FoDyWNd23tV1QNQ/n2naGxY4G5PDKQBx4hyrk13B8KD8kjFoYtsTRj/D7zrPR4
        xFAy3D2+RkLn5r9q9HK5fbIqZ9lhoUK+0Q11D39qFzFUs4oRY2tfojge5HHKhatT6OJaTmZJwdoa9
        y1mdg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECJE-00005h-2W; Wed, 10 Apr 2019 12:26:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 8683F1128ED2; Wed, 10 Apr 2019 13:26:31 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     alsa-devel@alsa-project.org,
        Brian Austin <brian.austin@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>, kjlu@umn.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        pakki001@umn.edu, Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: cs43130: fix a NULL pointer dereference" to the asoc tree
In-Reply-To: <20190315035120.25913-1-kjlu@umn.edu>
X-Patchwork-Hint: ignore
Message-Id: <20190410122631.8683F1128ED2@debutante.sirena.org.uk>
Date:   Wed, 10 Apr 2019 13:26:31 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cs43130: fix a NULL pointer dereference

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

From 51e3724aec01d30852f61d924ad01ce3ea782a0f Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 22:51:20 -0500
Subject: [PATCH] ASoC: cs43130: fix a NULL pointer dereference

In case create_singlethread_workqueue fails, the fix returns
-ENOMEM to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 3f7b255587e6..80d672710eae 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2322,6 +2322,8 @@ static int cs43130_probe(struct snd_soc_component *component)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
+		if (!cs43130->wq)
+			return -ENOMEM;
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
 	}
 
-- 
2.20.1

