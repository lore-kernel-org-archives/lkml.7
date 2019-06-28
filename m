Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D9EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F86C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561724500;
	bh=R0QwjpCkRPykIHIhEX3lnlfnDS5C3THT6cPJlI8zVtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VU5nJfMgby30CxCtv+zqAaf1d1q8wpoRYwPJatyipsztn9zgQVBxe5CfhnsuD/lHJ
	 s7MzAhN07Qikx+kgVYTvQWm/THbONbwyEAcc65djXvaxskKn461xZ5EG0XJn680ebh
	 QPs0rSpQ7il/L6I0NJZY3684FCghmq+LMlm+AwQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfF1MUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:20:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF1MUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lS4UliZzmoTMkcnLKM4dNvFw1mukTFSV4no+MKbahvQ=; b=HR2oWrnWOcDjnjin1W5CiJVz1X
        /xmLyyJUGiYDqP8nW2Z7IclhJQdT2Il4uEV/S5vIz5edVYA7pxjRPi45Zk6XBjtxGi10+V6q39cH9
        M/KGh78Yd661KLCuMh+IiH+iP6FtSdwnF8B8mLGkd6BijH7pWRG3laNuMB3pd34RQOMrzs/MDEko2
        IT1PiG9CSSs8QYxKX0OvIXMXYOf3HwFQHb7AIB7XIigIbWt+ob5rfuCMCqmWmqtdVtDYidk+WPqR6
        42+cuhMwOms/DM+SVsQZCwtWYTnIreDI/IkYxtmI4VgISmj3+/k+vmUakaevINoQmYpBTnYCrHOvV
        HyNJYjyw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgprv-0000A9-Gv; Fri, 28 Jun 2019 12:20:43 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgprt-00058U-Jf; Fri, 28 Jun 2019 09:20:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 21/43] docs: DMA-API-HOWTO.txt: fix an unmarked code block
Date:   Fri, 28 Jun 2019 09:20:17 -0300
Message-Id: <b1bf9bea720a3a787c1f47f32856e5d0c723ecb3.1561723980.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723979.git.mchehab+samsung@kernel.org>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Sphinx, it would produce this warning:

    docs/Documentation/DMA-API-HOWTO.rst:222: WARNING: Definition list ends without a blank line; unexpected unindent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/DMA-API-HOWTO.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
index cb712a02f59f..358d495456d1 100644
--- a/Documentation/DMA-API-HOWTO.txt
+++ b/Documentation/DMA-API-HOWTO.txt
@@ -212,7 +212,7 @@ The standard 64-bit addressing device would do something like this::
 
 If the device only supports 32-bit addressing for descriptors in the
 coherent allocations, but supports full 64-bits for streaming mappings
-it would look like this:
+it would look like this::
 
 	if (dma_set_mask(dev, DMA_BIT_MASK(64))) {
 		dev_warn(dev, "mydev: No suitable DMA available\n");
-- 
2.21.0

