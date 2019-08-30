Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75554C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25523439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfH3WBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfH3WBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:01:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6B3323431;
        Fri, 30 Aug 2019 22:01:51 +0000 (UTC)
Date:   Fri, 30 Aug 2019 18:01:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com, Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH 0/3] tracing: fix minor build warnings
Message-ID: <20190830180150.687f3ec8@gandalf.local.home>
In-Reply-To: <20190828052549.2472-1-jakub.kicinski@netronome.com>
References: <20190828052549.2472-1-jakub.kicinski@netronome.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 22:25:46 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> Hi!
> 
> trace.o gets rebuild on every make run when tracing is enabled,
> which makes all warnings particularly noisy. This patchset fixes
> some low-hanging fruit on W=1 C=1 builds.
> 
> Jakub Kicinski (3):
>   tracing: correct kdoc formats

I took the first one, but the two below, I wont take. Those changes
were added in preparation of the kernel access to tracing code.

See:

  http://lkml.kernel.org/r/1565805327-579-1-git-send-email-divya.indi@oracle.com

-- Steve


>   tracing: remove exported but unused trace_array_destroy()
>   tracing: make trace_array_create() static
> 
>  kernel/trace/trace.c | 47 ++++++++++++++------------------------------
>  1 file changed, 15 insertions(+), 32 deletions(-)
> 

