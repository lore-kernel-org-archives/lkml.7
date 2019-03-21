Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9CD21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfCUQ0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCUQ0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:26:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FED2218E2;
        Thu, 21 Mar 2019 16:26:43 +0000 (UTC)
Date:   Thu, 21 Mar 2019 12:26:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     syzbot <syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org,
        ravi.bangoria@linux.ibm.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in delayed_uprobe_remove
Message-ID: <20190321122642.51dd7ed0@gandalf.local.home>
In-Reply-To: <20190321161841.GA12297@redhat.com>
References: <000000000000ec1b3805799d0a56@google.com>
        <000000000000737c07058498aea1@google.com>
        <20190321161841.GA12297@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:18:41 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> iiuc,
> 
> #syz fix: Uprobes: Fix kernel oops with delayed_uprobe_remove()

Thanks, because I haven't been able to reproduce this, and couldn't see
how it could bug like it did by looking at the current code.

-- Steve

> 
> On 03/21, syzbot wrote:
> >
> > syzbot has bisected this bug to:
> > 
> > commit a6ca88b241d5e929e6e60b12ad8cd288f0ffa256
> > Author: Song Liu <songliubraving@fb.com>
> > Date:   Tue Oct 2 05:36:36 2018 +0000
> > 
> >     trace_uprobe: support reference counter in fd-based uprobe
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c86993200000
> > start commit:   a6ca88b2 trace_uprobe: support reference counter in fd-bas..
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11c86993200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16c86993200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2a22859d870756c1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=eab6e18f95a9fe69005e
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137174f5400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278485d400000
> > 
> > Reported-by: syzbot+eab6e18f95a9fe69005e@syzkaller.appspotmail.com
> > Fixes: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based
> > uprobe")  

