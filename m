Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C501C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEC220693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lucaceresoli.net header.i=@lucaceresoli.net header.b="h/rzoTk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCMPfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:35:54 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56553 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725870AbfCMPfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lucaceresoli.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9x0SdaQ/UR+3QVnWRcnw2G400A9yUOYAdhgvPFq06vk=; b=h/rzoTk95VkT4Vpqheg18ALaKL
        HSvLxoHmv+1j5a4SUxeeUvftyZ00mAaKrbgrKIyKvOr1Ngi3fXbJX1o03f3PYeviWWA/6s/x3tpmH
        EJ5F6cbCf3vjeix7/aiY4VP7P2OHRe+MfA2lkpzJ6BjN/QP2dNTumJ2q+ojDkxb3kvzw=;
Received: from [109.168.11.45] (port=48894 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1h45v3-007FSg-Pi; Wed, 13 Mar 2019 16:35:49 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH 1/2] drm/doc: fix kerneldoc syntax
Date:   Wed, 13 Mar 2019 16:35:36 +0100
Message-Id: <20190313153537.22654-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.17.1
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

The probe() reference renders incorrectly and without a link, fix it.

Also fix a typo reported by checkpatch in the context lines.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/gpu/drm/drm_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 381581b01d48..585f5d079046 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -264,13 +264,13 @@ void drm_minor_release(struct drm_minor *minor)
  * DOC: driver instance overview
  *
  * A device instance for a drm driver is represented by &struct drm_device. This
- * is initialized with drm_dev_init(), usually from bus-specific ->probe()
- * callbacks implemented by the driver. The driver then needs to initialize all
- * the various subsystems for the drm device like memory management, vblank
- * handling, modesetting support and intial output configuration plus obviously
- * initialize all the corresponding hardware bits. Finally when everything is up
- * and running and ready for userspace the device instance can be published
- * using drm_dev_register().
+ * is initialized with drm_dev_init(), usually from bus-specific
+ * &drm_driver.probe() callbacks implemented by the driver. The driver then
+ * needs to initialize all the various subsystems for the drm device like memory
+ * management, vblank handling, modesetting support and initial output
+ * configuration plus obviously initialize all the corresponding hardware
+ * bits. Finally when everything is up and running and ready for userspace the
+ * device instance can be published using drm_dev_register().
  *
  * There is also deprecated support for initalizing device instances using
  * bus-specific helpers and the &drm_driver.load callback. But due to
-- 
2.17.1

