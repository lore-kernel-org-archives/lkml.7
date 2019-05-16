Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042FC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641812087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEPBqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfEPAKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:10:02 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4CDA20848;
        Thu, 16 May 2019 00:10:01 +0000 (UTC)
Date:   Wed, 15 May 2019 20:10:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [GIT PULL] ktest: Updates for 5.2
Message-ID: <20190515201002.45c9d5cc@oasis.local.home>
In-Reply-To: <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
References: <20190515135602.2a6e6012@oasis.local.home>
        <CAHk-=wjbT4ZsWM=Rmz40+_umLmKz70ksEMnEOhLWJzQWudyNUA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 16:45:31 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, May 15, 2019 at 10:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Updates to ktest.pl  
> 
> Your pull request is showing stale data.
> 
> >  - Handle meta data in GRUB_MENU
> >
> >  - Add variable to cusomize what return value the reboot code should return.  
> 
> These were already long merged, from your first pull request last Monday.

Bah! I forgot that I did that. I even saw the tag I sent you last time
and that didn't even hit to me that I already sent these.

I do a short log on what I plan on sending and write up the change log
based on this.

I should have done a commit diff on your upstream tree and not just
base my pull request on where I started with your tree.

> 
> See
> 
>   68253e718c27 ("Merge tag 'ktest-v5.1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest")
> 
> and your own pull request
> 
>   Message-ID: <20190506133837.55832171@gandalf.local.home>
> 

Yeah, do you want me to make a new message, where it doesn't repeat the
previous pull? It will still have the same sha1 head, as nothing should
have changed, as its based on the same commit as that last pull.

-- Steve
