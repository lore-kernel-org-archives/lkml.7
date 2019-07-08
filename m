Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDEFC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41975216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599952;
	bh=giKj7LJP8BeuzzTWOzIa04NyVesFVntNI7FmqeVU9dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mv268v3sv7sgTNMtZdNoSRat9coSD+WNLRbN9Qu0+H7HcGTNzuN9prkMSAuHpqvQj
	 Ls0ub27iQ9amWUFbVSFM6VpgjGUZhtKnd2Z7kkmjSWJBHB82zEaclpAAzTc0QAWrZP
	 yCPCMIxDue6ohyBEW6szAJaivKy4TMMJW7Um+oHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390148AbfGHPcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390126AbfGHPcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:32:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C72E204EC;
        Mon,  8 Jul 2019 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599945;
        bh=giKj7LJP8BeuzzTWOzIa04NyVesFVntNI7FmqeVU9dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3yP7zAcLJ775JcvD1za8/EFo0/AY+gxnwo7ksGZjDRYKWmdAbXjt8K71l1A5pmkj
         VgP5E04bF/CIiPxEEne4Aavt2ts8V7Hje+6qQleXFKXs/objbaMarM/NRvn4t1LkRr
         W0mvYUr8N1yjtpQPRXrBtZl5poPXFddnG8gUKOLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jurgen Kramer <gtmkramer@xs4all.nl>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 40/96] drm: panel-orientation-quirks: Add quirk for GPD pocket2
Date:   Mon,  8 Jul 2019 17:13:12 +0200
Message-Id: <20190708150528.725593315@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



