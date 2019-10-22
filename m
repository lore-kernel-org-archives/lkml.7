Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3703FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127BE2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 03:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfJVDTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 23:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbfJVDTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 23:19:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0529820882;
        Tue, 22 Oct 2019 03:19:05 +0000 (UTC)
Date:   Mon, 21 Oct 2019 23:19:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191021231904.4b968dc1@oasis.local.home>
In-Reply-To: <20191021231630.49805757@oasis.local.home>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
        <20191002182106.GC4643@worktop.programming.kicks-ass.net>
        <20191003181045.7fb1a5b3@gandalf.local.home>
        <20191004112237.GA19463@hirez.programming.kicks-ass.net>
        <20191004094228.5a5774fe@gandalf.local.home>
        <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
        <20191021204310.3c26f730@oasis.local.home>
        <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 23:16:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > what bugs you're seeing?
> > The IPI frequency that was mentioned in this thread or something else?
> > I'm hacking ftrace+bpf stuff in the same spot and would like to
> > base my work on the latest and greatest.  

I'm also going to be touching some of this code too, as I'm waiting for
Peter's code to settle down. What are you touching? I'm going to be
working on making the dyn_ftrace records smaller, and this is going to
change the way the iterations work on modifying the code.

This is what I discussed on stage at Kernel Recipes with Willy Tarreau.

-- Steve
