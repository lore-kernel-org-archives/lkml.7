Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECF2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061BB224D2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256823;
	bh=cOotmQubac+hlg5XwFL6eDrG6qS2WHwDNCPh0I8Yv2M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BljLj+kw0PZd74VXJnF0PQIHgu6S5Vvxm9jfB9GsJXwUPl7v9pmvcdNyKMzCH7oi1
	 36d5fCof3ltiDid0pzbZFSGxFbLYZmnHlAh/N+W+A53B91gOShxK7n+8vlC+Pk2QiP
	 VdvIfCWtmtBH3ZGRiVG86/gb38Aye8uowsm5aUbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfKTNdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfKTNdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:41 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B55224D2;
        Wed, 20 Nov 2019 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256821;
        bh=cOotmQubac+hlg5XwFL6eDrG6qS2WHwDNCPh0I8Yv2M=;
        h=From:To:Cc:Subject:Date:From;
        b=Kwx0VXSwxVuOk9ra6cINVTrWcI4mfqI2arjb5skO8aXw2G6yns3U+1Cgu1Zn1ZnsN
         veAXE8DxpJZHdubMqxjbhMKFJASzLlfrCKo/iac67EXh2IIR9GQLYS3moyhtOWE0Ot
         +gVenIYPDbJ9gZWQhE5cu2Tv0/hfxbS/DRoCKTds=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] vga: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:33:27 +0800
Message-Id: <20191120133327.6519-1-krzk@kernel.org>
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
 drivers/gpu/vga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index c8c770b05ed9..1ad4c4ef0b5e 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -28,6 +28,6 @@ config VGA_SWITCHEROO
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
 	  to switch between them. This adds support for dynamic switching when
-          X isn't running and delayed switching until the next logoff. This
+	  X isn't running and delayed switching until the next logoff. This
 	  feature is called hybrid graphics, ATI PowerXpress, and Nvidia
 	  HybridPower.
-- 
2.17.1

