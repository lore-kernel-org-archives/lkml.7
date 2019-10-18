Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF7CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343EC21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 20:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440308AbfJRUb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 16:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404605AbfJRUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 16:31:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE71A2054F;
        Fri, 18 Oct 2019 20:31:26 +0000 (UTC)
Date:   Fri, 18 Oct 2019 16:31:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Message-ID: <20191018163125.346e078d@gandalf.local.home>
In-Reply-To: <20191018194856.GC20368@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
        <20191018124956.764ac42e@gandalf.local.home>
        <20191018171354.GB20368@zn.tnic>
        <20191018133735.77e90e36@gandalf.local.home>
        <20191018194856.GC20368@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 21:48:56 +0200
Borislav Petkov <bp@suse.de> wrote:

> > The #define was because we use to support mcount or __fentry__, now we
> > just support __fentry__, and function_hook describes it better ;-)  
> 
> Well sorry but gcc documentation talks about __fentry__. I'd keep the
> same name to avoid confusion and explain above it what it is. Much
> better.

Still looks ugly ;-)

> 
> > Heh, I guess we could, which would probably be quite a long comment as
> > it's the key behind ftrace itself.  
> 
> Well, you can explain with a couple of sentences what it is and
> then point at the bigger document explaining ftrace. Provided, Mr.
> Rostedt, you'll stop doing talks and finally sit down and write that
> documentation!

I do the talks hoping someone else will finally sit down and write the
documentation!

-- Steve

