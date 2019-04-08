Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E48C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D1920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742744;
	bh=2gVsSC1nBl4XPpL9550+J9sNhpNGHN2cWmlTuEOHu1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOBMsMNG0UhvLPeg26ffZZFCx0Sc8PtWGfPIt4s+LNmp2kmqRY5pY3O+g6pPtglDr
	 3vrrVw0becjLj6hrshRoARtYvUGUzLoX0uCvSOfv7LStRXss4Lryn5kH6ENAsGhZXp
	 xeyALxz4Zb1SfPnLL8kR6GmodPchhFfce7W/ytLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfDHQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfDHQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T0SBZllgHqVlHqCRx9ICKVMFMCBWkpJnm5qm1nU/vMM=; b=kImPDBxVgMJduWgH58S2PNxAiK
        ztZ8gghyYNnq4b9S3Nl+mS4NgaUpxGHkfsD/xd2Sd2j9t5PoD+d+eqyagenMHaPXTyqu5OSVFeNsY
        Jb5FCWNqu+avS5SHsyYATuHD0hr3T/YRs0xBUuDS5GgDLyUtxohd7Cm3OXk1JLgD+3ibGEKlxT0tc
        WdbkDzeOdL4IR/Oi+zK3RXmHvXo8r03vzJjZJTKfEoXgYbDrMQAY1Uw9M2PzEDBsSDKda5BfbpTDk
        CkjZ5KZ3xm9KGPljlCOm63CQJ83gRvsZmVBbhaI43iB06zv28ptcjpasOzDoPBQBamRayo2H50mth
        YEDFPzQA==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sl-DB; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005n9-7Y; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 03/10] docs: clearing-warn-once.txt: add a title for this document
Date:   Mon,  8 Apr 2019 13:58:19 -0300
Message-Id: <eb6ebd1482dfa60b2eeb2f90f77eab695c5e89ef.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document misses a title. Add it, in order to follow
the documentation standard.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/clearing-warn-once.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/clearing-warn-once.txt b/Documentation/clearing-warn-once.txt
index 5b1f5d547be1..4aa938262d0e 100644
--- a/Documentation/clearing-warn-once.txt
+++ b/Documentation/clearing-warn-once.txt
@@ -1,3 +1,5 @@
+Clearing WARN_ONCE
+------------------
 
 WARN_ONCE / WARN_ON_ONCE only print a warning once.
 
-- 
2.20.1

