Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF103C3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22DA222CF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfJELaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 07:30:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfJELaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:30:01 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGiG6-0007kK-P3; Sat, 05 Oct 2019 11:29:58 +0000
Date:   Sat, 5 Oct 2019 13:29:58 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        bsingharora@gmail.com, Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KCSAN: data-race in taskstats_exit / taskstats_exit
Message-ID: <20191005112957.n2fuhhmqdgrctcxj@wittgenstein>
References: <0000000000009b403005942237bf@google.com>
 <CACT4Y+bcUggJkCFTYzT3PNgTtQb5i-uc3nHwixQp+nJORYk4RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bcUggJkCFTYzT3PNgTtQb5i-uc3nHwixQp+nJORYk4RA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 06:29:39AM +0200, Dmitry Vyukov wrote:
> On Sat, Oct 5, 2019 at 6:26 AM syzbot
> <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    b4bd9343 x86, kcsan: Enable KCSAN for x86
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=125329db600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c5d03165a1bd1dead0c1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
> 
> +Christian, you wanted races in process mgmt ;)

Yes, indeed. :) Sent a fix for this one just now. I'll put it in my
fixes tree for rc3.

Christian
