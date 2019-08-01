Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B612CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F0216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564665091;
	bh=XeRdw1v6fsgVou1xhj+ESuCf7r3cNXoMPRfPzFRhk5I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=soJAvN6mQlQubAPtpFYXZVjEG0VnajI/svBAFtr14ZrrkhlO5ssWTxRlnN3GiqPma
	 OywRVv/yvyfsK+6P43hL0z0o91cMeG3di/zOMobYXRNJC0zQdrcjjjJZl9LxLdewtJ
	 dYBi4xCwVk6sIT0WXGo9zGqsIoG3scf3u780BDHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfHANLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:11:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731653AbfHANKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ib6QdFwiPwXCyGcMEswWrdPhve3VD0u4tgLDicN1YWs=; b=egMOuC/wJlKZ
        RHJSFW4HKZycbB1QNeuM+jFFGindLgtJi1dJ2Hk6AuBqTnUx4Nf2PQeeJQdHM2zbRoPeOYuAGU/M1
        r5MVI6UViXsGuBgoNvms79KpYox5khRAa8xDjBGJHGs1pniNxwLceo+cXBqorTFrOtT4XETm64RzP
        XzMDw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htAqu-0004io-GS; Thu, 01 Aug 2019 13:10:40 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AFA0C2742D28; Thu,  1 Aug 2019 14:10:39 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: core: no need to check return value of debugfs_create functions" to the asoc tree
In-Reply-To: <20190731131716.9764-2-gregkh@linuxfoundation.org>
X-Patchwork-Hint: ignore
Message-Id: <20190801131039.AFA0C2742D28@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:39 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: core: no need to check return value of debugfs_create functions

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

From fee531d6fc49b9a616525e30955c4cf3b403f632 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 31 Jul 2019 15:17:15 +0200
Subject: [PATCH] ASoC: core: no need to check return value of debugfs_create
 functions

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, there is no need to store the individual debugfs file name, just
remove the whole directory all at once, saving a local variable.

Note, the soc-pcm "state" file has now moved to a subdirectory, as it is
only a good idea to save the dentries for debugfs directories, not
individual files, as the individual file debugfs functions are changing
to not return a dentry.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20190731131716.9764-2-gregkh@linuxfoundation.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 43 ++++++-------------------------------------
 sound/soc/soc-dapm.c | 30 ++++--------------------------
 sound/soc/soc-pcm.c  | 14 ++++----------
 4 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d770606732cd..f0797792dd8d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1220,7 +1220,6 @@ struct snd_soc_card {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_card_root;
-	struct dentry *debugfs_pop_time;
 #endif
 	u32 pop_time;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index da11e44b01aa..ed66d2c68d10 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -165,13 +165,6 @@ static void soc_init_component_debugfs(struct snd_soc_component *component)
 				component->card->debugfs_card_root);
 	}
 
-	if (IS_ERR(component->debugfs_root)) {
-		dev_warn(component->dev,
-			"ASoC: Failed to create component debugfs directory: %ld\n",
-			PTR_ERR(component->debugfs_root));
-		return;
-	}
-
 	snd_soc_dapm_debugfs_init(snd_soc_component_get_dapm(component),
 		component->debugfs_root);
 }
@@ -215,32 +208,15 @@ DEFINE_SHOW_ATTRIBUTE(component_list);
 
 static void soc_init_card_debugfs(struct snd_soc_card *card)
 {
-	if (!snd_soc_debugfs_root)
-		return;
-
 	card->debugfs_card_root = debugfs_create_dir(card->name,
 						     snd_soc_debugfs_root);
-	if (IS_ERR(card->debugfs_card_root)) {
-		dev_warn(card->dev,
-			 "ASoC: Failed to create card debugfs directory: %ld\n",
-			 PTR_ERR(card->debugfs_card_root));
-		card->debugfs_card_root = NULL;
-		return;
-	}
 
-	card->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
-						    card->debugfs_card_root,
-						    &card->pop_time);
-	if (IS_ERR(card->debugfs_pop_time))
-		dev_warn(card->dev,
-			 "ASoC: Failed to create pop time debugfs file: %ld\n",
-			 PTR_ERR(card->debugfs_pop_time));
+	debugfs_create_u32("dapm_pop_time", 0644, card->debugfs_card_root,
+			   &card->pop_time);
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 {
-	if (!card->debugfs_card_root)
-		return;
 	debugfs_remove_recursive(card->debugfs_card_root);
 	card->debugfs_card_root = NULL;
 }
@@ -248,19 +224,12 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR_OR_NULL(snd_soc_debugfs_root)) {
-		pr_warn("ASoC: Failed to create debugfs directory\n");
-		snd_soc_debugfs_root = NULL;
-		return;
-	}
 
-	if (!debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
-				 &dai_list_fops))
-		pr_warn("ASoC: Failed to create DAI list debugfs file\n");
+	debugfs_create_file("dais", 0444, snd_soc_debugfs_root, NULL,
+			    &dai_list_fops);
 
-	if (!debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
-				 &component_list_fops))
-		pr_warn("ASoC: Failed to create component list debugfs file\n");
+	debugfs_create_file("components", 0444, snd_soc_debugfs_root, NULL,
+			    &component_list_fops);
 }
 
 static void snd_soc_debugfs_exit(void)
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e16838e1bda2..d93c1038fab0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2154,50 +2154,28 @@ static const struct file_operations dapm_bias_fops = {
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
-	struct dentry *d;
-
 	if (!parent || IS_ERR(parent))
 		return;
 
 	dapm->debugfs_dapm = debugfs_create_dir("dapm", parent);
 
-	if (IS_ERR(dapm->debugfs_dapm)) {
-		dev_warn(dapm->dev,
-			 "ASoC: Failed to create DAPM debugfs directory %ld\n",
-			 PTR_ERR(dapm->debugfs_dapm));
-		return;
-	}
-
-	d = debugfs_create_file("bias_level", 0444,
-				dapm->debugfs_dapm, dapm,
-				&dapm_bias_fops);
-	if (IS_ERR(d))
-		dev_warn(dapm->dev,
-			 "ASoC: Failed to create bias level debugfs file: %ld\n",
-			 PTR_ERR(d));
+	debugfs_create_file("bias_level", 0444, dapm->debugfs_dapm, dapm,
+			    &dapm_bias_fops);
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct dentry *d;
 
 	if (!dapm->debugfs_dapm || !w->name)
 		return;
 
-	d = debugfs_create_file(w->name, 0444,
-				dapm->debugfs_dapm, w,
-				&dapm_widget_power_fops);
-	if (IS_ERR(d))
-		dev_warn(w->dapm->dev,
-			 "ASoC: Failed to create %s debugfs file: %ld\n",
-			 w->name, PTR_ERR(d));
+	debugfs_create_file(w->name, 0444, dapm->debugfs_dapm, w,
+			    &dapm_widget_power_fops);
 }
 
 static void dapm_debugfs_cleanup(struct snd_soc_dapm_context *dapm)
 {
-	if (!dapm->debugfs_dapm)
-		return;
 	debugfs_remove_recursive(dapm->debugfs_dapm);
 	dapm->debugfs_dapm = NULL;
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 30264bc592f6..ce7297c37537 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1205,9 +1205,9 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "<-" : "->", be->dai_link->name);
 
 #ifdef CONFIG_DEBUG_FS
-	if (fe->debugfs_dpcm_root)
-		dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
-				fe->debugfs_dpcm_root, &dpcm->state);
+	dpcm->debugfs_state = debugfs_create_dir(be->dai_link->name,
+						 fe->debugfs_dpcm_root);
+	debugfs_create_u32("state", 0644, dpcm->debugfs_state, &dpcm->state);
 #endif
 	return 1;
 }
@@ -1262,7 +1262,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
 #ifdef CONFIG_DEBUG_FS
-		debugfs_remove(dpcm->debugfs_state);
+		debugfs_remove_recursive(dpcm->debugfs_state);
 #endif
 		spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 		list_del(&dpcm->list_be);
@@ -3415,12 +3415,6 @@ void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 
 	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
 			rtd->card->debugfs_card_root);
-	if (!rtd->debugfs_dpcm_root) {
-		dev_dbg(rtd->dev,
-			 "ASoC: Failed to create dpcm debugfs directory %s\n",
-			 rtd->dai_link->name);
-		return;
-	}
 
 	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
 			    rtd, &dpcm_state_fops);
-- 
2.20.1

