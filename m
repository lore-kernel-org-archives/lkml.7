Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F6CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1014C206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621095;
	bh=WCkSDHhDod0dNyN+ga/qSbI1H/xENw8joAUwSfjiOqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYY9/uGx1NWQ3xHgRSlbRJz0MKYLh5Alhr23S3HXsvHbQR7tBEeGeY/Jv+X/HI2fx
	 FrFUpiaWWcaNxneKJkWxmx/cIYuCR60X8S1vzp3JwioSD8/okxxtPsaYNeDca5a9c3
	 WXAZbzPx0TOwDIO3rj+y3IqfGO0zF7ajjYxQaU4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390358AbfIDSSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:18:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389736AbfIDSL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A3A208E4;
        Wed,  4 Sep 2019 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620689;
        bh=WCkSDHhDod0dNyN+ga/qSbI1H/xENw8joAUwSfjiOqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPEQ33TKwdNGQpGlPbfIqHJLF4vbBv9xx4WKQte4RK4ie3PB/5hHNtqfG0esro/tf
         zlxnqqVgEbcnuS/LF3fLn2ZOGUKxVoNsWavntzhSGQ/qcG+frc3hgknM7FM/o+PsW6
         YZsy337S8LtvqB3ttWxtll6FDT2qkuxApOsxU0vI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 017/143] soundwire: cadence_master: fix register definition for SLAVE_STATE
Date:   Wed,  4 Sep 2019 19:52:40 +0200
Message-Id: <20190904175314.755664261@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b07dd9b400981f487940a4d84292d3a0e7cd9362 ]

wrong prefix and wrong macro.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190725234032.21152-14-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/cadence_master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 682789bb8ab30..18afb2e21dc9a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -80,8 +80,8 @@
 
 #define CDNS_MCP_INTSET				0x4C
 
-#define CDNS_SDW_SLAVE_STAT			0x50
-#define CDNS_MCP_SLAVE_STAT_MASK		BIT(1, 0)
+#define CDNS_MCP_SLAVE_STAT			0x50
+#define CDNS_MCP_SLAVE_STAT_MASK		GENMASK(1, 0)
 
 #define CDNS_MCP_SLAVE_INTSTAT0			0x54
 #define CDNS_MCP_SLAVE_INTSTAT1			0x58
-- 
2.20.1



