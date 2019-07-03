Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AF6C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954982085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562126154;
	bh=CxUEK7U00Mpfhb84z/h3PGb5BzXqjCJA1mrtOyZ3IoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t/UA95GE2WbEbBZhZ+ILqXA30YVK/DV95gLcU2UmaH2wvgRMIN6D2L8sUUYYgstJI
	 EnksIIAFa3ftD0g5NYcLYuaq06uFjFUwOdp3co5O+SMSgMkWHUuzhyjcR/Znevjzi6
	 mRUmlaNE1Xzv/sYOlMelN/kIx72WlcgCFXRzIn2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfGCDzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfGCDzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:55:53 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9957220673;
        Wed,  3 Jul 2019 03:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562126152;
        bh=CxUEK7U00Mpfhb84z/h3PGb5BzXqjCJA1mrtOyZ3IoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgUuNjweTsk7nr4lxrratRW6XoZEquf8p3dzbrg6fJ6XcVz0qod5YX+hWM71d8yPy
         SJsd3FL/aCPEedsOTRo+eO4HpJyUbynmFxST9H0sN6WLsVh58seKgq9yzrSLE/aE+4
         ZG2avSvKWrsRqz2riDbtxM+yHbsvOQ1/bX8a25jc=
Date:   Tue, 2 Jul 2019 20:55:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzkaller-bugs@googlegroups.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: Reminder: 22 open syzbot bugs in perf subsystem
Message-ID: <20190703035550.GA633@sol.localdomain>
References: <20190702054342.GB27702@sol.localdomain>
 <5a99f556-7449-55da-d901-0249352a5e15@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a99f556-7449-55da-d901-0249352a5e15@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 09:09:55AM +0530, Ravi Bangoria wrote:
> 
> 
> On 7/2/19 11:13 AM, Eric Biggers wrote:
> > --------------------------------------------------------------------------------
> > Title:              possible deadlock in uprobe_clear_state
> > Last occurred:      164 days ago
> > Reported:           201 days ago
> > Branches:           Mainline
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=a1ce9b3da349209c5085bb8c4fee753d68c3697f
> > Original thread:    https://lkml.kernel.org/lkml/00000000000010a9fb057cd14174@google.com/T/#u
> > 
> > Unfortunately, this bug does not have a reproducer.
> > 
> > No one replied to the original thread for this bug.
> > 
> > If you fix this bug, please add the following tag to the commit:
> >     Reported-by: syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
> > 
> > If you send any email or patch for this bug, please consider replying to the
> > original thread.  For the git send-email command to use, or tips on how to reply
> > if the thread isn't in your mailbox, see the "Reply instructions" at
> > https://lkml.kernel.org/r/00000000000010a9fb057cd14174@google.com
> > 
> 
> This is false positive:
> https://marc.info/?l=linux-kernel&m=154925313012615&w=2
> 

What do you mean "false positive"?  Your patch says there can be a deadlock.
Also, your patch hasn't been merged yet.  So doesn't it still need to be fixed?

- Eric
