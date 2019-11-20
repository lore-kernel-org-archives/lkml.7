Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC87BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90629219FA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256830;
	bh=WT9VmNTwrSOiMErau7Je4Gl0AyGjIGnI48+wBKl5j8M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IkcaJ0goCXsPzftDfJy4rygJ2FZxwT8J6TWlY4g8r9hh780K1k4ysmUyWgn8FhQK4
	 jM4ym7N9My8L9ZnOJ6VQGu9egPSio8y0VMXfQH+rEbRAh80hSdWV8TFkmHNL9eD/aE
	 mvNEo35yw9wsOHCrGkqtvv++qC0yi+hY2Ny6b8T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbfKTNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfKTNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:48 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D66219FA;
        Wed, 20 Nov 2019 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256827;
        bh=WT9VmNTwrSOiMErau7Je4Gl0AyGjIGnI48+wBKl5j8M=;
        h=From:To:Cc:Subject:Date:From;
        b=Oqr+fLUAYFAwTfgW96oVK4B3/FSTxPcXnRELQ9Sm2ZsFwHBRQipksvXxvPE27MSS6
         lW2rQcv1Q2yf1gQzfyvMJOi7W6kwJMCiZXGze/zeEcVwka+eqVZ3ACIANTLcATBmsW
         L8Vn6v+0kLn3asJLPYjNhEOwfTVenbGw4nyqUsYA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/udl: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:33:41 +0800
Message-Id: <20191120133341.6582-1-krzk@kernel.org>
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
 drivers/gpu/drm/udl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/Kconfig b/drivers/gpu/drm/udl/Kconfig
index b4d179b87f01..b13aa33990f3 100644
--- a/drivers/gpu/drm/udl/Kconfig
+++ b/drivers/gpu/drm/udl/Kconfig
@@ -8,4 +8,4 @@ config DRM_UDL
 	select DRM_KMS_HELPER
 	help
 	  This is a KMS driver for the USB displaylink video adapters.
-          Say M/Y to add support for these devices via drm/kms interfaces.
+	  Say M/Y to add support for these devices via drm/kms interfaces.
-- 
2.17.1

