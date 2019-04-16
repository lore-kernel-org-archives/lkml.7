Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36872C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA62064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfDPOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:54:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbfDPOyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:54:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3704CAA86E2588E8109D;
        Tue, 16 Apr 2019 22:54:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Tue, 16 Apr 2019
 22:54:38 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <maruthi.bayyavarapu@amd.com>, <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: amd: acp3x: Make acp3x_dai_i2s_ops static
Date:   Tue, 16 Apr 2019 22:52:51 +0800
Message-ID: <20190416145251.16800-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

sound/soc/amd/raven/acp3x-pcm-dma.c:561:24: warning:
 symbol 'acp3x_dai_i2s_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 1a2e15f..9775bda 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -558,7 +558,7 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
+static struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
 	.set_fmt = acp3x_dai_i2s_set_fmt,
-- 
2.7.4


