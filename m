Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617FAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEA0218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfHOJCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:02:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730213AbfHOJCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:02:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 538DF26465B66BEFD894;
        Thu, 15 Aug 2019 17:02:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:02:02 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <brian.austin@cirrus.com>, <Paul.Handrigan@cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: cs4349: Use PM ops 'cs4349_runtime_pm'
Date:   Thu, 15 Aug 2019 17:01:57 +0800
Message-ID: <20190815090157.70036-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/cs4349.c:358:32: warning:
 cs4349_runtime_pm defined but not used [-Wunused-const-variable=]

cs4349_runtime_pm ops already defined, it seems
we should enable it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e40da86 ("ASoC: cs4349: Add support for Cirrus Logic CS4349")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/cs4349.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 09716fa..e0d44f6 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -378,6 +378,7 @@ static struct i2c_driver cs4349_i2c_driver = {
 	.driver = {
 		.name		= "cs4349",
 		.of_match_table	= cs4349_of_match,
+		.pm = &cs4349_runtime_pm,
 	},
 	.id_table	= cs4349_i2c_id,
 	.probe		= cs4349_i2c_probe,
-- 
2.7.4


