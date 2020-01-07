Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD3C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336A1206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgAGVtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:49:55 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgAGVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:49:55 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhDIw-1jK8o71gSg-00eM6j; Tue, 07 Jan 2020 22:48:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: gtm601: fix build warning
Date:   Tue,  7 Jan 2020 22:48:35 +0100
Message-Id: <20200107214846.1284981-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hgbuQXLAyzDG0JLdaoMrLoDWbahmQuVhsc4uo1Y42HSztF/U8X6
 ljgOSi6NbIyjXc8pJuuPyyWWjY072XKl1nZa7gRqaSj3b4pZgsBevH/oICmQTvNFF9RE+UY
 Yt/NlSvRPQ5SU/coEP7/isRi1nD3iTQ1/xutnEX1rWhdL8H9l3g4n8rxw3IdBgwzi/ZyyHL
 nU2NpbirZydu/iaPee/Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jDD5zrkTayQ=:EN/mtN5KHU2cVxtZeZDCMk
 xgZ8H2BYL/ixmxZ21NFKyG8bp3R+i/nAS3f2NjnUeasNXyDUXajUdENyH3nmi6yTtt3Dhvgre
 Poh/0wVsfsDZ4DK9V4TnRa6Z68admVkVOfm0g1ek52Tu0+bRvK7lcMxIYVEFf553fR0c23Bvs
 86Gt00GpxtUp/oE7SckjPvm/uMZixOwkfIF4ZpGkWuvAuxdOaEPpdgm1nZuoVeDCGiydd+KOZ
 5YfjJ1gm86kTl8lsA92siTw93yXTQ955iv8g0zqd7uw+bvH7aBsaKHD3zEs6sM3GnuWN3BAqL
 VRQbRvCmqm0ihoL8xVv3f/x4IeJOxSkt0ivi1akTjbnDTtvH/qQ6YlqGrgqMcmf5RD7jiIZ+l
 E7/fLjM1L/P6Gw3nbmsMw5MQ6TnjH/XX7pt8EgvrFcRS7uT7vXBolHHTcwTDt4SGCdl/JHw7e
 +oJ8ebXrMr+AP0RCNNANLnWpNuXAfMBnWXaumkfRKNRlpW72PdKAaPMoof/MxsdmSdCRuwQW2
 8a/ESpXM4Enx7dQqwGZ7qmrQAr7j9/RPaLKmlxhbqqxxvtevQWwpIjEZv2i+CIM+aBalhIFzv
 5VF69/WbcNqNGu/g0ANcsycf3hmgsb6p7KIqQHIQ95ifkcf7HWwbwf6Ej4iF/iqceGEVu370b
 yBEB/v9uLgQKHn2yMXUGpmltxwyQXGavNZqrNKey0t9cMhdqID8AGx+MYerkako8yxFKjyIUN
 OEn82awYzjE5t9T5Rd1L8qlkGeVaPelqx5rZGI8rQhCjeZz65uHTo0JXZHDIXTJ7s87lS3kIS
 FgidAOeuevJObQ50bHXv4L660UbaB6NlG1LAyBViHHO+b6q9gwVkwRvlgR+gGpsPxvqsgIW8l
 6RkABryq024BZXlNUo7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver produces warnings without CONFIG_OF, and makes
no sense without it either:

sound/soc/codecs/gtm601.c:50:34: error: 'bm818_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver bm818_dai = {
                                  ^~~~~~~~~
sound/soc/codecs/gtm601.c:32:34: error: 'gtm601_dai' defined but not used [-Werror=unused-variable]
 static struct snd_soc_dai_driver gtm601_dai = {
                                  ^~~~~~~~~~

Remove the #ifdef check to avoid the warning.

Fixes: 057a317a8d94 ("ASoC: gtm601: add Broadmobi bm818 sound profile")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/gtm601.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 7f05ebcb88d1..ae9e1c70ca57 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -87,14 +87,12 @@ static int gtm601_platform_probe(struct platform_device *pdev)
 			(struct snd_soc_dai_driver *)dai_driver, 1);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id gtm601_codec_of_match[] = {
 	{ .compatible = "option,gtm601", .data = (void *)&gtm601_dai },
 	{ .compatible = "broadmobi,bm818", .data = (void *)&bm818_dai },
 	{},
 };
 MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
-#endif
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-- 
2.20.0

