Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43198206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498801;
	bh=87B3KyjIqZhyQ/fc3YyvyXERoC6DjibJuZncyRoFRUU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=1MAyGt1M9Qr4Cj67j4T7rlZydxboHO6stXlpbVlas1rJzvlB/JI1tYfzWOxZOylP3
	 tiYLnrteq6HahTH6BwajmdYe4E4wuoaoIHA+hAQO+Lr9hljeK/w8HJijmXKCh2u30R
	 sWPPhVxjdrTmsgayxZH9cFqMJdezI2Gx5LplBJ4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfHVSdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:33:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390741AbfHVSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=KE93PKy0vRrd3WeN6rOwohc7yTA6nQ5nPKHYKjUcZDM=; b=cxrDZK6RlbAL
        1SlQ5Dsseb2papFWd2oTamK04jDXZo9RlgWC6+JSeAO82m5QFN9FgfWlpJ58RUzKrsvFbQc4pBLLY
        OC9UUNekP+6l7LvjkXc8c//esq+vrNkwBxXNt3gf3bwf5IQiJDlxQaww+XfK4H34iPHf6AJDgCVTe
        N0HtM=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0rtR-0007fg-BC; Thu, 22 Aug 2019 18:33:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3AE96D02CE6; Thu, 22 Aug 2019 19:32:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, matthias.bgg@gmail.com,
        perex@perex.cz, pihsun@chromium.org, swboyd@chromium.org,
        tiwai@suse.com, yuehaibing@huawei.com
Subject: Applied "ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings" to the asoc tree
In-Reply-To: <20190822143747.20944-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Message-Id: <20190822183257.3AE96D02CE6@fitzroy.sirena.org.uk>
Date:   Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings

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

From 97aad5ce88164bc5f884b5234f015ac553ea2fe5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:37:47 +0800
Subject: [PATCH] ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings

sound/soc/mediatek/mt2701/mt2701-afe-common.h:66:27: warning:
 mt2701_afe_backup_list defined but not used [-Wunused-const-variable=]

mt2701_afe_backup_list is only used in mt2701-afe-pcm.c,
so just move the definition over there.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190822143747.20944-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-common.h | 21 -------------------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index d44faba27d3c..32bef5e2a56d 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -63,27 +63,6 @@ enum audio_base_clock {
 	MT2701_BASE_CLK_NUM,
 };
 
-static const unsigned int mt2701_afe_backup_list[] = {
-	AUDIO_TOP_CON0,
-	AUDIO_TOP_CON4,
-	AUDIO_TOP_CON5,
-	ASYS_TOP_CON,
-	AFE_CONN0,
-	AFE_CONN1,
-	AFE_CONN2,
-	AFE_CONN3,
-	AFE_CONN15,
-	AFE_CONN16,
-	AFE_CONN17,
-	AFE_CONN18,
-	AFE_CONN19,
-	AFE_CONN20,
-	AFE_CONN21,
-	AFE_CONN22,
-	AFE_DAC_CON0,
-	AFE_MEMIF_PBUF_SIZE,
-};
-
 struct mt2701_i2s_data {
 	int i2s_ctrl_reg;
 	int i2s_asrc_fs_shift;
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d7f5defa50c2..76502ba261c8 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -60,6 +60,27 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
 	{ .rate = 352800, .regvalue = 24 },
 };
 
+static const unsigned int mt2701_afe_backup_list[] = {
+	AUDIO_TOP_CON0,
+	AUDIO_TOP_CON4,
+	AUDIO_TOP_CON5,
+	ASYS_TOP_CON,
+	AFE_CONN0,
+	AFE_CONN1,
+	AFE_CONN2,
+	AFE_CONN3,
+	AFE_CONN15,
+	AFE_CONN16,
+	AFE_CONN17,
+	AFE_CONN18,
+	AFE_CONN19,
+	AFE_CONN20,
+	AFE_CONN21,
+	AFE_CONN22,
+	AFE_DAC_CON0,
+	AFE_MEMIF_PBUF_SIZE,
+};
+
 static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
 {
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-- 
2.20.1

