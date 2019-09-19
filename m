Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC0C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBA2217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931860;
	bh=1uYRIa9dJFLkZU1QyZXcVGUl/P1dDHw2UzJHa6GuqiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=frCg2F3krmZnV7S/cFl5b832A1jOdHUQJxeqbtIrgbav3MpJfD4so9t6FEPO9OnzI
	 fT5nJgK9Sl9qVbWUtQcG/ipFS599qkmLaHpGFmKnlOaHOZr6npW0oiofVY2XiiRJSY
	 Vl133/Kd5tv+jP0sdnrYLRcE5cH1Bu78FHU3KHAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407151AbfISWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407126AbfISWYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:24:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB9121929;
        Thu, 19 Sep 2019 22:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931855;
        bh=1uYRIa9dJFLkZU1QyZXcVGUl/P1dDHw2UzJHa6GuqiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij+VIwp+gJ+xsn7Mn5qWO+CjfrKGWTNpPMr6s1v1dmIrkMPl4qrRWaLANpYORtyF+
         UmCuOQ+cWIa6l0ZcxdWszApyOSPzSr3iek/8rG9lEF/RffDSUCOlFxp0EJCUA9aOLC
         hjs/KGOHRliCe0X7P6tfnWpeZ3Bv41MAjC1niQxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 40/56] Kconfig: Fix the reference to the IDT77105 Phy driver in the description of ATM_NICSTAR_USE_IDT77105
Date:   Fri, 20 Sep 2019 00:04:21 +0200
Message-Id: <20190919214759.532303351@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 31c60101a69a4..7fa840170151b 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -199,7 +199,7 @@ config ATM_NICSTAR_USE_SUNI
 	  make the card work).
 
 config ATM_NICSTAR_USE_IDT77105
-	bool "Use IDT77015 PHY driver (25Mbps)"
+	bool "Use IDT77105 PHY driver (25Mbps)"
 	depends on ATM_NICSTAR
 	help
 	  Support for the PHYsical layer chip in ForeRunner LE25 cards. In
-- 
2.20.1



