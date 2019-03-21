Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF08C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4915218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCUBn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:43:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5725 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbfCUBn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:43:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C09EFBBB4A8A93A6CDF4;
        Thu, 21 Mar 2019 09:43:26 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 09:43:17 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: wm_adsp: Make some variables static
Date:   Thu, 21 Mar 2019 09:43:14 +0800
Message-ID: <20190321014314.17960-1-yuehaibing@huawei.com>
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

Fix sparse warnings:

sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wm_adsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1..4ed587f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -306,9 +306,9 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
-struct wm_adsp_ops wm_adsp1_ops;
-struct wm_adsp_ops wm_adsp2_ops[];
-struct wm_adsp_ops wm_halo_ops;
+static struct wm_adsp_ops wm_adsp1_ops;
+static struct wm_adsp_ops wm_adsp2_ops[];
+static struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
-- 
2.7.0


