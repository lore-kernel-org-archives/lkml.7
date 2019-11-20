Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE653C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A292E224EB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256988;
	bh=6BvqkSk8AIwBhUKqtp6RBtg7rVitYauvILovxIcQx8s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rXR1nVQASNJqZKDUN+Mtwd/Fe11G2oi5L2zh+4kX6f+BUHLEmWFzUlBt1rU866fz+
	 iSY01LOZpjufm9TxVaTwjeqjNcseKuCBrjtDrUJaXHLaIIxDQLoaLi6RArPGCtoFkp
	 dVV/itLbesfhEuG5lZcy0iluXpJsszXm9dC+EBIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfKTNg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:36:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728030AbfKTNgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:36:24 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2249F21939;
        Wed, 20 Nov 2019 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256983;
        bh=6BvqkSk8AIwBhUKqtp6RBtg7rVitYauvILovxIcQx8s=;
        h=From:To:Cc:Subject:Date:From;
        b=J+gKNBmppFpbzaC+DLXN2imnQ+Ix9vzshMFKKzSe67vJOqQ/+gO08NYC1qKJmwVHL
         WeqhAvh22Hh64EAiEfSU94lqEH3XB6QHNVRBa0qkn6f32SxElT5XUhBG/+809q3At6
         IfGHsNeXZbNT6/dQY0BpWsgWVLg3mRCmz/39XzwM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm/nouveau: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:36:19 +0800
Message-Id: <20191120133619.11415-1-krzk@kernel.org>
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
 drivers/gpu/drm/nouveau/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3558df043592..9c990266e876 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -2,7 +2,7 @@
 config DRM_NOUVEAU
 	tristate "Nouveau (NVIDIA) cards"
 	depends on DRM && PCI && MMU
-        select FW_LOADER
+	select FW_LOADER
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
-- 
2.17.1

