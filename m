Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C28C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159C122529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257222;
	bh=wXg8C2p5ZI4K1Pp6ciyZlXd/EdYx1fcD1vR7WxWeDwE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wiexBNS27JxgKUjNGw3K5Q9qUD1LcSqCf1mh5t1MMadJehJDHmnaa5Kf5s+UqkWAq
	 fI3fKc9Q2bbimLHMfZdZJEUTXnRe75iwgxzRd3HO6hWDB3HwvUJBdguII2Wm+n722l
	 6TBXCmVi0+0dDn0RPqe5WUNh8cBYh4tQ5/tjLgSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfKTNkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbfKTNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:19 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8071D2251E;
        Wed, 20 Nov 2019 13:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257218;
        bh=wXg8C2p5ZI4K1Pp6ciyZlXd/EdYx1fcD1vR7WxWeDwE=;
        h=From:To:Cc:Subject:Date:From;
        b=y/qxOIgSvVxvD5nIYnb0lioI/bb9aztEYEPSVrT3G2R7DQgTxde6kdbNNBqTRR7TI
         x7tgMFVxPXKq08pZaa8+yhiaDlxFC2PcsROqa7ZrJtmek0chl0duueuZAoIUulBJgf
         W8NRQr1unM+9+Lnz3F/bdZhaeGC5HXVPG1XL9dyU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] platform/chrome: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:13 +0800
Message-Id: <20191120134014.14277-1-krzk@kernel.org>
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
 drivers/platform/chrome/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ee5f08ea57b6..b66cc7182287 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -132,9 +132,9 @@ config CROS_EC_LPC
 	  module will be called cros_ec_lpcs.
 
 config CROS_EC_PROTO
-        bool
-        help
-          ChromeOS EC communication protocol helpers.
+	bool
+	help
+	  ChromeOS EC communication protocol helpers.
 
 config CROS_KBD_LED_BACKLIGHT
 	tristate "Backlight LED support for Chrome OS keyboards"
-- 
2.17.1

