Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8251C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A26207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLIMTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:19:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:33104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727232AbfLIMTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:19:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67D58AD6B;
        Mon,  9 Dec 2019 12:19:01 +0000 (UTC)
Date:   Mon, 9 Dec 2019 13:19:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Final pr_warning() removal
Message-ID: <20191209121900.s2foip7ovavr3d5c@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the final pr_warning() removal from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.5-pr-warning-removal

I have waited until the end of the merge window to avoid eventual
build problems.

==================================

- Final removal of the unused pr_warning() alias.

----------------------------------------------------------------
Kefeng Wang (3):
      workqueue: Use pr_warn instead of pr_warning
      printk: Drop pr_warning definition
      checkpatch: Drop pr_warning check

Stephen Rothwell (1):
      Fix up for "printk: Drop pr_warning definition"

 include/linux/printk.h     | 3 +--
 kernel/trace/ring_buffer.c | 2 +-
 kernel/trace/trace.c       | 6 +++---
 kernel/workqueue.c         | 4 ++--
 scripts/checkpatch.pl      | 9 ---------
 5 files changed, 7 insertions(+), 17 deletions(-)
