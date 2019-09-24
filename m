Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49252207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569336992;
	bh=uEg2MpMfUWu9M0mHKITUKsp1fc4wkcYiKYgCZ44bOd8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mK0UihC/5S68S4FV6fFwGB0R3eBXGXnl3t2+DBPtZNKTZYG4Of6bb6o6y4lMOFIil
	 TYXT1wKcYNhnmHLc752UtjRVUSEVfXnibt81I9S6URXk00m/oHeNju7eJMTif6ufv0
	 W3eL9OTZRi0v9zIipgUxE/3F+4474crrUDvpiBXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632793AbfIXO4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfIXO4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:56:31 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75728207FD;
        Tue, 24 Sep 2019 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569336990;
        bh=uEg2MpMfUWu9M0mHKITUKsp1fc4wkcYiKYgCZ44bOd8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L+1uZKzI2EJRs0Rs3hzPVB31wHgYQ1iQhXsYRm2VO9bO++aVpsobPYAlD51D/RR3Q
         lH4leabAHHD1z2Wykqxc35cMRJtRwuTYLPryTJQSTq3vRRSMIPRrucYsLLHhMph8ss
         cTwgQKO46RG5RKE4FVBe3tjC0O1lk+7K57REXcCY=
Date:   Tue, 24 Sep 2019 07:56:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.09.23a 65/77] kernel//rcu/tree.c:2770:3: error:
 implicit declaration of function 'kfree'; did you mean 'kvfree'?
Message-ID: <20190924145626.GA2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <201909241053.itpSv0OR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909241053.itpSv0OR%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 10:21:54AM +0800, kbuild test robot wrote:
> tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.09.23a
> head:   97de53b94582c208ee239178b208b8e8b9472585
> commit: 06b68648e6084488b79de47a2cfa307a1b9668b9 [65/77] rcu: Remove kfree_rcu() special casing and lazy-callback handling
> config: x86_64-randconfig-c004-201938 (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         git checkout 06b68648e6084488b79de47a2cfa307a1b9668b9
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel//rcu/tree.c: In function 'kfree_rcu_work':
> >> kernel//rcu/tree.c:2770:3: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>       kfree((void *)head - offset);
>       ^~~~~
>       kvfree
>    cc1: some warnings being treated as errors

Good catch, missing #include of slab.h, fix posted to be squashed with
the original commit.

							Thanx, Paul

> vim +2770 kernel//rcu/tree.c
> 
>   2739	
>   2740	/*
>   2741	 * This function is invoked in workqueue context after a grace period.
>   2742	 * It frees all the objects queued on ->head_free.
>   2743	 */
>   2744	static void kfree_rcu_work(struct work_struct *work)
>   2745	{
>   2746		unsigned long flags;
>   2747		struct rcu_head *head, *next;
>   2748		struct kfree_rcu_cpu *krcp;
>   2749		struct kfree_rcu_cpu_work *krwp;
>   2750	
>   2751		krwp = container_of(to_rcu_work(work),
>   2752				    struct kfree_rcu_cpu_work, rcu_work);
>   2753		krcp = krwp->krcp;
>   2754		spin_lock_irqsave(&krcp->lock, flags);
>   2755		head = krwp->head_free;
>   2756		krwp->head_free = NULL;
>   2757		spin_unlock_irqrestore(&krcp->lock, flags);
>   2758	
>   2759		// List "head" is now private, so traverse locklessly.
>   2760		for (; head; head = next) {
>   2761			unsigned long offset = (unsigned long)head->func;
>   2762	
>   2763			next = head->next;
>   2764			// Potentially optimize with kfree_bulk in future.
>   2765			debug_rcu_head_unqueue(head);
>   2766			rcu_lock_acquire(&rcu_callback_map);
>   2767			trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
>   2768	
>   2769			/* Could be possible to optimize with kfree_bulk in future */
> > 2770			kfree((void *)head - offset);
>   2771	
>   2772			rcu_lock_release(&rcu_callback_map);
>   2773			cond_resched_tasks_rcu_qs();
>   2774		}
>   2775	}
>   2776	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


