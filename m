Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE3C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A62146E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 06:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfFHGXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 02:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfFHGXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 02:23:47 -0400
Received: from oasis.local.home (unknown [217.16.13.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5615208E3;
        Sat,  8 Jun 2019 06:23:42 +0000 (UTC)
Date:   Sat, 8 Jun 2019 02:23:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC][PATCH 00/14 v2] function_graph: Rewrite to allow multiple
 users
Message-ID: <20190608022333.60c42636@oasis.local.home>
In-Reply-To: <20190530182920.d8ef9f3c09ba0ae1beaa605a@kernel.org>
References: <20190520142001.270067280@goodmis.org>
        <20190522231955.72899b0d606adb919e8716ff@kernel.org>
        <20190522104027.1b2aabd8@gandalf.local.home>
        <20190529154740.016517ff9225680f64961097@kernel.org>
        <20190529052521.6623ae7b@oasis.local.home>
        <20190530182920.d8ef9f3c09ba0ae1beaa605a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019 18:29:20 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > OK, so this series isn't enough to allow kretprobes to use it yet. OK,
> > I plan on still keeping it because it does allow for placing function
> > graph tracer into instances with their own filters.  
> 
> OK, that will be a "regs" extension.
> > 
> > I'll look into adding a REGS flag like we do with ftrace_ops.
> > 
> > Does the return need all regs? Or is just the return code good enough?  
> 
> Since it depends on arch, I think all regs we need. And for the entry
> handler, we need all.

When I get back home, I'm going to push this series to linux-next. And
then I'll start adding the REGS extension for the next Linux release
after this series gets in.

Thanks for looking at it.

-- Steve

