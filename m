Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F86BC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE9521906
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742757;
	bh=h1w91qjhr78pnIAsWgYKlbFZxpqxhFcF+aY1oYDXM9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1aK3aFlZCvgU5OGh85wUR/b7RMKo/IVd39AiRifwyY0so1HuLKUGqHZ68RZf6ef62
	 AsJx6pQzoGEQ4vKrlNg4VI/5O8aQk0baPbunPsoyKzMk6WWpPduf8uwtkdzKIbXwq3
	 56SSI8ga9wpjXjQLu6jpjoWjq20y2rDY9iDYMor0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfDHQ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:59:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbfDHQ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VAMFAFAKujLSv3Qur+yCPXsO8JE9Zm7EVPPt0xUnG4w=; b=VI741FL6dzywKgE6gi9TIgSHLd
        x6pLjFIhFmybKr7l5qKbMVmd3WkeuI7Z9/Sy7ZV1kJ1LNTGcAOWSAkz22En3L7wLbEhkL7Pxde9PR
        q8kDtwfEHieLWVpwdropZF/W02WtK2Z0N3b9oGg66a/ShpCbDcRdVZ2wWT2fIJCOOLl7HeRyeF74H
        HKkP22F6rBNg9bGHHjCXfS2i0E52rWWHYMwtbusV5ZVgxYdjCvUn/VIxTxnD5f0J/7X93s1O+19ry
        gVqof729iU7bCYEdzY8moATyezf7IoIobnfxaKS2vMEJDBmmvefU3zEfMq5OrOesAgpcEIXltpY1Z
        FW9JS2/Q==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbQ-0005Su-LF; Mon, 08 Apr 2019 16:58:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005n1-5x; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/10] docs: DMA-API-HOWTO: add a missing "="
Date:   Mon,  8 Apr 2019 13:58:17 -0300
Message-Id: <3799c957f95603f90ea2f3119b550a9810d0dc79.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The === line is shorter than the section title.

As this will generate a warning with rst build, fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/DMA-API-HOWTO.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index 1a721d0f35c8..db48c6fd3162 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -147,7 +147,7 @@ networking subsystems make sure that the buffers they use are valid
 for you to DMA from/to.
 
 DMA addressing capabilities
-==========================
+===========================
 
 By default, the kernel assumes that your device can address 32-bits of DMA
 addressing.  For a 64-bit capable device, this needs to be increased, and for
-- 
2.20.1

