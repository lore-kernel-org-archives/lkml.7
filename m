Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2455C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35E0214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfJJVoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:44:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfJJVoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:44:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4405520B7C;
        Thu, 10 Oct 2019 21:44:29 +0000 (UTC)
Date:   Thu, 10 Oct 2019 17:44:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-kernel@vger.kernel.org, amakhalov@vmware.com,
        akaher@vmware.com, anishs@vmware.com, bordoloih@vmware.com,
        srivatsab@vmware.com
Subject: Re: [PATCH 3/3] tracing/hwlat: Fix a few trivial nits
Message-ID: <20191010174427.49a08f44@gandalf.local.home>
In-Reply-To: <889073497c3f8bed25acb0015049837141a3b688.camel@perches.com>
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
        <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
        <889073497c3f8bed25acb0015049837141a3b688.camel@perches.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 14:34:55 -0700
Joe Perches <joe@perches.com> wrote:

> On Thu, 2019-10-10 at 11:51 -0700, Srivatsa S. Bhat wrote:
> > Update the source file name in the comments, and fix a grammatical
> > error.  
> []
> > diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c  
> []
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * trace_hwlatdetect.c - A simple Hardware Latency detector.
> > + * trace_hwlat.c - A simple Hardware Latency detector.  
> 
> trivia:
> 
> Generally it's not useful to have the filename in a comment
> so I think maybe delete the "trace_hwlatdetect.c - ".

Not a big deal to keep it. The original proposed name for the tracer was
hwlatdetect, but people said it was too long and hwlat was good enough.
Thus we changed the name to that, but didn't change the comment here.

We could remove it, but I think it's fine to keep it.

-- Steve


> 
> btw:
> 
> $ git ls-files -- '*.[ch]' | \
>   while read file ; do git grep $file -- $file; done | wc -l
> 
> About 5% (2500 of the 50000 or so) *.[ch] files in the kernel
> source tree contain their filename in a comment, so it's
> certainly not that unusual.
> 

