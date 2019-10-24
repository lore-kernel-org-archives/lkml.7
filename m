Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186BBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE320650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503274AbfJXPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:31:35 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:37828 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503043AbfJXPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:31:35 -0400
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id HTXX210015USYZQ01TXXHk; Thu, 24 Oct 2019 17:31:33 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf5G-00078z-UO; Thu, 24 Oct 2019 17:31:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNf5G-000863-Ss; Thu, 24 Oct 2019 17:31:30 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Jiri Kosina <trivial@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ASoC: pxa: poodle: Spelling s/enpoints/endpoints/, s/connetion/connection/
Date:   Thu, 24 Oct 2019 17:31:30 +0200
Message-Id: <20191024153130.31082-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix misspelling of "endpoints" and "connection".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/pxa/poodle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 48d5c2252b10081d..59ef04d0467a622d 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -56,7 +56,7 @@ static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
-	/* set the enpoints to their new connetion states */
+	/* set the endpoints to their new connection states */
 	if (poodle_spk_func == POODLE_SPK_ON)
 		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 	else
-- 
2.17.1

