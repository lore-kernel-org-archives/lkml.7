Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36235C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04571218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ClapT+5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfCNWEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:04:34 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58566 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfCNWEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:04:30 -0400
Received: from Q.home (cpc85428-aztw29-2-0-cust223.18-1.cable.virginm.net [82.38.144.224])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BAF29FD;
        Thu, 14 Mar 2019 23:04:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552601067;
        bh=1YhszjynjaScoGN/8bvmo4He1JeRXZTySkFPMs9frk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClapT+5VGTFVc0szsit+mKjXDiZG3pllxGyACWXms5Rvq9n2thWKb5eP3oWgaCXfK
         GEsPbSuQ7Z26RLLT1bYD36zdQ5MEdJgJmFIGGBqpxRJU3TRAVpSGQq2T9vixTzQ3W1
         wJ406C3GmCgg9SqMzWlfH1d3whl8pag8VFcq45rY=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc:     linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 3/3] drm: rcar-du: Remove unused prototypes
Date:   Thu, 14 Mar 2019 22:04:20 +0000
Message-Id: <20190314220420.32487-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CRTC suspend and resume functions have been replaced, but the
prototypes were not removed.

Remove the redundant definitions.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index bcb35b0b7612..3f339a7e8d14 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -97,8 +97,6 @@ enum rcar_du_output {
 
 int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int swindex,
 			unsigned int hwindex);
-void rcar_du_crtc_suspend(struct rcar_du_crtc *rcrtc);
-void rcar_du_crtc_resume(struct rcar_du_crtc *rcrtc);
 
 void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc);
 
-- 
2.19.1

