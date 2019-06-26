Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6BAC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E899121655
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520588;
	bh=DAH6MgEyx7njo0iZ7bmJhEsqVy8xFE4LtQ6zVjlE2Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Je7UNXOxa1kI4dx3TYcFYa23xZwMqe6NR9ZQ6loEuxM5zSkR+BCLXj8hMXqn3LrVP
	 G8P+tJwEqmtsLWU6VWnufxG3/qG+D/po6qE2ILikGZobWDRMTOXtKNr8K9hXZiBjqe
	 s5IgUnf1PSGOTftM7AjjnUWvzBS8LHWWSocs1yVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfFZDnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfFZDnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:43:00 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-74.mobile.att.net [107.77.172.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D77208CB;
        Wed, 26 Jun 2019 03:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520579;
        bh=DAH6MgEyx7njo0iZ7bmJhEsqVy8xFE4LtQ6zVjlE2Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn+cjEmYSjXQsfvdSEqVv/dz2aprjPLjOZ+tGvD0QzpGm/jfCWdcegyQ/ZTcG5ynZ
         Vo9kT6IflIL8isyO927yM/a9EijkXR3ag37AqDwiMchT1a5GwWqaCdC0xOK1gvrHI3
         JjVQoC3glPJR9dQAW8yaMnOfdsl5/p/p45OT53s8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jurgen Kramer <gtmkramer@xs4all.nl>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 36/51] drm: panel-orientation-quirks: Add quirk for GPD pocket2
Date:   Tue, 25 Jun 2019 23:40:52 -0400
Message-Id: <20190626034117.23247-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034117.23247-1-sashal@kernel.org>
References: <20190626034117.23247-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 15abc7110a77555d3bf72aaef46d1557db0a4ac5 ]

GPD has done it again, make a nice device (good), use way too generic
DMI strings (bad) and use a portrait screen rotated 90 degrees (ugly).

Because of the too generic DMI strings this entry is also doing bios-date
matching, so the gpd_pocket2 data struct may very well need to be updated
with some extra bios-dates in the future.

Changes in v2:
-Add one more known BIOS date to the list of BIOS dates

Cc: Jurgen Kramer <gtmkramer@xs4all.nl>
Reported-by: Jurgen Kramer <gtmkramer@xs4all.nl>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190524125759.14131-1-hdegoede@redhat.com
(cherry picked from commit 6dab9102dd7b144e5723915438e0d6c473018cd0)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 52e445bb1aa5..019f148d5a78 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -50,6 +50,14 @@ static const struct drm_dmi_panel_orientation_data gpd_pocket = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data gpd_pocket2 = {
+	.width = 1200,
+	.height = 1920,
+	.bios_dates = (const char * const []){ "06/28/2018", "08/28/2018",
+		"12/07/2018", NULL },
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data gpd_win = {
 	.width = 720,
 	.height = 1280,
@@ -106,6 +114,14 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
 		},
 		.driver_data = (void *)&gpd_pocket,
+	}, {	/* GPD Pocket 2 (generic strings, also match on bios date) */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
+		},
+		.driver_data = (void *)&gpd_pocket2,
 	}, {	/* GPD Win (same note on DMI match as GPD Pocket) */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
-- 
2.20.1

