Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99564C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793DF20651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfHEMnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:43:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728822AbfHEMnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:43:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 887BD3C937;
        Mon,  5 Aug 2019 12:43:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-81.ams2.redhat.com [10.36.116.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29376194BE;
        Mon,  5 Aug 2019 12:43:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 88D7E9D42; Mon,  5 Aug 2019 14:43:13 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     intel-gfx@lists.freedesktop.org, thomas@shipmail.org,
        tzimmermann@suse.de, ckoenig.leichtzumerken@gmail.com,
        bskeggs@redhat.com, daniel@ffwll.ch,
        Gerd Hoffmann <kraxel@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 11/18] [fixup] ttm
Date:   Mon,  5 Aug 2019 14:43:03 +0200
Message-Id: <20190805124310.3275-12-kraxel@redhat.com>
In-Reply-To: <20190805124310.3275-1-kraxel@redhat.com>
References: <20190805124310.3275-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 05 Aug 2019 12:43:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index b3d628b3f038..73d407494586 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -961,7 +961,7 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
 	struct ww_acquire_ctx *ticket;
 	int ret;
 
-	ticket = reservation_object_locking_ctx(bo->resv);
+	ticket = reservation_object_locking_ctx(bo->base.resv);
 	do {
 		ret = (*man->func->get_node)(man, bo, place, mem);
 		if (unlikely(ret != 0))
-- 
2.18.1

