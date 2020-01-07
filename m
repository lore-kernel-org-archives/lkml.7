Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57946C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0C6222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578418490;
	bh=mYOnDccLJOpjVPcS+X/VPzoBs3Qeivek+7YeFnBVqz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QiY8XVm9yhztYSU7k3vPAOaH4EaPAqaRLJz6qES/3GnMSEERodY/6zlPI1Bx3TJQV
	 CTbqcXyfSrZEpUSMQLVszfKOg+U5Qf6hBUl04d7p9VGHGvqcV4QNYw1tNOtwNj2f4e
	 YWAQD9csNRA3pXHdCniOHisPWZV9ScSkgzqKamE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgAGRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:34:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgAGRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:34:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22ED6208C4;
        Tue,  7 Jan 2020 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578418488;
        bh=mYOnDccLJOpjVPcS+X/VPzoBs3Qeivek+7YeFnBVqz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAPDps5pzi7g1eWJYBnFAZEV92ChvLING+8qKDeAsM9pQfj2b4uN51+L+hLamPNdu
         NrfaW2BB9rjFYdBSfNgudGwq5LRmL7KAQZk/FHVvV644/uxWAMk3OkI1FkxUvZuCyL
         B8Vw0b1PVRHNtBJi1XSi+LxNqIjODrNIQnOIo2q8=
Date:   Tue, 7 Jan 2020 17:34:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v2] locking/qspinlock: Fix inaccessible URL of MCS lock
 paper
Message-ID: <20200107173443.GB32009@willie-the-truck>
References: <20200107151619.20802-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107151619.20802-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:16:19AM -0500, Waiman Long wrote:
> It turns out that the URL of the MCS lock paper listed in the source
> code is no longer accessible. I did got question about where the paper
> was. This patch updates the URL to BZ 206115 which contains a copy of
> the paper from
> 
>   https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10c6956..ce75b2270b58 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -31,10 +31,9 @@
>  /*
>   * The basic principle of a queue-based spinlock can best be understood
>   * by studying a classic queue-based spinlock implementation called the
> - * MCS lock. The paper below provides a good description for this kind
> - * of lock.
> + * MCS lock. A copy of the original MCS lock papaer is available at

s/papaer/paper/

I think I reviewed the previous patch as you sent this version, but please
could you reword as suggested here [1]?

Cheers,

Will

[1] https://lore.kernel.org/lkml/20200107172343.GA32009@willie-the-truck/T/#m0f9eaf53e509b87d0f6378e35514c9b120d8edc2
