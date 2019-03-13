Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7713C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23C020693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="QqWAOh9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCMPf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:35:57 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54794 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfCMPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lucaceresoli.net; s=default; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9nzJwAzsaZtrTecFAOSfL3XxJBbXyYkPQHmqTaRTGU=; b=QqWAOh9W1PKPvTQnxjk6HBYDd
        W4w+sbJgaJ1IZ91xRxzGhYeNVhIEFK7K92jO0j+k2kY8p4IWi9FA4yMzjTzqiJ3OR+qEKDPcLEP7j
        s7lcezQge3ZxGM3GSL8fh6B7dO/k50P76Jw9frwOQIJMbg9aEU+ej2aRXYovBmqB5ewMM=;
Received: from [109.168.11.45] (port=48894 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1h45v6-007FSg-TR; Wed, 13 Mar 2019 16:35:53 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 2/2] drm/doc: fix missing verb
Date:   Wed, 13 Mar 2019 16:35:37 +0100
Message-Id: <20190313153537.22654-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190313153537.22654-1-luca@lucaceresoli.net>
References: <20190313153537.22654-1-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing "be". While there, also fix the syntax for
struct drm_device.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 include/drm/drm_drv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 570f9d03b2eb..ecbbcb281260 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -152,9 +152,9 @@ enum drm_driver_feature {
 /**
  * struct drm_driver - DRM driver structure
  *
- * This structure represent the common code for a family of cards. There will
- * one drm_device for each card present in this family. It contains lots of
- * vfunc entries, and a pile of those probably should be moved to more
+ * This structure represent the common code for a family of cards. There will be
+ * one &struct drm_device for each card present in this family. It contains lots
+ * of vfunc entries, and a pile of those probably should be moved to more
  * appropriate places like &drm_mode_config_funcs or into a new operations
  * structure for GEM drivers.
  */
-- 
2.17.1

