Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D340C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SbV3yu7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfCNWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:04:31 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58538 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCNWE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:04:28 -0400
Received: from Q.home (cpc85428-aztw29-2-0-cust223.18-1.cable.virginm.net [82.38.144.224])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDC6C333;
        Thu, 14 Mar 2019 23:04:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552601066;
        bh=sl0rIIsXyJRyN8uSFZ4YSUYZ6c5qUdWFyQ6c7AeZSyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbV3yu7UCwdJPalVkfqYBmSxhpy4PaLMF+Vcg+IH6gYH9u47M+hlADkqfSHnZs5jX
         VQku1mlbMJxJoOwTsq3lrgkRlnIbNeJa1FcTCyS6dTaaPnMywL9RIBrwvn1kFlrEK/
         LS6/HmhvCdGtJa4lxc5drxeCArgaSoQoiCb+nDkM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/3] drm: fix subtle spelling error in drm_crtc_state
Date:   Thu, 14 Mar 2019 22:04:18 +0000
Message-Id: <20190314220420.32487-2-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_crtc_state documentation contains a subtle misspelling of the
word subtle. Correct it.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 include/drm/drm_crtc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 85abd3fe9e83..f2b3762636df 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -78,7 +78,7 @@ struct drm_plane_helper_funcs;
 /**
  * struct drm_crtc_state - mutable CRTC state
  *
- * Note that the distinction between @enable and @active is rather subtile:
+ * Note that the distinction between @enable and @active is rather subtle:
  * Flipping @active while @enable is set without changing anything else may
  * never return in a failure from the &drm_mode_config_funcs.atomic_check
  * callback. Userspace assumes that a DPMS On will always succeed. In other
-- 
2.19.1

