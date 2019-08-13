Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B102C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A2F20644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 22:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfHMWqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 18:46:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:50690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfHMWqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:46:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F951ACB4;
        Tue, 13 Aug 2019 22:46:31 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     walken@google.com, peterz@infradead.org, akpm@linux-foundation.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH -tip 0/3] x86,mm/pat: Move towards using generic interval trees
Date:   Tue, 13 Aug 2019 15:46:17 -0700
Message-Id: <20190813224620.31005-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please refer to patch 1 for details, other two are incremental (small) cleanups
that probably depend on the first one.

Thanks!

Davidlohr Bueso (3):
  x86,mm/pat: Use generic interval trees
  x86,mm/pat: Cleanup some of the local memtype_rb_* calls
  x86,mm/pat: Rename pat_rbtree.c to pat_interval.c

 arch/x86/mm/Makefile       |   2 +-
 arch/x86/mm/pat_interval.c | 217 ++++++++++++++++++++++++++++++++++
 arch/x86/mm/pat_rbtree.c   | 281 ---------------------------------------------
 3 files changed, 218 insertions(+), 282 deletions(-)
 create mode 100644 arch/x86/mm/pat_interval.c
 delete mode 100644 arch/x86/mm/pat_rbtree.c

-- 
2.16.4

