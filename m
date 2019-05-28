Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED26C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BC8206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559056031;
	bh=ou8JsaICJ3QygIcsB/rlV+LYgWx2MufRMb6XVhCdwfE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=e1KWHlGh74bpw46Pu/GV6+0cZvqT+kn/o8VIXHjqDtlGiT3/OsGcEOuDvyLHyHqZB
	 aDe2lL+K2hhaZuj57rqcwecaLcOU2nQF7hcjzK+iz/v4bh5kKUNhxozJMz63ysV/Zm
	 TTo+kkx94nL+2oeem9UAYao2JW5WfL+UkI+UPVTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfE1PHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:07:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42856 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfE1PHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DRrmUfZErlU0wblgTemga0P+08sSa7slNopRc/Wl/bM=; b=vXgRzWpF6smn
        +rDhJ9B6evMagY+iFx+xzZkbVqYI//DRzVwbBoH4u+RPwj1dX+cQ7frf09DbtFsVHsACbGreiwQzB
        3xXoi5GZnHXJNuM5KlAJHsvWEBkXxsnfC7RUoJujjMsBpHcsPUGWu/aWaK1vP94V95aHPa9+r8qOP
        BwUeE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hVdgr-0002oR-BF; Tue, 28 May 2019 15:07:01 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id A5290440046; Tue, 28 May 2019 16:07:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Simon Ho <simon.ho@conexant.com>, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: cx2072x: remove redundant assignment to pulse_len" to the asoc tree
In-Reply-To: <20190524214419.25075-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190528150700.A5290440046@finisterre.sirena.org.uk>
Date:   Tue, 28 May 2019 16:07:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: cx2072x: remove redundant assignment to pulse_len

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

From 9b33d2e526c53b0339ddba8b875bb8b8b3a11207 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 24 May 2019 22:44:19 +0100
Subject: [PATCH] ASoC: cx2072x: remove redundant assignment to pulse_len

Variable pulse_len is being initialized to 1 however this value is
never read and pulse_len is being re-assigned later in a switch
statement.  Clean up the code by removing the redundant initialization.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 23d2b25fe04c..c11a585bbf70 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -679,7 +679,7 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
-	int pulse_len = 1;
+	int pulse_len;
 	int frame_len = cx2072x->frame_size;
 	int sample_size = cx2072x->sample_size;
 	int i2s_right_slot;
-- 
2.20.1

