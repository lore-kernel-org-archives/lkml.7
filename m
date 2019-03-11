Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65243C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA1C2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bkGaZ4y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCKPgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:36:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59806 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:36:46 -0400
Received: from localhost.localdomain (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7BB99B8;
        Mon, 11 Mar 2019 16:36:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552318604;
        bh=jld2dr+xMjLXgYp1ZexxHsn0GeElgKdzqgi29mbBwwU=;
        h=From:To:Cc:Subject:Date:From;
        b=bkGaZ4y+h/HGxvSxMYyS4J7iqt/gIOWYRCLQOYJ3QDxgMz8+VruoaP+F3g7PLoBRt
         l2rqY7R5ZRl3rBYKhuhCzVLKyafB180s57sPLoKr52Xf2W/kQxia6NenPG6l1Vs2Ox
         p7V+SM14X2qm8qPeYExjaUU8tEFBP+DHdEHeAkwM=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] gpu: drm: atomic_helper: Fix spelling errors
Date:   Mon, 11 Mar 2019 15:36:39 +0000
Message-Id: <20190311153639.979-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fixes identified while working on the DRM code.

  s/artifically/artificially/
  s/achive/acheive/

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 540a77a2ade9..ccb278ed1bf8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1752,7 +1752,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 *
 	 * NOTE: Commit work has multiple phases, first hardware commit, then
 	 * cleanup. We want them to overlap, hence need system_unbound_wq to
-	 * make sure work items don't artifically stall on each another.
+	 * make sure work items don't artificially stall on each another.
 	 */
 
 	drm_atomic_state_get(state);
@@ -1786,7 +1786,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
  *
  * Asynchronous workers need to have sufficient parallelism to be able to run
  * different atomic commits on different CRTCs in parallel. The simplest way to
- * achive this is by running them on the &system_unbound_wq work queue. Note
+ * acheive this is by running them on the &system_unbound_wq work queue. Note
  * that drivers are not required to split up atomic commits and run an
  * individual commit in parallel - userspace is supposed to do that if it cares.
  * But it might be beneficial to do that for modesets, since those necessarily
-- 
2.19.1

