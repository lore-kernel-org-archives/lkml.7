Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8E4C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469A6214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013551;
	bh=kk3/+6go7qsIY4UkBEPYHWNWVbXKrCIUUdRKgsr68gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BE9KW1Cc05nTkoywjLaJpmY1Fo64VgvUhbI6/Ommyjqcsq9Wo8lNNpLc/8m9BhD+h
	 xFrEZdsJjOl52cuMiSP79BxF53TrIQzxiY/IN2aRCtsWrev8NHhxyWPNMgnSV/aHZ9
	 OBJw5Yl0Op02+X/HVVF+hzoz2r8radF3wCqnfolQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfLJVc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbfLJVcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:32:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F16F2073B;
        Tue, 10 Dec 2019 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013545;
        bh=kk3/+6go7qsIY4UkBEPYHWNWVbXKrCIUUdRKgsr68gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpgpHsWHXOHdKXLbZklQ/tfMhQzM1g1Piufgi3f9ppNxT9J7CKqzWttw377lR7OeX
         UAyVMAlnsZWcumRtKy0stdaWBQXVTjWacXpE2ABfd6rLJbcaNA6vKqFLMXZq8Nv22T
         GHiHLzTNo7FL/OPiqFbaku2tJyAra8oouIXdnBzM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 002/177] drm/panel: Add missing drm_panel_init() in panel drivers
Date:   Tue, 10 Dec 2019 16:29:26 -0500
Message-Id: <20191210213221.11921-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 65abbda8ed7ca48c8807d6b04a77431b438fa659 ]

Panels must be initialised with drm_panel_init(). Add the missing
function call in the panel-raspberrypi-touchscreen.c and
panel-sitronix-st7789v.c drivers.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190823193245.23876-2-laurent.pinchart@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 1 +
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 9a2cb8aeab3a4..aab6a70ece7f0 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -427,6 +427,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 		return PTR_ERR(ts->dsi);
 	}
 
+	drm_panel_init(&ts->base);
 	ts->base.dev = dev;
 	ts->base.funcs = &rpi_touchscreen_funcs;
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 74284e5afc5d9..89fa17877b336 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -380,6 +380,7 @@ static int st7789v_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
+	drm_panel_init(&ctx->panel);
 	ctx->panel.dev = &spi->dev;
 	ctx->panel.funcs = &st7789v_drm_funcs;
 
-- 
2.20.1

