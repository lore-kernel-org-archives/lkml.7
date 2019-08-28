Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C4422CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566990808;
	bh=J6wpvtEGCR/gD5nst0XMLcp4+fk8rqX6ybJoQkdxQWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q33a8iV3F7xB+fERi30IjytAWxXKil4MWkD73BMkxLTroKsYsWKfxEZhWCCjVVjOR
	 1+cr28Wd7pXVe8k6pTdR9HOCVD8RBsSrCIqfCHnCDMDFfJlphofkxbhK/kKrms4Jjv
	 Bff3KErz4iPAZImeL/l7oEQ0nwLBR/M5XZjW6bBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfH1LN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1LN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:13:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B112189D;
        Wed, 28 Aug 2019 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566990805;
        bh=J6wpvtEGCR/gD5nst0XMLcp4+fk8rqX6ybJoQkdxQWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/qx0YWPpnGPmOmiuyOHizlQBzTKHmYlNofQqIpexfo3XFZimBt29M6vXcnyJrDCV
         9+Sg3e4d+WlWB14eFix0eDhfu0vu0Bn4p5epE3uWmCw1uYBw48C/EW7lxP13hsxt62
         LxZ/Vc4AocGshcvvSQx/f2w1y4fMeAW45BtdJ2PQ=
Date:   Wed, 28 Aug 2019 07:13:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/pm: Introduce quirk framework to save/restore extra
 MSR registers around suspend/resume" has been added to the 4.4-stable tree
Message-ID: <20190828111323.GA5281@sasha-vm>
References: <20190828041240.12F5221883@mail.kernel.org>
 <20190828084351.GC29927@kroah.com>
 <20190828090043.GA7589@chenyu-office.sh.intel.com>
 <20190828091155.GA32011@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828091155.GA32011@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:11:55AM +0200, Greg KH wrote:
>On Wed, Aug 28, 2019 at 05:00:44PM +0800, Yu Chen wrote:
>> On Wed, Aug 28, 2019 at 10:43:51AM +0200, Greg KH wrote:
>> > On Wed, Aug 28, 2019 at 12:12:39AM -0400, Sasha Levin wrote:
>> > > This is a note to let you know that I've just added the patch titled
>> > >
>> > >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
>> > >
>> > > to the 4.4-stable tree which can be found at:
>> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>> > >
>> > > The filename of the patch is:
>> > >      x86-pm-introduce-quirk-framework-to-save-restore-ext.patch
>> > > and it can be found in the queue-4.4 subdirectory.
>> > >
>> > > If you, or anyone else, feels it should not be added to the stable tree,
>> > > please let <stable@vger.kernel.org> know about it.
>> > >
>> > >
>> > >
>> > > commit d63273440aa0fdebc30d0c931f15f79beb213134
>> > > Author: Chen Yu <yu.c.chen@intel.com>
>> > > Date:   Wed Nov 25 01:03:41 2015 +0800
>> > >
>> > >     x86/pm: Introduce quirk framework to save/restore extra MSR registers around suspend/resume
>> > >
>> > >     A bug was reported that on certain Broadwell platforms, after
>> > >     resuming from S3, the CPU is running at an anomalously low
>> > >     speed.
>> > >
>> > >     It turns out that the BIOS has modified the value of the
>> > >     THERM_CONTROL register during S3, and changed it from 0 to 0x10,
>> > >     thus enabled clock modulation(bit4), but with undefined CPU Duty
>> > >     Cycle(bit1:3) - which causes the problem.
>> > >
>> > >     Here is a simple scenario to reproduce the issue:
>> > >
>> > >      1. Boot up the system
>> > >      2. Get MSR 0x19a, it should be 0
>> > >      3. Put the system into sleep, then wake it up
>> > >      4. Get MSR 0x19a, it shows 0x10, while it should be 0
>> > >
>> > >     Although some BIOSen want to change the CPU Duty Cycle during
>> > >     S3, in our case we don't want the BIOS to do any modification.
>> > >
>> > >     Fix this issue by introducing a more generic x86 framework to
>> > >     save/restore specified MSR registers(THERM_CONTROL in this case)
>> > >     for suspend/resume. This allows us to fix similar bugs in a much
>> > >     simpler way in the future.
>> > >
>> > >     When the kernel wants to protect certain MSRs during suspending,
>> > >     we simply add a quirk entry in msr_save_dmi_table, and customize
>> > >     the MSR registers inside the quirk callback, for example:
>> > >
>> > >       u32 msr_id_need_to_save[] = {MSR_ID0, MSR_ID1, MSR_ID2...};
>> > >
>> > >     and the quirk mechanism ensures that, once resumed from suspend,
>> > >     the MSRs indicated by these IDs will be restored to their
>> > >     original, pre-suspend values.
>> > >
>> > >     Since both 64-bit and 32-bit kernels are affected, this patch
>> > >     covers the common 64/32-bit suspend/resume code path. And
>> > >     because the MSRs specified by the user might not be available or
>> > >     readable in any situation, we use rdmsrl_safe() to safely save
>> > >     these MSRs.
>> > >
>> > >     Reported-and-tested-by: Marcin Kaszewski <marcin.kaszewski@intel.com>
>> > >     Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>> > >     Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > >     Acked-by: Pavel Machek <pavel@ucw.cz>
>> > >     Cc: Andy Lutomirski <luto@amacapital.net>
>> > >     Cc: Borislav Petkov <bp@alien8.de>
>> > >     Cc: Brian Gerst <brgerst@gmail.com>
>> > >     Cc: Denys Vlasenko <dvlasenk@redhat.com>
>> > >     Cc: H. Peter Anvin <hpa@zytor.com>
>> > >     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> > >     Cc: Peter Zijlstra <peterz@infradead.org>
>> > >     Cc: Thomas Gleixner <tglx@linutronix.de>
>> > >     Cc: bp@suse.de
>> > >     Cc: len.brown@intel.com
>> > >     Cc: linux@horizon.com
>> > >     Cc: luto@kernel.org
>> > >     Cc: rjw@rjwysocki.net
>> > >     Link: http://lkml.kernel.org/r/c9abdcbc173dd2f57e8990e304376f19287e92ba.1448382971.git.yu.c.chen@intel.com
>> > >     [ More edits to the naming of data structures. ]
>> > >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> >
>> > No git id of the patch in Linus's tree, or your signed-off-by?
>> >
>> I think the commit id in Linus'tree should be 7a9c2dd08eadd5c6943115dbbec040c38d2e0822
>
>Ah, and Sasha added it because a later patch needed it :(
>
>Sasha, can you fix this patch's headers up to be in the "proper" format?

Yes, I brought it in as a dependency but cherry picked instead of using
my scripts by mistake. I'll fix up the patch in the queue.

--
Thanks,
Sasha
