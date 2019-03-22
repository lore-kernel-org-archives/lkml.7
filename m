Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BA120830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256547;
	bh=lJ5LkpYE8X2Qwr8okiMGZ21UWuRHA05EZmnhIRisKog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=onZgE5cYmxxVuIAXBQb1Fgi9AmxQvwM5vmfFnEI8yPs9kE5VkVjHhXpC007e1Ifca
	 FQrohy8JAvh5qb5MzVdRkPrrVbj5/9CVchoWd/jycCHTXRgy7rhLDJSCr9qdzq1LZw
	 O15k8oaX2qedkH2GPcwe5SNk5Lw1wgEGTzqgmVjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbfCVMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733201AbfCVMJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A99520685;
        Fri, 22 Mar 2019 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256542;
        bh=lJ5LkpYE8X2Qwr8okiMGZ21UWuRHA05EZmnhIRisKog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPe2hfK5Vpuoz11TLHbgyIAQ/O9UdXPKsRGHEFUNEpdDdrUsDhoFzvgr/UB3ls/m7
         PM+rAJ8tFiRUcGX7wtsrytZaobRQq6kfoYa4g3tI5x++6AIS7m0kxBDwJSD5tS9eAo
         Cqvf0hk7umEr42/fqjYh3xxQRwan32zKU+YztP7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 210/280] can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument
Date:   Fri, 22 Mar 2019 12:16:03 +0100
Message-Id: <20190322111332.628555222@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 22233f7bf2c99ef52ec19d30876a12d2f725972e ]

This patch fixes the following checkpatch warning:

| Macro argument 'x' may be better as '(x)' to avoid precedence issues

Fixes: cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index ae219b8a7754..2646faffd36e 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -140,7 +140,7 @@
 #define FLEXCAN_TX_MB				63
 #define FLEXCAN_RX_MB_OFF_TIMESTAMP_FIRST	(FLEXCAN_TX_MB_RESERVED_OFF_TIMESTAMP + 1)
 #define FLEXCAN_RX_MB_OFF_TIMESTAMP_LAST	(FLEXCAN_TX_MB - 1)
-#define FLEXCAN_IFLAG_MB(x)		BIT(x & 0x1f)
+#define FLEXCAN_IFLAG_MB(x)		BIT((x) & 0x1f)
 #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
 #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
 #define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE	BIT(5)
-- 
2.19.1



