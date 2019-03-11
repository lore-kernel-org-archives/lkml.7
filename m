Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5920C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F934206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCKNxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:53:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:53998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfCKNxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:53:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E932AED5;
        Mon, 11 Mar 2019 13:53:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Mar 2019 14:53:13 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in ep_poll_callback
In-Reply-To: <CACT4Y+ZXBhNamhTYVW_9y_yUWRE+=rO8vdBF=m40kjqJQGY-gQ@mail.gmail.com>
References: <0000000000008f34570583d15823@google.com>
 <0ded99b8d69a74c260f3f44f5ae1ab59@suse.de>
 <CACT4Y+ZXBhNamhTYVW_9y_yUWRE+=rO8vdBF=m40kjqJQGY-gQ@mail.gmail.com>
Message-ID: <531016fbc6fee2f1a1c386b0daeba867@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-11 14:45, Dmitry Vyukov wrote:
> On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>> 
>> Hi Andrew,
>> 
>> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
>> removed from your tree, at least I got a notification on 9th of 
>> january,
>> also I do not see it in the linux-next tree.
>> 
>> Should I ignore this syzbot message?
> 
> If this was resolved we need to communicate it to syzbot one way or the 
> other.
> Since it was in linux-next, it won't even be able to do fix bisection.
> So the bug will be open forever otherwise.

Bug was fixed (commit was simply dropped).  How can I tell syzbot to 
shut up
and to resolve the issue?

--
Roman

