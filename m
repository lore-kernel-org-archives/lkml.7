Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97426C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664BE20856
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfEYWhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 18:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfEYWhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 18:37:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946892081C;
        Sat, 25 May 2019 22:37:16 +0000 (UTC)
Date:   Sat, 25 May 2019 18:37:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/4] trace: introduce trace event injection
Message-ID: <20190525183715.0778f5e5@gandalf.local.home>
In-Reply-To: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019 09:57:58 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> This patchset introduces trace event injection, the first 3 patches
> are some trivial prerequisites, the last one implements the trace
> event injection. Please check each patch for details.
> 
> I have tested them with both valid and invalid input on different
> tracepoints, it works as expected.

Hi Cong,

Thanks for sending these patches, but I just want to let you know that
it's currently a US holiday, and then afterward I'll be doing quite a
bit of traveling for the next two weeks. If you don't hear from me in
after two weeks, please send me a reminder.

Thanks!

-- Steve


> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> ---
> 
> Cong Wang (4):
>   trace: fold type initialization into tracing_generic_entry_update()
>   trace: let filter_assign_type() detect FILTER_PTR_STRING
>   trace: make trace_get_fields() global
>   trace: introduce trace event injection
> 
>  include/linux/trace_events.h       |   9 +
>  kernel/trace/Makefile              |   1 +
>  kernel/trace/trace.c               |   8 +-
>  kernel/trace/trace.h               |   1 +
>  kernel/trace/trace_event_perf.c    |   3 +-
>  kernel/trace/trace_events.c        |  12 +-
>  kernel/trace/trace_events_filter.c |   3 +
>  kernel/trace/trace_events_inject.c | 330 +++++++++++++++++++++++++++++
>  8 files changed, 353 insertions(+), 14 deletions(-)
>  create mode 100644 kernel/trace/trace_events_inject.c
> 

