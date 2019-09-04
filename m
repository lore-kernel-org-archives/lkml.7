Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E63C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 314B522CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612705;
	bh=XFNuF7uzs1Qn5arkiQ4mGqElYb+I6FDtsCAORgQUYos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VV0Pj3QSnV+E5e87q5ONU6Mk5KMdjqe6mBkitUZW+rkjqZYbO5IGcTQDaylYDHm6c
	 dnbnhkKUaC172o6UnZzVvCinGys3kfIw2vTyDGicH1/fJ5HvBXOHK+h3edBa5D7MFV
	 93Eatq3NMWPIYEY5hSLcwBUyr+obXnK6g5VijQAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbfIDP6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731924AbfIDP6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:58:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE2822CED;
        Wed,  4 Sep 2019 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612701;
        bh=XFNuF7uzs1Qn5arkiQ4mGqElYb+I6FDtsCAORgQUYos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0a4nh2d47wL574hBM0EyAm1ZT2qslyr5gm1l879RN6JCB+2nrdi6VnBiIfMMxTV1y
         v4hadfnbTAf3VNsM3oWw8PLK62cbAjSYxstyBdk1U1ovJYuOOwK7i931z9E3aeq3As
         QV6Z2BWChvv9pO6Sb9wyYmMH9llS+4vZZPk4UKe4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 29/94] Kconfig: Fix the reference to the IDT77105 Phy driver in the description of ATM_NICSTAR_USE_IDT77105
Date:   Wed,  4 Sep 2019 11:56:34 -0400
Message-Id: <20190904155739.2816-29-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit cd9d4ff9b78fcd0fc4708900ba3e52e71e1a7690 ]

This should be IDT77105, not IDT77015.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index 2e2efa577437e..8c37294f1d1ee 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -200,7 +200,7 @@ config ATM_NICSTAR_USE_SUNI
 	  make the card work).
 
 config ATM_NICSTAR_USE_IDT77105
-	bool "Use IDT77015 PHY driver (25Mbps)"
+	bool "Use IDT77105 PHY driver (25Mbps)"
 	depends on ATM_NICSTAR
 	help
 	  Support for the PHYsical layer chip in ForeRunner LE25 cards. In
-- 
2.20.1

