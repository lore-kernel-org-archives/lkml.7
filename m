Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901FDC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58049207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576016045;
	bh=W43+Kq7fQ3AQwYThuVDstsnTbomCr5vaVf+9hwKvyvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+ymFzpLRqSrFkqFuyQsST9Qbx8UcB6Fwm77ntSwmA2gxJAfNwHyoe0ZnNPdyb8yU
	 f3fkYr0gd2tjqwIO7a/bm/nW/15KyGs4TVFHaDaL3Rl4ZV4Dwl0aFVU92ldxxQKpTL
	 3xPelyMBHfANl7DMWN/ipP2IhmJV38uHHtRb+fZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfLJWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfLJWDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:03:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A90E2077B;
        Tue, 10 Dec 2019 22:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015385;
        bh=W43+Kq7fQ3AQwYThuVDstsnTbomCr5vaVf+9hwKvyvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jlw1t7zRDhJi7MenEi63ZeEmw/QGD8FTS5HibiBHs0AP3LktmSIQso20ak8Gc1gJ1
         47ELDSwszFouSU25VvutmPPhfa6EVBDHQ874Wq/e2RSYRl63j9tKu0c0wnfaIHTVlb
         7O3kmjl7cJl3hAqXprkeAxSmKFG3c0vXHQGuK9to=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 002/130] drm/bridge: analogix-anx78xx: silence -EPROBE_DEFER warnings
Date:   Tue, 10 Dec 2019 17:00:53 -0500
Message-Id: <20191210220301.13262-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit 2708e876272d89bbbff811d12834adbeef85f022 ]

Silence two warning messages that occur due to -EPROBE_DEFER errors to
help cleanup the system boot log.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190815004854.19860-4-masneyb@onstation.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix-anx78xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix-anx78xx.c
index 9385eb0b1ee40..cd2bfd7bf048e 100644
--- a/drivers/gpu/drm/bridge/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix-anx78xx.c
@@ -725,7 +725,9 @@ static int anx78xx_init_pdata(struct anx78xx *anx78xx)
 	/* 1.0V digital core power regulator  */
 	pdata->dvdd10 = devm_regulator_get(dev, "dvdd10");
 	if (IS_ERR(pdata->dvdd10)) {
-		DRM_ERROR("DVDD10 regulator not found\n");
+		if (PTR_ERR(pdata->dvdd10) != -EPROBE_DEFER)
+			DRM_ERROR("DVDD10 regulator not found\n");
+
 		return PTR_ERR(pdata->dvdd10);
 	}
 
@@ -1344,7 +1346,9 @@ static int anx78xx_i2c_probe(struct i2c_client *client,
 
 	err = anx78xx_init_pdata(anx78xx);
 	if (err) {
-		DRM_ERROR("Failed to initialize pdata: %d\n", err);
+		if (err != -EPROBE_DEFER)
+			DRM_ERROR("Failed to initialize pdata: %d\n", err);
+
 		return err;
 	}
 
-- 
2.20.1

