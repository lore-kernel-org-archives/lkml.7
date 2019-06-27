Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7AC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061092083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595450;
	bh=7V5na6UfXsHgJvEjOZenDcc6WbH5UP81mtW/nASoa1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08L+mZPa/irEpts4VkH/uxXRZxHHTdAdFDNHokQxa8ugoaqZNl9HDPpTA6ACvZF+M
	 C9MyFTTjTnTS2dYqoup7n6G5mW6O/V6jEnxfzOWRjNdvSmsqeAdB6Eq7IZhHIj0lCl
	 xf5tPrfN7OCnZshC2j7MTgklyusE6tQ0BwBqGIw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfF0Aas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:30:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbfF0Aar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:30:47 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246522083B;
        Thu, 27 Jun 2019 00:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595446;
        bh=7V5na6UfXsHgJvEjOZenDcc6WbH5UP81mtW/nASoa1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unNBlSFcKge9rHzBHF/CAhett/weWCjFHKwcV/njNgKQHzPQxrxpVsYFTQAMPpm9j
         lPaTGDhlYq+xX6AoGGUmputAjeduS42IDVfUfQo9b+T5PuhHlRshYZCUOQYUpvSWeR
         evieRdcqyfDCuspmFXXY0npoUEpsrsnzwLv7Y+jw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 07/95] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Wed, 26 Jun 2019 20:28:52 -0400
Message-Id: <20190627003021.19867-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

[ Upstream commit aa440de3058a3ef530851f9ef373fbb5f694dbc3 ]

Adding 2 new touchpad PNPIDs to enable middle button support.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a7f8b1614559..530142b5a115 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1

