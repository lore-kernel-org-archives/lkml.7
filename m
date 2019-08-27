Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923C9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50299206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 06:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="odUrtGTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfH0Gpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 02:45:46 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:29798 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0Gpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 02:45:46 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7R6iVgg003740;
        Tue, 27 Aug 2019 15:44:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7R6iVgg003740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566888272;
        bh=vtbPJHn0Vac34GPikbOgs/qob9Pq0CHTDp4qvL1XFlo=;
        h=From:To:Cc:Subject:Date:From;
        b=odUrtGTgUKVvn/e47CAlTb7EfjZQ+pO+YtzeQ21jiuv7rQKSg4p5msQlk1IMNcPgU
         X7Z3YVtWNIAgTRZr3gGI+9Ye1UY0kd7yywz3nqNA9IOfNTzW9WggETCWdpHWK0KZiF
         N1utLwn2WDulFNNXxY8rppRAxm1zqNEpa04XTSo493hguwrHStzdldgd8V7O/SrJnM
         OsiqiCa/EtBRU4kDTbtLjmQ8BhX0nbKaLOVJ2LAwoArMxs915oGGg7nfjCV0ebUwYk
         71GQLQPbhyT0MOCfVzczq5qwcFeTsMsnbqRUArVyEAvHYgLaTOGjVcYEK679MmDL6h
         OUPGx+N4rR6HQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=8F=AB=D3nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: remove meaningless descending into amd/amdkfd/
Date:   Tue, 27 Aug 2019 15:44:25 +0900
Message-Id: <20190827064425.19627-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 04d5e2765802 ("drm/amdgpu: Merge amdkfd into amdgpu"),
drivers/gpu/drm/amd/amdkfd/Makefile does not contain any syntax that
is understood by the build system.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpu/drm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 9f0d2ee35794..3f9195b7ad13 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -62,7 +62,6 @@ obj-$(CONFIG_DRM_TTM)	+= ttm/
 obj-$(CONFIG_DRM_SCHED)	+= scheduler/
 obj-$(CONFIG_DRM_TDFX)	+= tdfx/
 obj-$(CONFIG_DRM_R128)	+= r128/
-obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
 obj-$(CONFIG_DRM_RADEON)+= radeon/
 obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
 obj-$(CONFIG_DRM_MGA)	+= mga/
-- 
2.17.1

