Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A431CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533EC2184C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904637;
	bh=NwcaHzqZ1lU4FzfoWU8IZZNT9FuebeODGEm+5dugqd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASmk2mLlwn4MJKNiiEyYeRm6zSlK+E5ZvzdnfJRdrbYgjUfD79w5YnXF79Q6zlf+Q
	 Ccur7PvTpygMjUDw3MhEFVl0cNK6UbRE8wiL76iG3YLXrTPYNxkZ95JJFPfiWnio9C
	 VKxZyZ6uamfPjQo2V360W4NzqlycVL5yUS/34tc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388557AbfKDV5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbfKDV5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:57:10 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963D0217F4;
        Mon,  4 Nov 2019 21:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904630;
        bh=NwcaHzqZ1lU4FzfoWU8IZZNT9FuebeODGEm+5dugqd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZ8cRv09M9//W8ASuaKn/GT5QOtAdp/t440iIWmWXUSBnyjNiJ/U46rEdEXvxsM75
         prqy8YaPIC33Kcf4Zdbj9VGnmTjzS8eMUOHleBHolJriFTxO25RAVAt3v+TIRWTK+L
         nPRJ2YuIcqLa2Z8wdJYaocVR9ZPQ91uU8iYgFOng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Aldridge <taldridge@mac.com>,
        Julian Sax <jsbc@gmx.de>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/149] HID: i2c-hid: add Direkt-Tek DTLAPY133-1 to descriptor override
Date:   Mon,  4 Nov 2019 22:43:28 +0100
Message-Id: <20191104212134.305946124@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Sax <jsbc@gmx.de>

[ Upstream commit 399474e4c1100bca264ed14fa3ad0d68fab484d8 ]

This device uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override list.

Reported-by: Tim Aldridge <taldridge@mac.com>
Signed-off-by: Julian Sax <jsbc@gmx.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index cac262a912c12..89f2976f9c534 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -330,6 +330,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Direkt-Tek DTLAPY133-1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Direkt-Tek"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "DTLAPY133-1"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Mediacom Flexbook Edge 11",
 		.matches = {
-- 
2.20.1



