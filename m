Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354E4C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C022071B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142321;
	bh=bQI38G0uBLoRUHG1bRD67xPvAwdXeHP+L7g8f44DKqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jds7nAvlHLZz+A5a6aRkrI9jY91pg+1fRHU3tE9LdWVN4+fGZ3kgJxu+1QnNu4xQk
	 TK2vaFbTwmLjHiz20MJZsDZ7QA1I2Afz9cylKfc9OF0NsCAuaXsdw4BpRczjUaCs2i
	 9jyrApVOMnZVlekOZQEI51ft8zaVvF1XLaJkEtaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfKSFpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbfKSFpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1746C21D7B;
        Tue, 19 Nov 2019 05:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142311;
        bh=bQI38G0uBLoRUHG1bRD67xPvAwdXeHP+L7g8f44DKqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ry2B5XL3a7DjoZjp7lqGZzkjBWSJA/R7NWXWjOrh5ZNSBNpDQ7NVGMM1B4ME6BAGa
         7BCWAsEyFMtQTvD2idQxo2VTun+BAu+FH8YPijsoOWikmgNjbz2Px3NI+ssAsB85SF
         OWlB6kXfFJGpEDwGM9wluaN9pG2WLF1DMicVZevM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 037/239] rtc: rv8803: fix the rv8803 id in the OF table
Date:   Tue, 19 Nov 2019 06:17:17 +0100
Message-Id: <20191119051304.620424607@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index aae2576741a61..6e06fb3b0b928 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -622,7 +622,7 @@ MODULE_DEVICE_TABLE(i2c, rv8803_id);
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



