Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E23C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07864206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbfG3PBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:01:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730274AbfG3PBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:01:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5BCF0B6BBD93E861E398;
        Tue, 30 Jul 2019 23:01:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 23:01:32 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <seanpaul@chromium.org>, <heiko@sntech.de>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/rockchip: Make analogix_dp_atomic_check static
Date:   Tue, 30 Jul 2019 23:00:57 +0800
Message-ID: <20190730150057.57388-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1151:5: warning:
 symbol 'analogix_dp_atomic_check' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index c82c7d5..f2f7f69 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1148,8 +1148,8 @@ analogix_dp_best_encoder(struct drm_connector *connector)
 }
 
 
-int analogix_dp_atomic_check(struct drm_connector *connector,
-			     struct drm_atomic_state *state)
+static int analogix_dp_atomic_check(struct drm_connector *connector,
+				    struct drm_atomic_state *state)
 {
 	struct analogix_dp_device *dp = to_dp(connector);
 	struct drm_connector_state *conn_state;
-- 
2.7.4


