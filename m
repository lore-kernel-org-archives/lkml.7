Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3026BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32E320872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143398;
	bh=xOH+ix3LhRxkW9EZ3qVwZJdXRhikzraxle2sk20ZrZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQr34hPMu2tk29G0uEUK6vqfKGttdrSvpd7sOaru7fJO76aUELs+XFkNYnkLQj0mV
	 6K+PjoujCrgRVPgQDPzDgl24B9fwWfSmYz0wERKIEtTMJk0b36l1N1gSqQBwTiP+d9
	 iPc6+fQ2DVqVVNWdo76UV12/xdMYrT8NspLDOmic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfKSFk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:34596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbfKSFkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:40:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C6921783;
        Tue, 19 Nov 2019 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142024;
        bh=xOH+ix3LhRxkW9EZ3qVwZJdXRhikzraxle2sk20ZrZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4/sahUQh1cYIIy5Gyd5rl/KnzqLLTOME9723y83ScRNSrkEI1H06JtnCLVwzFXg5
         UejOvl62ArptLlJbTpgIIxBa6fHLefP7bwKfqKLETfqGmbjJv7Q/YDdohI1fUbzGAc
         WU60vqIFzjBzMVvSNQPEEwf8FCs6A45NGOlAjEeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 363/422] phy: lantiq: Fix compile warning
Date:   Tue, 19 Nov 2019 06:19:20 +0100
Message-Id: <20191119051422.538015251@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hauke Mehrtens <hauke@hauke-m.de>

[ Upstream commit 3a00dae006623d799266d85f28b5f76ef07d6b6c ]

This local variable is unused, remove it.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index 986224fca9e91..5a180f71d8d4d 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -156,7 +156,6 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
 {
 	struct device *dev = priv->dev;
 	const __be32 *offset;
-	int ret;
 
 	priv->reg_bits = of_device_get_match_data(dev);
 
-- 
2.20.1



