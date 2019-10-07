Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C97BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698FA20700
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfJGQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbfJGQpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:45:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5049C206BB;
        Mon,  7 Oct 2019 16:45:11 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:45:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        hjl.tools@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [RFC][PATCH 0/9] Variable size jump_label support
Message-ID: <20191007124509.72f9fd26@gandalf.local.home>
In-Reply-To: <20191007161302.GI4643@worktop.programming.kicks-ass.net>
References: <20191007090225.441087116@infradead.org>
        <20191007084443.793701281@infradead.org>
        <20191007112229.GA3221@gmail.com>
        <20191007112606.GA44864@gmail.com>
        <20191007111742.00d6c50b@gandalf.local.home>
        <20191007161302.GI4643@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019 18:13:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Oct 07, 2019 at 11:17:42AM -0400, Steven Rostedt wrote:
> > Actually, even back then I said that it would be best to merge all the
> > tools into one (I just didn't have the time to implement it), and then
> > we could pull this off. I have one of my developers working to merge
> > record-mcount into objtool now (there's been some patches floating
> > around).  
> 
> Right, but while working on this I discovered GCC's -mrecord-mcount (and
> the kernel using this), so how much do we really still need the
> record-mcount tool?

That only works for some archs, not all of them. At least not yet that
I'm aware of.

> 
> Do we really only need the tool for the little hole between gcc-4.6
> (minimal supported GCC version) and gcc-5 (when -mrecord-mcount was
> introduced) ?

Again, it's for more than just x86 ;-)

-- Steve
