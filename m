Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF17C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF8521901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfDXI4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:56:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbfDXI4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:56:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5424AECB;
        Wed, 24 Apr 2019 08:55:59 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] livepatch/stacktrace: Clean up of reliable stacktrace errors
Date:   Wed, 24 Apr 2019 10:55:47 +0200
Message-Id: <20190424085550.29612-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ended with three patches in the end. The first one is the same
as before [1]. Then I added two patches for handling of the stacktrace
error messages.
 
[1] https://lkml.kernel.org/r/20190418112936.13295-1-pmladek@suse.com

Petr Mladek (3):
  livepatch: Convert error about unsupported reliable stacktrace into a
    warning
  stacktrace: Remove superfluous WARN_ONCE() from
    save_stack_trace_tsk_reliable()
  livepatch: Cleanup message handling in klp_try_switch_task()

 kernel/livepatch/core.c       |  5 ++---
 kernel/livepatch/transition.c | 19 ++++++++++++++-----
 kernel/stacktrace.c           |  1 -
 3 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.16.4

