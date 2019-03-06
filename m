Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A539C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111C320661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfCFOor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:44:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:41566 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727214AbfCFOor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C773DB9F4;
        Wed,  6 Mar 2019 14:44:45 +0000 (UTC)
Date:   Wed, 6 Mar 2019 15:44:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.1
Message-ID: <20190306144444.r4rdkgubipvsoezs@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.1

=================

- Allow to sort mixed lines by an extra information about the caller.

- Remove no longer used LOG_PREFIX.

- Some clean up and documentation update.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      lib/vsprintf: Remove %pCr remnant in comment

Louis Taylor (1):
      printk/docs: Add extra integer types to printk-formats

Tetsuo Handa (3):
      printk: Add caller information to printk() output.
      printk: Pass caller information to log_store().
      printk: Remove no longer used LOG_PREFIX.

 Documentation/core-api/printk-formats.rst |  8 +++
 include/linux/kern_levels.h               |  2 +-
 include/linux/printk.h                    |  1 -
 kernel/printk/printk.c                    | 90 ++++++++++++++++++++++++-------
 lib/Kconfig.debug                         | 17 ++++++
 lib/vsprintf.c                            |  1 -
 6 files changed, 96 insertions(+), 23 deletions(-)
