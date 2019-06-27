Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16184C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BF620815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561596312;
	bh=dwqc2rFbSqG/hi4drS0Ek1cR6Me27uLedH4ij06eCdU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qfVbotqqRLo1t94yTE2FR1Tfd2dYhsRd/vPpRZ+5nWd3G+tIMqh5+7reHNWlhS0pK
	 0GGgfRZauq8n4VDdIp9BsgCYtv+9qB3YnyhlP18e0EYbsBxawZ0Qz6Vl3HjbcmYPLx
	 gXJvRLAOCOGkqH3BfL/DpGeaDmcdKvBP5SzlA4kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbfF0Ald (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfF0Al3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:41:29 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 025A3205ED;
        Thu, 27 Jun 2019 00:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561596088;
        bh=dwqc2rFbSqG/hi4drS0Ek1cR6Me27uLedH4ij06eCdU=;
        h=From:To:Cc:Subject:Date:From;
        b=XR3MhGxm4QrrOKH1PDm4o+5ZQWX7E5/Mdg540gH01hXrsDzzkOE0ihyFs9ZjwWHHx
         Z7xWNyEXVzsFiMoyOX1q/R+yPI+zY5mmx5ZIDDmh3jiUdvANOd4bmXIfdviHN7ZB9J
         1+mTmf6rrvdfVEvdB7SLi6w85zPIHTKuPj7ozGRQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/21] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Wed, 26 Jun 2019 20:41:01 -0400
Message-Id: <20190627004122.21671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index 38edf8f5bf8a..15be3ee6cc50 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1187,6 +1187,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1

