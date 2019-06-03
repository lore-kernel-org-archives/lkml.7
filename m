Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6EC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C6F271E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559584941;
	bh=WPTa+ED/246OYj8415zKZ77CKk/vlRlqAFighKe1jas=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=s81pptFuB7zQ48k5cmiK8yMcnn9DFoqRZI5Juq9iPsgQw0BTrRNRnm1/ubLkfIZ1C
	 CZbNlAtJObnMUzDrN5dp3pgLJfkDCUicxkYEEenmrM18bOYDaGQWs4LYWz3F+t4dqK
	 GsuOvYPa8kD49KIEQpNiyX5s9RCtP41dXvk5flK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFCSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:02:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55604 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfFCSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qOlHdD9QfolHUxVqixBQf4X5B9hBj9DYwrS94neTjKY=; b=tRvu0IJuRvU2
        4UxL0XtEy83RaHlenaJfdEl3W1g7apUCkrJmiG1Ci6iYaov8OyId+d++Krr2l411wnZegDgnjkE5+
        tTg+iwd/9QD6So4G6Niv8d33HfIjtyKYXAvhn3rXTgx3KS6VggjszduX4lq5V8aRecMoK9ZCgjjv4
        IqjXc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hXrHW-0003Z7-9W; Mon, 03 Jun 2019 18:02:02 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 78878440046; Mon,  3 Jun 2019 19:02:01 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: Applied "Revert "ASoC: core: use component driver name as component name"" to the asoc tree
In-Reply-To: <1559298842-15059-1-git-send-email-krzk@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20190603180201.78878440046@finisterre.sirena.org.uk>
Date:   Mon,  3 Jun 2019 19:02:01 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   Revert "ASoC: core: use component driver name as component name"

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

From 9d563eb95b81f32b9ffa4255033717484d50d06b Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 31 May 2019 12:34:02 +0200
Subject: [PATCH] Revert "ASoC: core: use component driver name as component
 name"

Using component driver as a name is not unique and it breaks audio in
certain configurations, e.g. Hardkernel Odroid XU3 board where following
components are registered:
 - "3830000.i2s" with driver name "snd_dmaengine_pcm"
 - "3830000.i2s-sec" with driver name "snd_dmaengine_pcm"
 - "3830000.i2s" with driver name "samsung-i2s"

This reverts commit b19671d6caf1ac393681864d5d85dda9fa99a448.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d3520fca613..7abb017a83f3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3113,10 +3113,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 {
 	struct snd_soc_dapm_context *dapm;
 
-	if (driver->name)
-		component->name = kstrdup(driver->name, GFP_KERNEL);
-	else
-		component->name = fmt_single_name(dev, &component->id);
+	component->name = fmt_single_name(dev, &component->id);
 	if (!component->name) {
 		dev_err(dev, "ASoC: Failed to allocate name\n");
 		return -ENOMEM;
-- 
2.20.1

