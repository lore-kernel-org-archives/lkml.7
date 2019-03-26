Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B07DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157DC2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfCZSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731755AbfCZSs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:48:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84EAD206DF;
        Tue, 26 Mar 2019 18:48:27 +0000 (UTC)
Date:   Tue, 26 Mar 2019 14:48:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] [GIT PULL] tracing: Minor fixes for 5.1-rc2
Message-ID: <20190326144825.7b359641@gandalf.local.home>
In-Reply-To: <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
References: <20190326124143.521905652@goodmis.org>
        <CAHk-=wiw+vH-LwFRv910FhojCHUDjwUJ4pNWVJkAiP=deyyG3Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 10:48:44 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 26, 2019 at 5:42 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Please pull the latest trace-v5.1-rc2 tree, which can be found at:  
> 
> Pulled and pushed out, but for some reason the pr-tracker-bot doesn't
> seem to have reacted.
> 
> Presumably there's something in your git pull message that means it
> doesn't trigger.
> 
> And I suspect I know what it is: the patch that your subject line
> starts with "[PATCH..]" instead of "[GIT PULL..]"
>

Interesting. This is how I've always sent patches to you via quilt.

I usually don't put fixes sent to me through for-next, as I haven't
been convinced that that helps any. I make it a requirement to send any
patch I push into my tree for merging as a separate patch. As I usually
do that when I push to linux-next, if I send directly to you, I will
then send them individually.

The point being, when I send individual patches directly to you (and
not as a single email pull request), I use quilt sendmail. Which will
append the "[PATCH 0/x]" before my cover message subject.

Should I work on changing this?

-- Steve
