Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB12C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186D8208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565615406;
	bh=ed8cvhCeUt9nMG22em/qrbvQlOMQzni1OBwNXHBdwrA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=HENbEj8o6faPZqzBtMumT+XMiIzfUCtxbgJMBomwj9R33NinUcxIZyp7TbVZCHz6+
	 uIExsCSFL3x415F/h7epN21rDgs8TC2XavJhTgQFMuVjF3ZnBjJuboi4o1eT6WkWAM
	 7l/9A6m4pGxNmNcraWu6+HxNgGKhbF81EhfgDCOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfHLNKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:10:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40102 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfHLNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=3sNecu+h/sBkIJYA1BBnNt/IkAXt6S+W553O/rgURsA=; b=wt3ZTOTgywjf
        TCLCy0QgxFCzYswbhdngjdeaA29TPIN6x928WU12LEd2sCAPP3pvhr4+F37yNp8r2Pwyr36d4rAo+
        If45K/cYMOSPreVCi0jE/C7kOMTJjc4j6l9H78lcmE0p0pW7mGMIH8x2qiKlQuh+m8X/DlOE6fNXW
        ReQc0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxA58-0001Ly-Up; Mon, 12 Aug 2019 13:09:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 5D45B2740CBD; Mon, 12 Aug 2019 14:09:50 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: dapm: Invalidate only paths reachable for a given stream" to the asoc tree
In-Reply-To: <20190809084034.26220-1-szymonx.mielczarek@linux.intel.com>
X-Patchwork-Hint: ignore
Message-Id: <20190812130950.5D45B2740CBD@ypsilon.sirena.org.uk>
Date:   Mon, 12 Aug 2019 14:09:50 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: Invalidate only paths reachable for a given stream

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

From 872f3ac583cb00c14a4dc86b1511cf98618dd671 Mon Sep 17 00:00:00 2001
From: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Date: Fri, 9 Aug 2019 10:40:34 +0200
Subject: [PATCH] ASoC: dapm: Invalidate only paths reachable for a given
 stream

By resetting the cached number of endpoints for all card's widgets we may
overwrite previously cached values for other streams. The situation may
happen especially when running streams simultaneously.

Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Link: https://lore.kernel.org/r/20190809084034.26220-1-szymonx.mielczarek@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d09bdca63c62..10819b3e0b98 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1128,6 +1128,34 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	return 0;
 }
 
+/*
+ * Recursively reset the cached number of inputs or outputs for the specified
+ * widget and all widgets that can be reached via incoming or outcoming paths
+ * from the widget.
+ */
+static void invalidate_paths_ep(struct snd_soc_dapm_widget *widget,
+	enum snd_soc_dapm_direction dir)
+{
+	enum snd_soc_dapm_direction rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
+	struct snd_soc_dapm_path *path;
+
+	widget->endpoints[dir] = -1;
+
+	snd_soc_dapm_widget_for_each_path(widget, rdir, path) {
+		if (path->weak || path->is_supply)
+			continue;
+
+		if (path->walking)
+			return;
+
+		if (path->connect) {
+			path->walking = 1;
+			invalidate_paths_ep(path->node[dir], dir);
+			path->walking = 0;
+		}
+	}
+}
+
 /*
  * Common implementation for is_connected_output_ep() and
  * is_connected_input_ep(). The function is inlined since the combined size of
@@ -1257,21 +1285,17 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	/*
-	 * For is_connected_{output,input}_ep fully discover the graph we need
-	 * to reset the cached number of inputs and outputs.
-	 */
-	list_for_each_entry(w, &card->widgets, list) {
-		w->endpoints[SND_SOC_DAPM_DIR_IN] = -1;
-		w->endpoints[SND_SOC_DAPM_DIR_OUT] = -1;
-	}
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		paths = is_connected_output_ep(dai->playback_widget, &widgets,
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_OUT);
+		paths = is_connected_output_ep(w, &widgets,
 				custom_stop_condition);
-	else
-		paths = is_connected_input_ep(dai->capture_widget, &widgets,
+	} else {
+		w = dai->capture_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_IN);
+		paths = is_connected_input_ep(w, &widgets,
 				custom_stop_condition);
+	}
 
 	/* Drop starting point */
 	list_del(widgets.next);
-- 
2.20.1

