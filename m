Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C95C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA57D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfHOJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:18:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729668AbfHOJSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:18:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9A43D17C3A25E7092CA3;
        Thu, 15 Aug 2019 17:17:56 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:17:45 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <afd@ti.com>, <colin.king@canonical.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tlv320aic31xx: remove unused variable 'cm_m_enum'
Date:   Thu, 15 Aug 2019 17:17:38 +0800
Message-ID: <20190815091738.21680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound/soc/codecs/tlv320aic31xx.c:261:29: warning:
 cm_m_enum defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 26a4f6c..df627a0 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -258,7 +258,6 @@ static SOC_ENUM_SINGLE_DECL(mic1rp_p_enum, AIC31XX_MICPGAPI, 4,
 static SOC_ENUM_SINGLE_DECL(mic1lm_p_enum, AIC31XX_MICPGAPI, 2,
 	mic_select_text);
 
-static SOC_ENUM_SINGLE_DECL(cm_m_enum, AIC31XX_MICPGAMI, 6, mic_select_text);
 static SOC_ENUM_SINGLE_DECL(mic1lm_m_enum, AIC31XX_MICPGAMI, 4,
 	mic_select_text);
 
-- 
2.7.4


