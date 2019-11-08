Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6F1FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813C120656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215257;
	bh=OVrIbVCAkUxIXhK+atxs9e/hAi56a9ksTK9A2USy0Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDdoRTnlZTy1/MEsg6IdqjGMNIOX7f1qpdFEvgBIlDhw+l6PQs4H/aQI3MT2wclZ3
	 U2GdydYoiet0nt5kgM+499jAfCXfJenwevrB/1fiWP88eIMlJ8ppmlq+/S+Jusm1lX
	 tepTX6kZ4vRgWuFiUM9AksOawq0keP+2lShl3RIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391008AbfKHMOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731980AbfKHLiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACC021D7F;
        Fri,  8 Nov 2019 11:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213093;
        bh=OVrIbVCAkUxIXhK+atxs9e/hAi56a9ksTK9A2USy0Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sALhzTJQ1hqYKvxLEoacg5QWDtM0M5sMYau2AiyzEJBwJ7LhTPg4LXFhQoNG8x+1s
         2bfI5pv0FkYMrnqw8uO6B/965+kHf2P8OGydfXiZ/P8XiI2BfcZyqqAVMmE7DmSK/c
         YGXUjoroY9KDuhuYptEn3Mb8z3XXFS8C81e7PlNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, rtc-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 018/205] rtc: rv8803: fix the rv8803 id in the OF table
Date:   Fri,  8 Nov 2019 06:34:45 -0500
Message-Id: <20191108113752.12502-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit c856618d20662695fcdb47bf4d560dc457662aec ]

The ID for RV8803 must be rv_8803

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rv8803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 29fc3d2103923..17ccef5d5db1a 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -623,7 +623,7 @@ MODULE_DEVICE_TABLE(i2c, rv8803_id);
 static const struct of_device_id rv8803_of_match[] = {
 	{
 		.compatible = "microcrystal,rv8803",
-		.data = (void *)rx_8900
+		.data = (void *)rv_8803
 	},
 	{
 		.compatible = "epson,rx8900",
-- 
2.20.1

