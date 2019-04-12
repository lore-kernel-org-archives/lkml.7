Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E95C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714F22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfDLM7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:59:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34488 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:58:59 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:431:9718:a5e8:c168:522a:50d5:d06d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4F42A2811A6;
        Fri, 12 Apr 2019 13:58:53 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>
Cc:     dnicoara@chromium.org, daniels@collabora.com,
        alexandros.frantzis@collabora.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, tomasz Figa <tfiga@chromium.org>,
        tina.zhang@intel.com, boris.brezillon@collabora.com,
        Sean Paul <seanpaul@google.com>, kernel@collabora.com,
        nicholas.kazlauskas@amd.com,
        =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@google.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Helen Koike <helen.koike@collabora.com>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 1/4] drm/uapi: add documentation for atomic flags
Date:   Fri, 12 Apr 2019 09:58:24 -0300
Message-Id: <20190412125827.5877-2-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412125827.5877-1-helen.koike@collabora.com>
References: <20190412125827.5877-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a brief description of the flags used in an atomic commit

Signed-off-by: Helen Koike <helen.koike@collabora.com>
---

Changes in v3: None
Changes in v2: None
Changes in v1: None

 include/uapi/drm/drm_mode.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 83cd1636b9be..88ef2cf04d13 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -729,7 +729,23 @@ struct drm_mode_destroy_dumb {
 	__u32 handle;
 };
 
-/* page-flip flags are valid, plus: */
+/*
+ * drm atomic flags
+ *
+ * page-flip flags are valid, plus:
+ *
+ * DRM_MODE_ATOMIC_TEST_ONLY
+ * Used with fences to check if the Sync File is a valid one.
+ *
+ * DRM_MODE_ATOMIC_NONBLOCK
+ * Perform a normal atomic update but do not block the ioctl until the request
+ * is finished, return the ioctl call immediately.
+ *
+ * DRM_MODE_ATOMIC_ALLOW_MODESET
+ * Indicates whether a full modeset is acceptable or not.
+ */
+
+/*  */
 #define DRM_MODE_ATOMIC_TEST_ONLY 0x0100
 #define DRM_MODE_ATOMIC_NONBLOCK  0x0200
 #define DRM_MODE_ATOMIC_ALLOW_MODESET 0x0400
-- 
2.20.1

