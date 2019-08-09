Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE26DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA592166E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405874AbfHII1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:27:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405395AbfHII1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:27:07 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1A4159A14057AC15E2D3;
        Fri,  9 Aug 2019 16:26:56 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 9 Aug 2019
 16:26:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <gregkh@linuxfoundation.org>,
        <rfontana@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: ml26124: remove unused variable 'ngth'
Date:   Fri, 9 Aug 2019 16:24:40 +0800
Message-ID: <20190809082440.67412-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file included from ./include/sound/tlv.h:10:0,
                 from sound/soc/codecs/ml26124.c:19:
sound/soc/codecs/ml26124.c:59:35: warning: ngth defined but not used [-Wunused-const-variable=]
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
                                   ^
./include/uapi/sound/tlv.h:64:15: note: in definition of macro SNDRV_CTL_TLVD_DECLARE_DB_SCALE
  unsigned int name[] = { \
               ^~~~
sound/soc/codecs/ml26124.c:59:14: note: in expansion of macro DECLARE_TLV_DB_SCALE
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
              ^~~~~~~~~~~~~~~~~~~~

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/ml26124.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 3abd278..55823bc 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -56,7 +56,6 @@ static const DECLARE_TLV_DB_SCALE(alclvl, -2250, 150, 0);
 static const DECLARE_TLV_DB_SCALE(mingain, -1200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(maxgain, -675, 600, 0);
 static const DECLARE_TLV_DB_SCALE(boost_vol, -1200, 75, 0);
-static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
 
 static const char * const ml26124_companding[] = {"16bit PCM", "u-law",
 						  "A-law"};
-- 
2.7.4


