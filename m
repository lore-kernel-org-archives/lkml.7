Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96DEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3D6214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353623;
	bh=8SPFOrRoN/mrEuHoV96QktHoNh7jF4I73r9+t65ysAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiuvHJ+DlPYMNkVu42j7Nrpz6wCOcdBTt3ezh1W3N2iTVFGr0zOzPCZKEC0MrnlPi
	 LmldQSIVSd06vMh8+Fq+qElIvDUZ5FcYtnS1GzwfFG3UyDrVShToh5Fq5dmIifmAfQ
	 MoI9sfABqdcNwJAhap4a1UMq9ffF4vgi7Xrg/lHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfKJCkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfKJCkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAD4214E0;
        Sun, 10 Nov 2019 02:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353617;
        bh=8SPFOrRoN/mrEuHoV96QktHoNh7jF4I73r9+t65ysAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztXHEVJlPBwB7/JIeJANfxr+H39lG42mErRwa2pNa/TZ9Tz4aQjxqtCXGV1VyPrT2
         /Z0iQpS6SqwsUAkP2oRiV+xRwUIaUYltDKB3FDv+IsKCRL2FJh5sw0sILEwNr6S02U
         TFO0vXudeolXvUp7pluv573vmkO4qLV5Phz081ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 003/191] media: vsp1: Fix vsp1_regs.h license header
Date:   Sat,  9 Nov 2019 21:37:05 -0500
Message-Id: <20191110024013.29782-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[ Upstream commit 5eea860a6fec1e60709d19832015ee0991d3e80c ]

All source files of the vsp1 driver are licensed under the GPLv2+ except
for vsp1_regs.h which is licensed under GPLv2. This is caused by a bad
copy&paste that dates back from the initial version of the driver. Fix
it.

Acked-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Acked-by: Sergei Shtylyov<sergei.shtylyov@cogentembedded.com>
Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vsp1/vsp1_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vsp1/vsp1_regs.h b/drivers/media/platform/vsp1/vsp1_regs.h
index 3738ff2f7b850..f6e4157095cc0 100644
--- a/drivers/media/platform/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/vsp1/vsp1_regs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * vsp1_regs.h  --  R-Car VSP1 Registers Definitions
  *
-- 
2.20.1

