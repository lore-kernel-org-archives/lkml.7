Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51690C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA320700
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfCZVq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbfCZVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:46:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48DD820700;
        Tue, 26 Mar 2019 21:46:25 +0000 (UTC)
Date:   Tue, 26 Mar 2019 17:46:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] [GIT PULL] tracing: Minor fixes for 5.1-rc2
Message-ID: <20190326174623.16d7725f@gandalf.local.home>
In-Reply-To: <CAHk-=wg5_Hu4W5tz05vmC3eBH3_h7_uJKEMwLM+MvsJ=znWtbw@mail.gmail.com>
References: <20190326124143.521905652@goodmis.org>
        <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
        <20190326144825.7b359641@gandalf.local.home>
        <CAHk-=wg5_Hu4W5tz05vmC3eBH3_h7_uJKEMwLM+MvsJ=znWtbw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 14:29:27 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 26, 2019 at 11:48 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Should I work on changing this?  
> 
> I don't personally much care, but the pr-tracker-bot clearly does.
> 
> If you don't care about the automated "it's been pulled" message, that
> doesn't matter, of course.

I'm subscribed to your git tree and filter out all updates for my
signed off by. An then I get those emails. So I get the "Pulled"
message regardless.

> 
> That said, I'd almost prefer to get just the regular pull request
> without the patches. If the complete patch is small, it's often nice
> to see that _in_ the pull request (at the bottom), but I don't
> generally need or want the individual patches themselves as separate
> emails (unless there's some particular reason you want me to comment
> on something, or apply them directly as patches).

It's not really for you, but more for transparency in general. I have a
rule that I don't push anything to you that I haven't personally sent
to LKML as a separate patch.

It's not a big deal. I could make this a two step process, and send
these as my "for-next" patches so that people (including the authors of
the patch) know that I'm sending them upstream.

-- Steve
