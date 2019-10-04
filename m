Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D14C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E7E222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfJDWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:04:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:24948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfJDWEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:04:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 15:04:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="gz'50?scan'50,208,50";a="196801168"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2019 15:04:06 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iGVgD-0006it-DH; Sat, 05 Oct 2019 06:04:05 +0800
Date:   Sat, 5 Oct 2019 06:03:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>, bristot@redhat.com,
        peterz@infradead.org, oleg@redhat.com, paulmck@kernel.org,
        rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Remove GP_REPLAY state from rcu_sync
Message-ID: <201910050611.qrP2IiKk%lkp@intel.com>
References: <20191004145741.118292-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ouajsniki7vwer4d"
Content-Disposition: inline
In-Reply-To: <20191004145741.118292-1-joel@joelfernandes.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ouajsniki7vwer4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Joel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rcu/dev]
[cannot apply to v5.4-rc1 next-20191004]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/Remove-GP_REPLAY-state-from-rcu_sync/20191005-024257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
config: x86_64-randconfig-b002-201939 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/export.h:44:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/rcu_sync.h:13,
                    from kernel//rcu/sync.c:10:
   kernel//rcu/sync.c: In function 'rcu_sync_dtor':
   kernel//rcu/sync.c:187:23: error: 'GP_REPLAY' undeclared (first use in this function)
     if (rsp->gp_state == GP_REPLAY)
                          ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel//rcu/sync.c:187:2: note: in expansion of macro 'if'
     if (rsp->gp_state == GP_REPLAY)
     ^~
   kernel//rcu/sync.c:187:23: note: each undeclared identifier is reported only once for each function it appears in
     if (rsp->gp_state == GP_REPLAY)
                          ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> kernel//rcu/sync.c:187:2: note: in expansion of macro 'if'
     if (rsp->gp_state == GP_REPLAY)
     ^~

vim +/if +187 kernel//rcu/sync.c

cc44ca848f5e51 Oleg Nesterov    2015-08-21  @10  #include <linux/rcu_sync.h>
cc44ca848f5e51 Oleg Nesterov    2015-08-21   11  #include <linux/sched.h>
cc44ca848f5e51 Oleg Nesterov    2015-08-21   12  
6d1a4c2dfe7bb0 Joel Fernandes   2019-10-04   13  enum { GP_IDLE = 0, GP_ENTER, GP_PASSED, GP_EXIT };
cc44ca848f5e51 Oleg Nesterov    2015-08-21   14  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   15  #define	rss_lock	gp_wait.lock
cc44ca848f5e51 Oleg Nesterov    2015-08-21   16  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   17  /**
cc44ca848f5e51 Oleg Nesterov    2015-08-21   18   * rcu_sync_init() - Initialize an rcu_sync structure
cc44ca848f5e51 Oleg Nesterov    2015-08-21   19   * @rsp: Pointer to rcu_sync structure to be initialized
cc44ca848f5e51 Oleg Nesterov    2015-08-21   20   */
95bf33b55ff446 Oleg Nesterov    2019-04-23   21  void rcu_sync_init(struct rcu_sync *rsp)
cc44ca848f5e51 Oleg Nesterov    2015-08-21   22  {
cc44ca848f5e51 Oleg Nesterov    2015-08-21   23  	memset(rsp, 0, sizeof(*rsp));
cc44ca848f5e51 Oleg Nesterov    2015-08-21   24  	init_waitqueue_head(&rsp->gp_wait);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   25  }
cc44ca848f5e51 Oleg Nesterov    2015-08-21   26  
3942a9bd7b5842 Peter Zijlstra   2016-08-11   27  /**
27fdb35fe99011 Paul E. McKenney 2017-10-19   28   * rcu_sync_enter_start - Force readers onto slow path for multiple updates
27fdb35fe99011 Paul E. McKenney 2017-10-19   29   * @rsp: Pointer to rcu_sync structure to use for synchronization
27fdb35fe99011 Paul E. McKenney 2017-10-19   30   *
3942a9bd7b5842 Peter Zijlstra   2016-08-11   31   * Must be called after rcu_sync_init() and before first use.
3942a9bd7b5842 Peter Zijlstra   2016-08-11   32   *
3942a9bd7b5842 Peter Zijlstra   2016-08-11   33   * Ensures rcu_sync_is_idle() returns false and rcu_sync_{enter,exit}()
3942a9bd7b5842 Peter Zijlstra   2016-08-11   34   * pairs turn into NO-OPs.
3942a9bd7b5842 Peter Zijlstra   2016-08-11   35   */
3942a9bd7b5842 Peter Zijlstra   2016-08-11   36  void rcu_sync_enter_start(struct rcu_sync *rsp)
3942a9bd7b5842 Peter Zijlstra   2016-08-11   37  {
3942a9bd7b5842 Peter Zijlstra   2016-08-11   38  	rsp->gp_count++;
3942a9bd7b5842 Peter Zijlstra   2016-08-11   39  	rsp->gp_state = GP_PASSED;
3942a9bd7b5842 Peter Zijlstra   2016-08-11   40  }
3942a9bd7b5842 Peter Zijlstra   2016-08-11   41  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   42  
89da3b94bb9741 Oleg Nesterov    2019-04-25   43  static void rcu_sync_func(struct rcu_head *rhp);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   44  
89da3b94bb9741 Oleg Nesterov    2019-04-25   45  static void rcu_sync_call(struct rcu_sync *rsp)
89da3b94bb9741 Oleg Nesterov    2019-04-25   46  {
89da3b94bb9741 Oleg Nesterov    2019-04-25   47  	call_rcu(&rsp->cb_head, rcu_sync_func);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   48  }
cc44ca848f5e51 Oleg Nesterov    2015-08-21   49  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   50  /**
cc44ca848f5e51 Oleg Nesterov    2015-08-21   51   * rcu_sync_func() - Callback function managing reader access to fastpath
27fdb35fe99011 Paul E. McKenney 2017-10-19   52   * @rhp: Pointer to rcu_head in rcu_sync structure to use for synchronization
cc44ca848f5e51 Oleg Nesterov    2015-08-21   53   *
89da3b94bb9741 Oleg Nesterov    2019-04-25   54   * This function is passed to call_rcu() function by rcu_sync_enter() and
cc44ca848f5e51 Oleg Nesterov    2015-08-21   55   * rcu_sync_exit(), so that it is invoked after a grace period following the
89da3b94bb9741 Oleg Nesterov    2019-04-25   56   * that invocation of enter/exit.
89da3b94bb9741 Oleg Nesterov    2019-04-25   57   *
89da3b94bb9741 Oleg Nesterov    2019-04-25   58   * If it is called by rcu_sync_enter() it signals that all the readers were
89da3b94bb9741 Oleg Nesterov    2019-04-25   59   * switched onto slow path.
89da3b94bb9741 Oleg Nesterov    2019-04-25   60   *
89da3b94bb9741 Oleg Nesterov    2019-04-25   61   * If it is called by rcu_sync_exit() it takes action based on events that
cc44ca848f5e51 Oleg Nesterov    2015-08-21   62   * have taken place in the meantime, so that closely spaced rcu_sync_enter()
cc44ca848f5e51 Oleg Nesterov    2015-08-21   63   * and rcu_sync_exit() pairs need not wait for a grace period.
cc44ca848f5e51 Oleg Nesterov    2015-08-21   64   *
cc44ca848f5e51 Oleg Nesterov    2015-08-21   65   * If another rcu_sync_enter() is invoked before the grace period
cc44ca848f5e51 Oleg Nesterov    2015-08-21   66   * ended, reset state to allow the next rcu_sync_exit() to let the
cc44ca848f5e51 Oleg Nesterov    2015-08-21   67   * readers back onto their fastpaths (after a grace period).  If both
cc44ca848f5e51 Oleg Nesterov    2015-08-21   68   * another rcu_sync_enter() and its matching rcu_sync_exit() are invoked
cc44ca848f5e51 Oleg Nesterov    2015-08-21   69   * before the grace period ended, re-invoke call_rcu() on behalf of that
cc44ca848f5e51 Oleg Nesterov    2015-08-21   70   * rcu_sync_exit().  Otherwise, set all state back to idle so that readers
cc44ca848f5e51 Oleg Nesterov    2015-08-21   71   * can again use their fastpaths.
cc44ca848f5e51 Oleg Nesterov    2015-08-21   72   */
27fdb35fe99011 Paul E. McKenney 2017-10-19   73  static void rcu_sync_func(struct rcu_head *rhp)
cc44ca848f5e51 Oleg Nesterov    2015-08-21   74  {
27fdb35fe99011 Paul E. McKenney 2017-10-19   75  	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   76  	unsigned long flags;
cc44ca848f5e51 Oleg Nesterov    2015-08-21   77  
89da3b94bb9741 Oleg Nesterov    2019-04-25   78  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
89da3b94bb9741 Oleg Nesterov    2019-04-25   79  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   80  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   81  	spin_lock_irqsave(&rsp->rss_lock, flags);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   82  	if (rsp->gp_count) {
cc44ca848f5e51 Oleg Nesterov    2015-08-21   83  		/*
89da3b94bb9741 Oleg Nesterov    2019-04-25   84  		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
cc44ca848f5e51 Oleg Nesterov    2015-08-21   85  		 */
89da3b94bb9741 Oleg Nesterov    2019-04-25   86  		WRITE_ONCE(rsp->gp_state, GP_PASSED);
89da3b94bb9741 Oleg Nesterov    2019-04-25   87  		wake_up_locked(&rsp->gp_wait);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   88  	} else {
cc44ca848f5e51 Oleg Nesterov    2015-08-21   89  		/*
89da3b94bb9741 Oleg Nesterov    2019-04-25   90  		 * We're at least a GP after the last rcu_sync_exit(); eveybody
89da3b94bb9741 Oleg Nesterov    2019-04-25   91  		 * will now have observed the write side critical section.
89da3b94bb9741 Oleg Nesterov    2019-04-25   92  		 * Let 'em rip!.
cc44ca848f5e51 Oleg Nesterov    2015-08-21   93  		 */
89da3b94bb9741 Oleg Nesterov    2019-04-25   94  		WRITE_ONCE(rsp->gp_state, GP_IDLE);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   95  	}
cc44ca848f5e51 Oleg Nesterov    2015-08-21   96  	spin_unlock_irqrestore(&rsp->rss_lock, flags);
cc44ca848f5e51 Oleg Nesterov    2015-08-21   97  }
cc44ca848f5e51 Oleg Nesterov    2015-08-21   98  
cc44ca848f5e51 Oleg Nesterov    2015-08-21   99  /**
89da3b94bb9741 Oleg Nesterov    2019-04-25  100   * rcu_sync_enter() - Force readers onto slowpath
89da3b94bb9741 Oleg Nesterov    2019-04-25  101   * @rsp: Pointer to rcu_sync structure to use for synchronization
89da3b94bb9741 Oleg Nesterov    2019-04-25  102   *
89da3b94bb9741 Oleg Nesterov    2019-04-25  103   * This function is used by updaters who need readers to make use of
89da3b94bb9741 Oleg Nesterov    2019-04-25  104   * a slowpath during the update.  After this function returns, all
89da3b94bb9741 Oleg Nesterov    2019-04-25  105   * subsequent calls to rcu_sync_is_idle() will return false, which
89da3b94bb9741 Oleg Nesterov    2019-04-25  106   * tells readers to stay off their fastpaths.  A later call to
89da3b94bb9741 Oleg Nesterov    2019-04-25  107   * rcu_sync_exit() re-enables reader slowpaths.
89da3b94bb9741 Oleg Nesterov    2019-04-25  108   *
89da3b94bb9741 Oleg Nesterov    2019-04-25  109   * When called in isolation, rcu_sync_enter() must wait for a grace
89da3b94bb9741 Oleg Nesterov    2019-04-25  110   * period, however, closely spaced calls to rcu_sync_enter() can
89da3b94bb9741 Oleg Nesterov    2019-04-25  111   * optimize away the grace-period wait via a state machine implemented
89da3b94bb9741 Oleg Nesterov    2019-04-25  112   * by rcu_sync_enter(), rcu_sync_exit(), and rcu_sync_func().
89da3b94bb9741 Oleg Nesterov    2019-04-25  113   */
89da3b94bb9741 Oleg Nesterov    2019-04-25  114  void rcu_sync_enter(struct rcu_sync *rsp)
89da3b94bb9741 Oleg Nesterov    2019-04-25  115  {
89da3b94bb9741 Oleg Nesterov    2019-04-25  116  	int gp_state;
89da3b94bb9741 Oleg Nesterov    2019-04-25  117  
89da3b94bb9741 Oleg Nesterov    2019-04-25  118  	spin_lock_irq(&rsp->rss_lock);
89da3b94bb9741 Oleg Nesterov    2019-04-25  119  	gp_state = rsp->gp_state;
89da3b94bb9741 Oleg Nesterov    2019-04-25  120  	if (gp_state == GP_IDLE) {
89da3b94bb9741 Oleg Nesterov    2019-04-25  121  		WRITE_ONCE(rsp->gp_state, GP_ENTER);
89da3b94bb9741 Oleg Nesterov    2019-04-25  122  		WARN_ON_ONCE(rsp->gp_count);
89da3b94bb9741 Oleg Nesterov    2019-04-25  123  		/*
89da3b94bb9741 Oleg Nesterov    2019-04-25  124  		 * Note that we could simply do rcu_sync_call(rsp) here and
89da3b94bb9741 Oleg Nesterov    2019-04-25  125  		 * avoid the "if (gp_state == GP_IDLE)" block below.
89da3b94bb9741 Oleg Nesterov    2019-04-25  126  		 *
89da3b94bb9741 Oleg Nesterov    2019-04-25  127  		 * However, synchronize_rcu() can be faster if rcu_expedited
89da3b94bb9741 Oleg Nesterov    2019-04-25  128  		 * or rcu_blocking_is_gp() is true.
89da3b94bb9741 Oleg Nesterov    2019-04-25  129  		 *
89da3b94bb9741 Oleg Nesterov    2019-04-25  130  		 * Another reason is that we can't wait for rcu callback if
89da3b94bb9741 Oleg Nesterov    2019-04-25  131  		 * we are called at early boot time but this shouldn't happen.
89da3b94bb9741 Oleg Nesterov    2019-04-25  132  		 */
89da3b94bb9741 Oleg Nesterov    2019-04-25  133  	}
89da3b94bb9741 Oleg Nesterov    2019-04-25  134  	rsp->gp_count++;
89da3b94bb9741 Oleg Nesterov    2019-04-25  135  	spin_unlock_irq(&rsp->rss_lock);
89da3b94bb9741 Oleg Nesterov    2019-04-25  136  
89da3b94bb9741 Oleg Nesterov    2019-04-25  137  	if (gp_state == GP_IDLE) {
89da3b94bb9741 Oleg Nesterov    2019-04-25  138  		/*
89da3b94bb9741 Oleg Nesterov    2019-04-25  139  		 * See the comment above, this simply does the "synchronous"
89da3b94bb9741 Oleg Nesterov    2019-04-25  140  		 * call_rcu(rcu_sync_func) which does GP_ENTER -> GP_PASSED.
89da3b94bb9741 Oleg Nesterov    2019-04-25  141  		 */
89da3b94bb9741 Oleg Nesterov    2019-04-25  142  		synchronize_rcu();
89da3b94bb9741 Oleg Nesterov    2019-04-25  143  		rcu_sync_func(&rsp->cb_head);
89da3b94bb9741 Oleg Nesterov    2019-04-25  144  		/* Not really needed, wait_event() would see GP_PASSED. */
89da3b94bb9741 Oleg Nesterov    2019-04-25  145  		return;
89da3b94bb9741 Oleg Nesterov    2019-04-25  146  	}
89da3b94bb9741 Oleg Nesterov    2019-04-25  147  
89da3b94bb9741 Oleg Nesterov    2019-04-25  148  	wait_event(rsp->gp_wait, READ_ONCE(rsp->gp_state) >= GP_PASSED);
89da3b94bb9741 Oleg Nesterov    2019-04-25  149  }
89da3b94bb9741 Oleg Nesterov    2019-04-25  150  
89da3b94bb9741 Oleg Nesterov    2019-04-25  151  /**
89da3b94bb9741 Oleg Nesterov    2019-04-25  152   * rcu_sync_exit() - Allow readers back onto fast path after grace period
cc44ca848f5e51 Oleg Nesterov    2015-08-21  153   * @rsp: Pointer to rcu_sync structure to use for synchronization
cc44ca848f5e51 Oleg Nesterov    2015-08-21  154   *
cc44ca848f5e51 Oleg Nesterov    2015-08-21  155   * This function is used by updaters who have completed, and can therefore
cc44ca848f5e51 Oleg Nesterov    2015-08-21  156   * now allow readers to make use of their fastpaths after a grace period
cc44ca848f5e51 Oleg Nesterov    2015-08-21  157   * has elapsed.  After this grace period has completed, all subsequent
cc44ca848f5e51 Oleg Nesterov    2015-08-21  158   * calls to rcu_sync_is_idle() will return true, which tells readers that
cc44ca848f5e51 Oleg Nesterov    2015-08-21  159   * they can once again use their fastpaths.
cc44ca848f5e51 Oleg Nesterov    2015-08-21  160   */
cc44ca848f5e51 Oleg Nesterov    2015-08-21  161  void rcu_sync_exit(struct rcu_sync *rsp)
cc44ca848f5e51 Oleg Nesterov    2015-08-21  162  {
6d1a4c2dfe7bb0 Joel Fernandes   2019-10-04  163  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) < GP_PASSED);
89da3b94bb9741 Oleg Nesterov    2019-04-25  164  
cc44ca848f5e51 Oleg Nesterov    2015-08-21  165  	spin_lock_irq(&rsp->rss_lock);
cc44ca848f5e51 Oleg Nesterov    2015-08-21  166  	if (!--rsp->gp_count) {
89da3b94bb9741 Oleg Nesterov    2019-04-25  167  		if (rsp->gp_state == GP_PASSED) {
89da3b94bb9741 Oleg Nesterov    2019-04-25  168  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
89da3b94bb9741 Oleg Nesterov    2019-04-25  169  			rcu_sync_call(rsp);
cc44ca848f5e51 Oleg Nesterov    2015-08-21  170  		}
cc44ca848f5e51 Oleg Nesterov    2015-08-21  171  	}
cc44ca848f5e51 Oleg Nesterov    2015-08-21  172  	spin_unlock_irq(&rsp->rss_lock);
cc44ca848f5e51 Oleg Nesterov    2015-08-21  173  }
07899a6e5f5613 Oleg Nesterov    2015-08-21  174  
07899a6e5f5613 Oleg Nesterov    2015-08-21  175  /**
07899a6e5f5613 Oleg Nesterov    2015-08-21  176   * rcu_sync_dtor() - Clean up an rcu_sync structure
07899a6e5f5613 Oleg Nesterov    2015-08-21  177   * @rsp: Pointer to rcu_sync structure to be cleaned up
07899a6e5f5613 Oleg Nesterov    2015-08-21  178   */
07899a6e5f5613 Oleg Nesterov    2015-08-21  179  void rcu_sync_dtor(struct rcu_sync *rsp)
07899a6e5f5613 Oleg Nesterov    2015-08-21  180  {
89da3b94bb9741 Oleg Nesterov    2019-04-25  181  	int gp_state;
07899a6e5f5613 Oleg Nesterov    2015-08-21  182  
89da3b94bb9741 Oleg Nesterov    2019-04-25  183  	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
89da3b94bb9741 Oleg Nesterov    2019-04-25  184  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
07899a6e5f5613 Oleg Nesterov    2015-08-21  185  
07899a6e5f5613 Oleg Nesterov    2015-08-21  186  	spin_lock_irq(&rsp->rss_lock);
89da3b94bb9741 Oleg Nesterov    2019-04-25 @187  	if (rsp->gp_state == GP_REPLAY)

:::::: The code at line 187 was first introduced by commit
:::::: 89da3b94bb97417ca2c5b0ce3a28643819030247 rcu/sync: Simplify the state machine

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Paul E. McKenney <paulmck@linux.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ouajsniki7vwer4d
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
oRjZAQA=

--ouajsniki7vwer4d--
