Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175C1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E546F20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbfCYVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:20 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:50070 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbfCYVZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 09E8A181D3403;
        Mon, 25 Mar 2019 21:25:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shape38_10b3cb287165c
X-Filterd-Recvd-Size: 4492
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:25:14 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Bad file pattern in MAINTAINERS section 'FUTEX SUBSYSTEM'
Date:   Mon, 25 Mar 2019 14:25:13 -0700
Message-Id: <20190325212513.26420-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	6410	FUTEX SUBSYSTEM
	6411	M:	Thomas Gleixner <tglx@linutronix.de>
	6412	M:	Ingo Molnar <mingo@redhat.com>
	6413	R:	Peter Zijlstra <peterz@infradead.org>
	6414	R:	Darren Hart <dvhart@infradead.org>
	6415	L:	linux-kernel@vger.kernel.org
	6416	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
	6417	S:	Maintained
	6418	F:	kernel/futex.c
-->	6419	F:	kernel/futex_compat.c
	6420	F:	include/asm-generic/futex.h
	6421	F:	include/linux/futex.h
	6422	F:	include/uapi/linux/futex.h
	6423	F:	tools/testing/selftests/futex/
	6424	F:	tools/perf/bench/futex*
	6425	F:	Documentation/*futex*

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'kernel/futex_compat.c':

commit 59cd42c29618c45cd3c56da43402b14f611888dd
Author: Darren Hart (VMware) <dvhart@infradead.org>
Date:   Fri Apr 14 15:46:08 2017 -0700

    MAINTAINERS: Add FUTEX SUBSYSTEM
    
    Add a MAINTAINERS block for the FUTEX SUBSYSTEM which includes the core
    kernel code, include headers, testing code, and Documentation. Excludes
    arch files, and higher level test code.
    
    I added tglx and mingo as M as they have made the tip commits and peterz
    and myself as R.
    
    Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Shuah Khan <shuah@kernel.org>
    Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
    Link: http://lkml.kernel.org/r/20170414224608.GA5180@fury
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'kernel/futex_compat.c':

commit 04e7712f4460585e5eed5b853fd8b82a9943958f
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Apr 17 16:31:07 2018 +0200

    y2038: futex: Move compat implementation into futex.c
    
    We are going to share the compat_sys_futex() handler between 64-bit
    architectures and 32-bit architectures that need to deal with both 32-bit
    and 64-bit time_t, and this is easier if both entry points are in the
    same file.
    
    In fact, most other system call handlers do the same thing these days, so
    let's follow the trend here and merge all of futex_compat.c into futex.c.
    
    In the process, a few minor changes have to be done to make sure everything
    still makes sense: handle_futex_death() and futex_cmpxchg_enabled() become
    local symbol, and the compat version of the fetch_robust_entry() function
    gets renamed to compat_fetch_robust_entry() to avoid a symbol clash.
    
    This is intended as a purely cosmetic patch, no behavior should
    change.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 include/linux/futex.h |   8 --
 kernel/Makefile       |   3 -
 kernel/futex.c        | 195 +++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/futex_compat.c | 202 --------------------------------------------------
 4 files changed, 192 insertions(+), 216 deletions(-)
