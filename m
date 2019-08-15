Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04496C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50C3218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbfHOJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:04:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728128AbfHOJEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:04:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FC2FA3A80B3E932258D;
        Thu, 15 Aug 2019 17:04:30 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:04:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <info@metux.net>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: max98371: remove unused variable 'max98371_noload_gain_tlv'
Date:   Thu, 15 Aug 2019 17:04:04 +0800
Message-ID: <20190815090404.72752-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/max98371.c:157:35: warning:
 max98371_noload_gain_tlv defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/max98371.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index ce80148..dfee05f 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -154,10 +154,6 @@ static const DECLARE_TLV_DB_RANGE(max98371_gain_tlv,
 	8, 10, TLV_DB_SCALE_ITEM(400, 100, 0)
 );
 
-static const DECLARE_TLV_DB_RANGE(max98371_noload_gain_tlv,
-	0, 11, TLV_DB_SCALE_ITEM(950, 100, 0),
-);
-
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -6300, 50, 1);
 
 static const struct snd_kcontrol_new max98371_snd_controls[] = {
-- 
2.7.4


