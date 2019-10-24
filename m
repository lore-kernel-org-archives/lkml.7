Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0127420679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439670AbfJXMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:19:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfJXMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:19:21 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F20CA354FB6E68393ECA;
        Thu, 24 Oct 2019 20:19:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 24 Oct 2019 20:19:07 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <bardliao@realtek.com>, <oder_chiou@realtek.com>,
        <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
Date:   Thu, 24 Oct 2019 20:15:19 +0800
Message-ID: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC complains the following warning.

sound/soc/codecs/rt5677-spi.c:365:13: warning: symbol 'rt5677_spi_pcm_page' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/codecs/rt5677-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index 36c02d2..b412371 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -362,7 +362,7 @@ static void rt5677_spi_copy_work(struct work_struct *work)
 	mutex_unlock(&rt5677_dsp->dma_lock);
 }
 
-struct page *rt5677_spi_pcm_page(
+static struct page *rt5677_spi_pcm_page(
 		struct snd_soc_component *component,
 		struct snd_pcm_substream *substream,
 		unsigned long offset)
-- 
1.7.12.4

