Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E82C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81D82054F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568023655;
	bh=MrTNXsT09ZqMhj3ZONh5F8+EYPoy1oBlZOw4AT3UgSs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=fZvXzd3AMgj36bKnndLjkdzMQ3Wit/zTQzCLZJmQSMlu02fnjM9T4bw0XKspdirJP
	 A8A9uTffJA1+BXYQfYLb9oEGH/RZi4ye7Y2+jJc+ymbp6b9Y4tzG2aC6RhKZwgPDSq
	 YoYOvnwJamX72S+alzGOhtQACt9kQ8S5e/4wxYQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbfIIKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:07:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56186 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390246AbfIIKH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=yTK2raRocXmY1SVYBroK1A3JaVMioGcvQYa4SdbdL8k=; b=S5snUQH5yVyC
        iub7lySHUfCpO7ZlHP7JorXwWyCPV/iJZESBtKcqjrReAjxZ7alvFMcF4d77OaARw3jxI7IIlZ/Bf
        uxnyrDY8BM+Awf0jmUCty/MX2yumrprbhF8xp2PhQjZO8AP9qZH6H2mzfyR2tt6LCDIylBacyNh75
        NlThQ=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7GZp-0001rj-KO; Mon, 09 Sep 2019 10:07:17 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 089F0D02D52; Mon,  9 Sep 2019 11:07:17 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        kernel-janitors@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: rt1011: make array pd static const, makes object smaller" to the asoc tree
In-Reply-To: <20190907073717.21632-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Message-Id: <20190909100717.089F0D02D52@fitzroy.sirena.org.uk>
Date:   Mon,  9 Sep 2019 11:07:17 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt1011: make array pd static const, makes object smaller

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

From 2b70d5776e8b173e3b36a2ef63d94428c6a80e1f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 7 Sep 2019 08:37:17 +0100
Subject: [PATCH] ASoC: rt1011: make array pd static const, makes object
 smaller

Don't populate the array pd on the stack but instead make it
static const. Makes the object code smaller by 100 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  51463	  13016	    128	  64607	   fc5f	sound/soc/codecs/rt1011.o

After:
   text	   data	    bss	    dec	    hex	filename
  51299	  13080	    128	  64507	   fbfb	sound/soc/codecs/rt1011.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190907073717.21632-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1011.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index fa34565a3938..a92a0bacd812 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1519,7 +1519,8 @@ static const struct snd_soc_dapm_route rt1011_dapm_routes[] = {
 
 static int rt1011_get_clk_info(int sclk, int rate)
 {
-	int i, pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
+	int i;
+	static const int pd[] = {1, 2, 3, 4, 6, 8, 12, 16};
 
 	if (sclk <= 0 || rate <= 0)
 		return -EINVAL;
-- 
2.20.1

