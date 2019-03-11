Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BCEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8032063F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfCKRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:34786 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfCKRWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:22:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BD6FFAD52;
        Mon, 11 Mar 2019 17:22:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Mar 2019 18:22:14 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com>,
        'Dmitry Vyukov' via syzkaller-bugs 
        <syzkaller-bugs@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in ep_poll_callback
In-Reply-To: <CACT4Y+aHBMnOHQaTphgGwW8mZbDeHCu+Ce8zXki1ntdEbTPJqQ@mail.gmail.com>
References: <CACT4Y+YLZYJ21Bao5HVAvXhvb9PQ41J-4RvtkZZEMF38qtkxHg@mail.gmail.com>
 <00000000000073a5740583d42c1e@google.com>
 <CACT4Y+aHBMnOHQaTphgGwW8mZbDeHCu+Ce8zXki1ntdEbTPJqQ@mail.gmail.com>
Message-ID: <340d29d33c1adfd55fe8b1ad48674708@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-11 17:37, Dmitry Vyukov wrote:
> On Mon, Mar 11, 2019 at 5:36 PM syzbot
> <syzbot+@syzkaller.appspotmail.com> wrote:
>> 
>> > On Mon, Mar 11, 2019 at 2:53 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> >> On 2019-03-11 14:45, Dmitry Vyukov wrote:
>> >> > On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> >> >>
>> >> >> Hi Andrew,
>> >> >>
>> >> >> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
>> >> >> removed from your tree, at least I got a notification on 9th of
>> >> >> january,
>> >> >> also I do not see it in the linux-next tree.
>> >> >>
>> >> >> Should I ignore this syzbot message?
>> >> >
>> >> > If this was resolved we need to communicate it to syzbot one way or the
>> >> > other.
>> >> > Since it was in linux-next, it won't even be able to do fix bisection.
>> >> > So the bug will be open forever otherwise.
>> 
>> >> Bug was fixed (commit was simply dropped).  How can I tell syzbot to
>> >> shut up
>> >> and to resolve the issue?
>> 
>> > Hi Roman,
>> 
>> > The docs are at:
>> 
>> >> See https://goo.gl/tpsmEJ for more information about syzbot.

Thanks! Will read.

>> 
>> > There is no official support for bugs fixed not by commit merges.
>> > Linux-next creates various interesting corner-cases for the process.
>> > Let's go with this option for now:
>> 
>> > #syz invalid
>> 
>> I see the command but can't find the corresponding bug.
>> Please resend the email to syzbot+HASH@syzkaller.appspotmail.com 
>> address
>> that is the sender of the bug report (also present in the Reported-by 
>> tag).
> 
> +syzbot email
> 
> Please don't drop bug reporter email from CC.

Did not know. Thanks for your help!

--
Roman



