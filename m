Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECEC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2DF20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGQG6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:58:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfGQG6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:58:15 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 878B3B2BD220132AE72E;
        Wed, 17 Jul 2019 14:57:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 14:57:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dri-devel@lists.freedesktop.org>, <bskeggs@redhat.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/nouveau/secboot: Make acr_r352_ls_gpccs_func static
Date:   Wed, 17 Jul 2019 14:56:26 +0800
Message-ID: <20190717065626.42016-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c:1092:1:
 warning: symbol 'acr_r352_ls_gpccs_func' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
index 4fd4cfe..7af971d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
@@ -1088,7 +1088,7 @@ acr_r352_ls_gpccs_func_0 = {
 	.lhdr_flags = LSF_FLAG_FORCE_PRIV_LOAD,
 };
 
-const struct acr_r352_ls_func
+static const struct acr_r352_ls_func
 acr_r352_ls_gpccs_func = {
 	.load = acr_ls_ucode_load_gpccs,
 	.version_max = 0,
-- 
2.7.4


