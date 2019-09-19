Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C7EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B76621924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931389;
	bh=XFNuF7uzs1Qn5arkiQ4mGqElYb+I6FDtsCAORgQUYos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/DdK8eNOkTdG9Yk+gvnt7yYMlgfvdtOQ2tI1zSQEQ811DIkftNk8UQCGYf4xRy9/
	 ZKdv76xHZ2CmEKY70HPJ7kz53f8ha8BTiNN3oXVp3eSAcLJ3XHoni217j0v3lsk0T9
	 miLv7+l0oC784gnEwXRGeo1QdRqPjYPL1fyACslU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfISWQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406321AbfISWQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD78217D6;
        Thu, 19 Sep 2019 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931381;
        bh=XFNuF7uzs1Qn5arkiQ4mGqElYb+I6FDtsCAORgQUYos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyThtcXmjGWqoOUk9ir/mZrJVsd769MY9Gioh9BD/XXQCI4ahjpoc2L6DIXnb0Be3
         mnjqr8Erk4zNenKcLaagHeSd1qXdDNrXEsdnxHSLPgYyDMY7jK8DMEsiQAUO6qYvSR
         q6SH6yNRKT6gOaqPxbQpB6g30MP07N4FLtGQAjos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/59] Kconfig: Fix the reference to the IDT77105 Phy driver in the description of ATM_NICSTAR_USE_IDT77105
Date:   Fri, 20 Sep 2019 00:03:40 +0200
Message-Id: <20190919214804.605568642@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
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



