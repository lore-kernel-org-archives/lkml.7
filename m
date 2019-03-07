Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A42DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E784C20835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VAVPL+i6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfCGFuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:50:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfCGFue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aGkE1fu3sKSUZS0ZnuQWktHBiK/btOhjcOFlOeuAnWQ=; b=VAVPL+i6ZmV4QJtJtlMcnaSCxh
        +Oalp1cAEfzRk5Ns8zJLZyZfnMkGZWm3XAxKDynNkigqyEvHJUVGYvsexL2zRl9bQzIY6p58ayzK9
        zF6lJwe5jpqIc3xyCVR3wGDghD0A8+76mRBzYCFg8pMfj57X+SClqmFmuwRQsKJ1Qq9fl5N52gLNI
        sWpoeYTE4Yc4Kml7wimQqMP3RWtPNdOL00kthHqPjmaqv5fV3JwkyRXdwidsUiNvQtwyaPqvfSHct
        aPn5a6kzWDpnDxtPLQS+ufFOK3OAFXLLnctJ9f91djvNEEz7u68Mgr2Zk/5dHNvAhui21+ZmgCG3N
        7WDGgNIA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1lvN-000728-IV; Thu, 07 Mar 2019 05:50:33 +0000
Date:   Wed, 6 Mar 2019 21:50:32 -0800
From:   "Darren Hart (VMware)" <dvhart@infradead.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vadim Pasternak <vadimp@mellanox.com>, andy@infradead.org
Subject: [PATCH] MAINTAINERS: Include mlxreg.h in Mellanox Platform Driver
 files
Message-ID: <b0b6ac4eee58fbda83574f020d89651a12a8e40f.1551937716.git.dvhart@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid conflicts from other subsystems by including the header with the
rest of the driver files.

Cc: Andy Shevchenko <andy@infradead.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..eb0b9aba4802 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9711,6 +9711,7 @@ M:	Vadim Pasternak <vadimp@mellanox.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/mellanox/
+F:	include/linux/platform_data/mlxreg.h
 
 MELLANOX MLX4 core VPI driver
 M:	Tariq Toukan <tariqt@mellanox.com>
-- 
2.17.2


-- 
Darren Hart
VMware Open Source Technology Center
