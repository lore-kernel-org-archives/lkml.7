Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DBFC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25682084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142995;
	bh=xOH+ix3LhRxkW9EZ3qVwZJdXRhikzraxle2sk20ZrZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OL0cWFfyfrY7cWx7B4Guki9rolV7cWpgMQqwkw5b7ySj8iF3jyUSHFzUD/fV4+Q1d
	 6fL/x13lxvEXD33qLEVFrK4+6PC6xZaAkNWrxfhKKnJcmLFs8DTViu6bnsYPuIzT4S
	 HTx0rEtYduEZ36iGTBzwZEDnkU3ZPotUhU4LwIOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfKSFxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbfKSFxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:53:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BB721939;
        Tue, 19 Nov 2019 05:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142794;
        bh=xOH+ix3LhRxkW9EZ3qVwZJdXRhikzraxle2sk20ZrZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfOD3sQ1fLuad1smZMLwj49UPXeV8ud5am/bQrlzZSDxB9muMLaJBe75Gy9C4bC8a
         Yrzj0YxvmiLo9F5UqJANJTJ7BItepFE+BYFGyJ1SsHBhsyWPGTLjWpXvXc0D2hsWM2
         l7Nns/gTcSee3k0c4PNLawN8S4XAxk/1Ud1zyBTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 201/239] phy: lantiq: Fix compile warning
Date:   Tue, 19 Nov 2019 06:20:01 +0100
Message-Id: <20191119051336.521587862@linuxfoundation.org>
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



