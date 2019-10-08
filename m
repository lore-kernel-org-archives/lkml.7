Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B80ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA0B206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BhhEgF2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfJHP3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:29:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53206 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfJHP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EYiFJW7nu0Cy2CKQ8PkOp6XSsK19E1yuZjWyjvznUac=; b=BhhEgF2xIOYP9jMhQ8LJ0V5xj
        reaQ1WL97PmAeXxKPGiQkeghEhioj/AbPMQqSxxoox7eSK1ivwkXtsywCtCI7LKi99nWFzRaS2/sh
        15XPHTwqwn9yul/9dRMqodCT5pYpArPL/162ezWbytqGqclKLxJyDaQIz1YlVeyNhhJeltmKmr+Tt
        ghWG3HmFfsCJZ6OZppoe0lWw99nc+IyhRsIiykHpLyjH4F5ahf+4NItB6ndHvD9k/LRJpmWLdVXNM
        9mjU1kqIKfRYopoXjRiSzj/fwDa6MZo1Y6dpVBBce3nFu4mH2gae/7oj0v28flmHnChDAbxnGLG4n
        uRCjlVn0w==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrQZ-0001nJ-4m; Tue, 08 Oct 2019 15:29:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] hung_task: fix Documentation warning
Message-ID: <55ce9772-cffe-f28f-d002-088127842980@infradead.org>
Date:   Tue, 8 Oct 2019 08:29:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warning when building Documentation:

Documentation/admin-guide/sysctl/kernel.rst:397: WARNING: Title underline too short.

hung_task_interval_warnings:
===================

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/sysctl/kernel.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20191008.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ linux-next-20191008/Documentation/admin-guide/sysctl/kernel.rst
@@ -394,7 +394,7 @@ This file shows up if CONFIG_DETECT_HUNG
 
 
 hung_task_interval_warnings:
-===================
+============================
 
 The same as hung_task_warnings, but set the number of interval
 warnings to be issued about detected hung tasks during check

