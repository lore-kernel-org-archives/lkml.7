Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5AC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44A6218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJHR1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfJHR1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:27:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC50217D7;
        Tue,  8 Oct 2019 17:27:05 +0000 (UTC)
Date:   Tue, 8 Oct 2019 13:27:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 5/6] x86/ftrace: Use text_poke()
Message-ID: <20191008132704.3dc7a441@gandalf.local.home>
In-Reply-To: <20191008171137.GA22902@worktop.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
        <20191007081945.10951536.8@infradead.org>
        <20191008104335.6fcd78c9@gandalf.local.home>
        <20191008171137.GA22902@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 19:11:37 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 08, 2019 at 10:43:35AM -0400, Steven Rostedt wrote:
> 
> > BTW, I'd really like to take this patch series through my tree. That
> > way I can really hammer it, as well as I have code that will be built
> > on top of it.  
> 
> Works for me; or we can have a topic branch in tip we both can use.
> Ingo?

In case you want to use this branch, I just pushed:

git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

  ftrace/text-poke

That is these 6 patches applied to v5.4-rc2

I'm going to start running them through my tests. I can work on these
directly. And if Ingo wants to pull this into tip, then we can do that,
and apply the other patches on top of them.

Ingo, would that work for you?

-- Steve



> 
> > I'll review the other series in this thread, but I'm assuming they
> > don't rely on this series? Or do they?  
> 
> Indeed, this series stands on it's own. The rest depends on this.

