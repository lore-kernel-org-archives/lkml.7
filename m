Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CA3C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E378206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469112;
	bh=X+Ebr00IaI3qLwvQu4pO4xc+Xvp9x6957Zo4dXEN+6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2yzcTYiYMVGq8g4sp2hLj4zxNMAqxVPjiHzgfzSz2jcBakYX1B3vPpFFOuKfdqcJ
	 u/yEQ6rlj/X7eBH4mT06LgeVcuwI6MlyCFe1eJRMYQ8YEbI0RObNODKD6xyFarYo5N
	 r9qHpYKh4M9VnFUXy1SjzdZH8lSV3mIw6oboJgdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfL0Rvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:51:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfL0RnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9008522522;
        Fri, 27 Dec 2019 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468598;
        bh=X+Ebr00IaI3qLwvQu4pO4xc+Xvp9x6957Zo4dXEN+6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsM0DEbfCoikwaL2w0H7Ykb7V8dcuS0ItT2cHry2KV44vLBiP/EfgEk2GllXVpmVX
         hYTHWskdlvc3AifftCLmgNSjYDwlaUwVGpe219LOuipR/YN7HV1So/fnh32ifiJpp8
         7ytsGFTY5cCkjwPTQvUN6wTMm9jtjI4D9yNoHezQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 119/187] net: usb: lan78xx: Fix error message format specifier
Date:   Fri, 27 Dec 2019 12:39:47 -0500
Message-Id: <20191227174055.4923-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

[ Upstream commit 858ce8ca62ea1530f2779d0e3f934b0176e663c3 ]

Display the return code as decimal integer.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 0becc79fd431..e3cdfdde2265 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -511,7 +511,7 @@ static int lan78xx_read_stats(struct lan78xx_net *dev,
 		}
 	} else {
 		netdev_warn(dev->net,
-			    "Failed to read stat ret = 0x%x", ret);
+			    "Failed to read stat ret = %d", ret);
 	}
 
 	kfree(stats);
-- 
2.20.1

