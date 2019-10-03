Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2854AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B3B2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120436;
	bh=c/3eVmy+tc8mTD9hs64Cm6vfp43ZcUUAsBwfB3rTaF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zo9NZX+vHpMgFpbsqNa8d0vyatGPlGtaNE4XrarFKbVcG5rimlJnjOLBGe+Wx4nwv
	 J6kc9ZYiZP+5ePyClRhE6FVM75bBL+eLsPfXynp5iFR9Wq3sNPHS3l9m+nRcQDu9Cx
	 G458vsIbtpg/vPe4h4/KHFbr8VQZ2hYpPfdPfnRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392068AbfJCQdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392057AbfJCQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:33:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DC212070B;
        Thu,  3 Oct 2019 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120430;
        bh=c/3eVmy+tc8mTD9hs64Cm6vfp43ZcUUAsBwfB3rTaF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrFge/VWDnQR6ohfZcDi6zRxjj/cXhvpevGAdV+HvNgW2sgXv/XbtOYXF65bm80wc
         uLopZebsjlxyFUqk0ow4InD/aHkjjMcQbFI21w8NLoUmnfP/iLqwUttOtbZtKA0H5Q
         kxK8Wcxt8i6TcoieP24LNgqzSlDuP0n5M65p2+SQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?G=C3=B6ran=20Uddeborg?= <goeran@uddeborg.se>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 202/313] drm: fix module name in edid_firmware log message
Date:   Thu,  3 Oct 2019 17:53:00 +0200
Message-Id: <20191003154552.869414766@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit ade925995b172f1d7410d1c665b2f47c5e99bef0 ]

The module is drm_kms_helper, not drm_kms_firmware.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204549
Reported-by: Göran Uddeborg <goeran@uddeborg.se>
Fixes: ac6c35a4d8c7 ("drm: add backwards compatibility support for drm_kms_helper.edid_firmware")
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190821094312.5514-1-jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 9c5ae825c5078..69917ecd4af67 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL and additional rights");
 /* Backward compatibility for drm_kms_helper.edid_firmware */
 static int edid_firmware_set(const char *val, const struct kernel_param *kp)
 {
-	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
+	DRM_NOTE("drm_kms_helper.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
 
 	return __drm_set_edid_firmware_path(val);
 }
-- 
2.20.1



