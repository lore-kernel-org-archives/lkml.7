Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F0C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBC221939
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256996;
	bh=JGl5YYm/lMtsmGe8bGMD0wTvi8CqLpAb2Eyq/ZOaayk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Htt4FnuQzyydSbhTMx8/0V7ONwgN7rpex9MFZnXrV+8jm/4rWBjcLoILKRrfM7znF
	 7YraiS8D1xx0e1JkTi0l9c2WkH0CsUsuUpaHXn+qint45G6zGvL20OBcfPtOT4xw1x
	 b01BC7TayCs6mrx7dRU3dHF9e3joJHE3yiVndvhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfKTNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTNge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:34 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3333E21939;
        Wed, 20 Nov 2019 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256994;
        bh=JGl5YYm/lMtsmGe8bGMD0wTvi8CqLpAb2Eyq/ZOaayk=;
        h=From:To:Cc:Subject:Date:From;
        b=Zj+HrwDYXdziBBH0eav9v3oBvD7Zu+6/zHAjp+wd/aBYrI6UiDaVnxsmDG4wpSqiq
         HDg6KhfVKT4BmtzgOyyiZBwCa37mgd1RF1oMsgb5OnMTmw8Y/1R6cDRW3bqB+9u067
         4M07JVZf5qxhPCzszHkARWM1uLyS3GrGX9XrIyhg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org
Subject: [PATCH] drm/lima: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:29 +0800
Message-Id: <20191120133629.11543-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/lima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/Kconfig b/drivers/gpu/drm/lima/Kconfig
index 571dc369a7e9..d589f09d04d9 100644
--- a/drivers/gpu/drm/lima/Kconfig
+++ b/drivers/gpu/drm/lima/Kconfig
@@ -11,4 +11,4 @@ config DRM_LIMA
        select DRM_SCHED
        select DRM_GEM_SHMEM_HELPER
        help
-         DRM driver for ARM Mali 400/450 GPUs.
+	 DRM driver for ARM Mali 400/450 GPUs.
-- 
2.17.1

