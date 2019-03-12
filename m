Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B765C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FD72147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCLPXQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLPXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:23:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B903E2054F;
        Tue, 12 Mar 2019 15:23:15 +0000 (UTC)
Date:   Tue, 12 Mar 2019 11:23:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     valdis.kletnieks@vt.edu
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/trace/trace_kprobe.c - fix comment format
Message-ID: <20190312112314.376d9c5f@gandalf.local.home>
In-Reply-To: <3692.1552381710@turing-police>
References: <2812.1552381112@turing-police>
        <3692.1552381710@turing-police>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 05:08:30 -0400
valdis.kletnieks@vt.edu wrote:

> On Tue, 12 Mar 2019 04:58:32 -0400, "Valdis Klētnieks" said:
> > 
> >   CC      kernel/trace/trace_kprobe.o
> > kernel/trace/trace_kprobe.c:41: warning: cannot understand function prototype: 'struct trace_kprobe '
> >
> > The real problem is that a comment looked like kerneldoc when it shouldn't be...  
> 
> After finding another case of this, it's debatable whether the *REAL* real
> problem is that gcc is buggy/incomplete and doesn't know that kerneldoc
> comments can be applied to structure definitions as well....
> 
> What's the consensus?  Should I go yell at the gcc people instead, or?

Nevermind, I mistook your patch as adding a kernel doc comment.

It's fine, I'll take it.

Thanks!

-- Steve
