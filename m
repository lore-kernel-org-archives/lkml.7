Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F246AC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA212063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHOJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:13:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730073AbfHOJNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:13:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 347898C823010DF1A482;
        Thu, 15 Aug 2019 17:13:06 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:12:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <bardliao@realtek.com>, <oder_chiou@realtek.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: rt1011: remove unused variable 'dac_vol_tlv' and 'adc_vol_tlv'
Date:   Thu, 15 Aug 2019 17:06:02 +0800
Message-ID: <20190815090602.9000-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/rt1011.c:981:35: warning:
 dac_vol_tlv defined but not used [-Wunused-const-variable=]
sound/soc/codecs/rt1011.c:982:35: warning:
 adc_vol_tlv defined but not used [-Wunused-const-variable=]

They are never used, so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/rt1011.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 638abca..fa34565 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -978,9 +978,6 @@ static bool rt1011_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -9435, 37, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1739, 37, 0);
-
 static const char * const rt1011_din_source_select[] = {
 	"Left",
 	"Right",
-- 
2.7.4


