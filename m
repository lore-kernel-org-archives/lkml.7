Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0458CC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE261208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578417831;
	bh=6ejjEbhZVVTCrBIGpJiOJTr5rrP5vJ9tZ4mKHdvPvbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ye+ra6IKaRjn87qWdvxKxzPMVI0Si7oLrIjZNLhkc8Btj7AH1uAVjrCtV3El8neY
	 HQNeo/oylepe83GnRvx2whw+oDcUpwX9EwWT7VA4/idIrRvTMntIYpom7t/bunA9Af
	 KLLwlyblJHdamelDx4U377ONTRU0DcigUSC1ZOPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgAGRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgAGRXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:23:50 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78832087F;
        Tue,  7 Jan 2020 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578417830;
        bh=6ejjEbhZVVTCrBIGpJiOJTr5rrP5vJ9tZ4mKHdvPvbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wn1VsF5Rx3mQIDQVw5s/nm1MAp29PvSvvRX5jDldxMkYn4wy53D0c/smVmVylH8w4
         9PidrFa7C4ASqZ9vcaMSJan/zpxM3xXoMIXBZf47TZ6/Nu1mIJvoQAkcRy0vumrQCO
         xPtcQ2Sf3o/ruUQf8pvU3jIaKTn8bfR0dEXktSLg=
Date:   Tue, 7 Jan 2020 17:23:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Message-ID: <20200107172343.GA32009@willie-the-truck>
References: <20191223022532.14864-1-longman@redhat.com>
 <20200107125824.GA2844@hirez.programming.kicks-ass.net>
 <20200107130939.GV2871@hirez.programming.kicks-ass.net>
 <64bac471-11c6-41b7-c647-fa2c70b1bc32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64bac471-11c6-41b7-c647-fa2c70b1bc32@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:14:20AM -0500, Waiman Long wrote:
> On 1/7/20 8:09 AM, Peter Zijlstra wrote:
> > On Tue, Jan 07, 2020 at 01:58:24PM +0100, Peter Zijlstra wrote:
> >> On Sun, Dec 22, 2019 at 09:25:32PM -0500, Waiman Long wrote:
> >>> It turns out that the URL of the MCS lock paper listed in the source
> >>> code is no longer accessible. I did got question about where the paper
> >>> was. This patch updates the URL to one that is still accessible.
> >>>
> >>> Signed-off-by: Waiman Long <longman@redhat.com>
> >>> ---
> >>>  kernel/locking/qspinlock.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> >>> index 2473f10c6956..1d008d2333c0 100644
> >>> --- a/kernel/locking/qspinlock.c
> >>> +++ b/kernel/locking/qspinlock.c
> >>> @@ -34,7 +34,7 @@
> >>>   * MCS lock. The paper below provides a good description for this kind
> >>>   * of lock.
> >>>   *
> >>> - * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
> >>> + * https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
> >> Do we want to stick a copy of the paper in our bugzilla and link that
> >> instead? ISTR we do something similar elsewhere, but I'm having trouble
> >> finding it.
> >>
> >> Thomas, Konstantin?
> > Boris provided an example from commit:
> >
> >   018ebca8bd70 ("x86/cpufeatures: Enable a new AVX512 CPU feature")
> >
> > That puts a copy of the relevant Intel document here:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=204215
> >
> OK, that sounds good. I will put a copy of the paper in the BZ and
> linked it there.

Thanks. When you update the link in the comment, please can you also include
the title of the paper. i.e.

  The paper below ("Algorithms for Scalable Synchronization on Shared-Memory
  Multiprocessors by Mellor-Crummey and Scott") ...

That makes the thing a lot more searchable in case bugzilla is getting DoS'd
or whatnot.

Will
