Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9255FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4B320820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613593;
	bh=m4oCH407rQAW5XKyhGt+ZTvbJSZ9olcE4tP3pKB+GGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cqgMzBiSqWVy7De0C6KlY4XMs9NLVavn3IH1EbLCGozNc4ZUxwmW/rLQ/FramCFIX
	 WEPb8QOPfhXlf6c87obubNYSXuaJZGP7OcxJNgHAOYsGhNzLOuJMoVMYfwzORrLPh9
	 RLfK36NkIXkRYVGV22QLDknX8DzU0INfUz0yzmfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfIDQNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732513AbfIDP77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:59:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51742070C;
        Wed,  4 Sep 2019 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612798;
        bh=m4oCH407rQAW5XKyhGt+ZTvbJSZ9olcE4tP3pKB+GGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ0k01+H4uQCTIhPhlBhaSVM2/1IkYrjbd/lL4Gp0+wfVifej1pR6Yzg8vBwmzho7
         7lzhGyLKGH2RKBvW8f+SoDDfBmx7VXMNYjRrgVDWny9jfEKH9ehzEiCcYn2ivUUHqp
         3epphV0uSgBFVXYjz9R/CI1CWmQ0l/WQOoqX0tdg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Razvan Stefanescu <razvan.stefanescu@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 92/94] net: dsa: microchip: add KSZ8563 compatibility string
Date:   Wed,  4 Sep 2019 11:57:37 -0400
Message-Id: <20190904155739.2816-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Razvan Stefanescu <razvan.stefanescu@microchip.com>

[ Upstream commit d9033ae95cf445150fcc5856ccf024f41f0bd0b9 ]

It is a 3-Port 10/100 Ethernet Switch with 1588v2 PTP.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz9477_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/microchip/ksz9477_spi.c b/drivers/net/dsa/microchip/ksz9477_spi.c
index 75178624d3f56..fb15f255a1db4 100644
--- a/drivers/net/dsa/microchip/ksz9477_spi.c
+++ b/drivers/net/dsa/microchip/ksz9477_spi.c
@@ -157,6 +157,7 @@ static const struct of_device_id ksz9477_dt_ids[] = {
 	{ .compatible = "microchip,ksz9897" },
 	{ .compatible = "microchip,ksz9893" },
 	{ .compatible = "microchip,ksz9563" },
+	{ .compatible = "microchip,ksz8563" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ksz9477_dt_ids);
-- 
2.20.1

