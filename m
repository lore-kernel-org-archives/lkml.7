Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7974CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B08205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfJUXVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:21:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730695AbfJUXVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:21:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EE46AFE3;
        Mon, 21 Oct 2019 23:21:08 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 4/4] x86/mm, pat:  Rename pat_rbtree.c to pat_interval.c
Date:   Mon, 21 Oct 2019 16:19:24 -0700
Message-Id: <20191021231924.25373-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191021231924.25373-1-dave@stgolabs.net>
References: <20191021231924.25373-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the previous changes, this is a more proper name.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/x86/mm/{pat_rbtree.c => pat_interval.c} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename arch/x86/mm/{pat_rbtree.c => pat_interval.c} (100%)

diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_interval.c
similarity index 100%
rename from arch/x86/mm/pat_rbtree.c
rename to arch/x86/mm/pat_interval.c
-- 
2.16.4

