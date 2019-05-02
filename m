Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F9AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6F9208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 02:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556763521;
	bh=Dcq3HMZ089dT2H0uJpY0MlvZg9Sw/j9m1tDjpVHY92s=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=yZS4Raj/DWwNyGMmGWMJY1LktlUa7mlJfyPCabQjCRuSKB64YgwV4FgLosAtg1Adg
	 Gqt2PAdyLlFCwt0ERYJsm3O6VYQachQBt8JJeF+KmbZPiTo0v9kG52y1tRT3CIjKV5
	 MYylvbO0FEOTjcIcKo0u712VaPCYPmy7YQkV1N9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEBCSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 22:18:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55504 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEBCSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 22:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=v7BNy5FY8VVxeuyTtTXhkNB4mGH8vIIA5LpX6bCLpJ8=; b=V1cGA/05FX50
        uuJCa27A5ApgejS5gJ9WHiWtsQZmO+GJz/0LxRIHZ+STJtN9zvkDjb7DsHCUjkWVSQQaqa0eEpK0X
        ca0it7N5oVyYWx+70SkLNp/NStgDY46CXcv0aSUtHCoLQadcYEygmlwWMYfbRsbCztdf5hhrD8vvB
        6tW00=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hM1Im-0005rm-Ua; Thu, 02 May 2019 02:18:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E7690441D3B; Thu,  2 May 2019 03:18:21 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>, pakki001@umn.edu,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt5645: fix a NULL pointer dereference" to the asoc tree
In-Reply-To:  <20190315034833.25037-1-kjlu@umn.edu>
X-Patchwork-Hint: ignore
Message-Id: <20190502021821.E7690441D3B@finisterre.ee.mobilebroadband>
Date:   Thu,  2 May 2019 03:18:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5645: fix a NULL pointer dereference

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

From 51dd97d1df5fb9ac58b9b358e63e67b530f6ae21 Mon Sep 17 00:00:00 2001
From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 22:48:32 -0500
Subject: [PATCH] ASoC: rt5645: fix a NULL pointer dereference

devm_kcalloc() may fail and return NULL. The fix returns ENOMEM
in case it fails to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9a0751978090..f842775dbf2c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3419,6 +3419,9 @@ static int rt5645_probe(struct snd_soc_component *component)
 		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
 		GFP_KERNEL);
 
+	if (!rt5645->eq_param)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.20.1

