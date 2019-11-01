Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389BACA9ECE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DAF208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572594822;
	bh=CPlEGTzO4qzAkLTSV68qICfrcOZ/+KY7NfgW8B0WheY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pfcU//wWsvQj9EJnKEOVdRd7bL5F74I84Np2ljuO5ivyXh1jeIkRZ6cPXjovt5D2m
	 PGTmxRL5wpsLXse61zDyhRh0Aq2QIjFosKYK3nr2uyMlSuw79WOA6214lvYRg4oiPK
	 7CGOWiNO5Gk70RqnhUh3jy8Dujqw0rnCzmaD8Xn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfKAHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfKAHxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:53:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF17F2080F;
        Fri,  1 Nov 2019 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572594818;
        bh=CPlEGTzO4qzAkLTSV68qICfrcOZ/+KY7NfgW8B0WheY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AkVabCPheNRUmivJYb5KlC26igTLId46H+6OM2BoBiYdjRKOBI1PyhuJ2xerMEmXU
         552epbS+n2f8zhmOJQSsEz6xWJxZOGdYuVLObGD4mC7sEPMJ+dae9EwgezsImZSOma
         VUf0Z8FMD1AOuj9v/cKtYpeDTBFlg1ZFZEgv9OT8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 86C6A35207E6; Fri,  1 Nov 2019 00:53:38 -0700 (PDT)
Date:   Fri, 1 Nov 2019 00:53:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     Phong Tran <tranmanphong@gmail.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Doc: convert whatisRCU.txt to rst
Message-ID: <20191101075338.GI20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191030233128.14997-1-tranmanphong@gmail.com>
 <20191031225439.GD20975@paulmck-ThinkPad-P72>
 <CAF65HP2yZkxjrqY+Jk9GYobo4NA3ePkrNcu3bZRCVZ8sxSUVrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF65HP2yZkxjrqY+Jk9GYobo4NA3ePkrNcu3bZRCVZ8sxSUVrA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:03:57AM +0530, Madhuparna Bhowmik wrote:
> On Fri, 1 Nov, 2019, 4:24 AM Paul E. McKenney, <paulmck@kernel.org> wrote:
> 
> > On Thu, Oct 31, 2019 at 06:31:28AM +0700, Phong Tran wrote:
> > > Sync the format with current state of kernel documentation.
> > > This change base on rcu-dev branch
> > > what changed:
> > > - Format bullet lists
> > > - Add literal blocks
> > >
> > > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> >
> > Queued and pushed with updated subject line and commit log, thank you!
> >
> > Could you and Madhuparna please review and test each other's
> > .rst-conversion patches?
> >
> 
> Sure, I will do it.

Thank you, Madhuparna!

							Thanx, Paul

> Regards
> Madhuparna
> 
> 
> >                                                         Thanx, Paul
> >
> > > ---
> > >  Documentation/RCU/index.rst                   |   1 +
> > >  .../RCU/{whatisRCU.txt => whatisRCU.rst}      | 150 +++++++++++-------
> > >  2 files changed, 90 insertions(+), 61 deletions(-)
> > >  rename Documentation/RCU/{whatisRCU.txt => whatisRCU.rst} (91%)
> > >
> > > diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> > > index 627128c230dc..b9b11481c727 100644
> > > --- a/Documentation/RCU/index.rst
> > > +++ b/Documentation/RCU/index.rst
> > > @@ -8,6 +8,7 @@ RCU concepts
> > >     :maxdepth: 3
> > >
> > >     arrayRCU
> > > +   whatisRCU
> > >     rcu
> > >     listRCU
> > >     NMI-RCU
> > > diff --git a/Documentation/RCU/whatisRCU.txt
> > b/Documentation/RCU/whatisRCU.rst
> > > similarity index 91%
> > > rename from Documentation/RCU/whatisRCU.txt
> > > rename to Documentation/RCU/whatisRCU.rst
> > > index 58ba05c4d97f..70d0e4c21917 100644
> > > --- a/Documentation/RCU/whatisRCU.txt
> > > +++ b/Documentation/RCU/whatisRCU.rst
> > > @@ -1,15 +1,18 @@
> > > +.. _rcu_doc:
> > > +
> > >  What is RCU?  --  "Read, Copy, Update"
> > > +======================================
> > >
> > >  Please note that the "What is RCU?" LWN series is an excellent place
> > >  to start learning about RCU:
> > >
> > > -1.   What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
> > > -2.   What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
> > > -3.   RCU part 3: the RCU API      http://lwn.net/Articles/264090/
> > > -4.   The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
> > > -     2010 Big API Table           http://lwn.net/Articles/419086/
> > > -5.   The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
> > > -     2014 Big API Table           http://lwn.net/Articles/609973/
> > > +| 1. What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
> > > +| 2. What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
> > > +| 3. RCU part 3: the RCU API      http://lwn.net/Articles/264090/
> > > +| 4. The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
> > > +|    2010 Big API Table           http://lwn.net/Articles/419086/
> > > +| 5. The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
> > > +|    2014 Big API Table           http://lwn.net/Articles/609973/
> > >
> > >
> > >  What is RCU?
> > > @@ -51,6 +54,7 @@ never need this document anyway.  ;-)
> > >
> > >
> > >  1.  RCU OVERVIEW
> > > +----------------
> > >
> > >  The basic idea behind RCU is to split updates into "removal" and
> > >  "reclamation" phases.  The removal phase removes references to data
> > items
> > > @@ -118,6 +122,7 @@ Read on to learn about how RCU's API makes this easy.
> > >
> > >
> > >  2.  WHAT IS RCU'S CORE API?
> > > +---------------------------
> > >
> > >  The core RCU API is quite small:
> > >
> > > @@ -166,7 +171,7 @@ synchronize_rcu()
> > >       read-side critical sections on all CPUs have completed.
> > >       Note that synchronize_rcu() will -not- necessarily wait for
> > >       any subsequent RCU read-side critical sections to complete.
> > > -     For example, consider the following sequence of events:
> > > +     For example, consider the following sequence of events::
> > >
> > >                CPU 0                  CPU 1                 CPU 2
> > >            ----------------- ------------------------- ---------------
> > > @@ -248,13 +253,13 @@ rcu_dereference()
> > >
> > >       Common coding practice uses rcu_dereference() to copy an
> > >       RCU-protected pointer to a local variable, then dereferences
> > > -     this local variable, for example as follows:
> > > +     this local variable, for example as follows::
> > >
> > >               p = rcu_dereference(head.next);
> > >               return p->data;
> > >
> > >       However, in this case, one could just as easily combine these
> > > -     into one statement:
> > > +     into one statement::
> > >
> > >               return rcu_dereference(head.next)->data;
> > >
> > > @@ -267,7 +272,7 @@ rcu_dereference()
> > >
> > >       Note that the value returned by rcu_dereference() is valid
> > >       only within the enclosing RCU read-side critical section [1].
> > > -     For example, the following is -not- legal:
> > > +     For example, the following is -not- legal::
> > >
> > >               rcu_read_lock();
> > >               p = rcu_dereference(head.next);
> > > @@ -315,6 +320,7 @@ rcu_dereference()
> > >
> > >  The following diagram shows how each API communicates among the
> > >  reader, updater, and reclaimer.
> > > +::
> > >
> > >
> > >           rcu_assign_pointer()
> > > @@ -377,10 +383,12 @@ for specialized uses, but are relatively uncommon.
> > >
> > >
> > >  3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
> > > +-----------------------------------------------
> > >
> > >  This section shows a simple use of the core RCU API to protect a
> > >  global pointer to a dynamically allocated structure.  More-typical
> > >  uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
> > > +::
> > >
> > >       struct foo {
> > >               int a;
> > > @@ -467,13 +475,14 @@ arrayRCU.txt, and NMI-RCU.txt.
> > >
> > >
> > >  4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
> > > +--------------------------------------------
> > >
> > >  In the example above, foo_update_a() blocks until a grace period
> > elapses.
> > >  This is quite simple, but in some cases one cannot afford to wait so
> > >  long -- there might be other high-priority work to be done.
> > >
> > >  In such cases, one uses call_rcu() rather than synchronize_rcu().
> > > -The call_rcu() API is as follows:
> > > +The call_rcu() API is as follows::
> > >
> > >       void call_rcu(struct rcu_head * head,
> > >                     void (*func)(struct rcu_head *head));
> > > @@ -481,7 +490,7 @@ The call_rcu() API is as follows:
> > >  This function invokes func(head) after a grace period has elapsed.
> > >  This invocation might happen from either softirq or process context,
> > >  so the function is not permitted to block.  The foo struct needs to
> > > -have an rcu_head structure added, perhaps as follows:
> > > +have an rcu_head structure added, perhaps as follows::
> > >
> > >       struct foo {
> > >               int a;
> > > @@ -490,7 +499,7 @@ have an rcu_head structure added, perhaps as follows:
> > >               struct rcu_head rcu;
> > >       };
> > >
> > > -The foo_update_a() function might then be written as follows:
> > > +The foo_update_a() function might then be written as follows::
> > >
> > >       /*
> > >        * Create a new struct foo that is the same as the one currently
> > > @@ -520,7 +529,7 @@ The foo_update_a() function might then be written as
> > follows:
> > >               call_rcu(&old_fp->rcu, foo_reclaim);
> > >       }
> > >
> > > -The foo_reclaim() function might appear as follows:
> > > +The foo_reclaim() function might appear as follows::
> > >
> > >       void foo_reclaim(struct rcu_head *rp)
> > >       {
> > > @@ -552,7 +561,7 @@ o Use call_rcu() -after- removing a data element
> > from an
> > >
> > >  If the callback for call_rcu() is not doing anything more than calling
> > >  kfree() on the structure, you can use kfree_rcu() instead of call_rcu()
> > > -to avoid having to write your own callback:
> > > +to avoid having to write your own callback::
> > >
> > >       kfree_rcu(old_fp, rcu);
> > >
> > > @@ -560,6 +569,7 @@ Again, see checklist.txt for additional rules
> > governing the use of RCU.
> > >
> > >
> > >  5.  WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
> > > +------------------------------------------------
> > >
> > >  One of the nice things about RCU is that it has extremely simple "toy"
> > >  implementations that are a good first step towards understanding the
> > > @@ -591,7 +601,7 @@ you allow nested rcu_read_lock() calls, you can
> > deadlock.
> > >  However, it is probably the easiest implementation to relate to, so is
> > >  a good starting point.
> > >
> > > -It is extremely simple:
> > > +It is extremely simple::
> > >
> > >       static DEFINE_RWLOCK(rcu_gp_mutex);
> > >
> > > @@ -614,7 +624,7 @@ It is extremely simple:
> > >
> > >  [You can ignore rcu_assign_pointer() and rcu_dereference() without
> > missing
> > >  much.  But here are simplified versions anyway.  And whatever you do,
> > > -don't forget about them when submitting patches making use of RCU!]
> > > +don't forget about them when submitting patches making use of RCU!]::
> > >
> > >       #define rcu_assign_pointer(p, v) \
> > >       ({ \
> > > @@ -659,6 +669,7 @@ This section presents a "toy" RCU implementation
> > that is based on
> > >  on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
> > >  kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
> > >  are the same as those shown in the preceding section, so they are
> > omitted.
> > > +::
> > >
> > >       void rcu_read_lock(void) { }
> > >
> > > @@ -707,10 +718,12 @@ Quick Quiz #3:  If it is illegal to block in an
> > RCU read-side
> > >
> > >
> > >  6.  ANALOGY WITH READER-WRITER LOCKING
> > > +--------------------------------------
> > >
> > >  Although RCU can be used in many different ways, a very common use of
> > >  RCU is analogous to reader-writer locking.  The following unified
> > >  diff shows how closely related RCU and reader-writer locking can be.
> > > +::
> > >
> > >       @@ -5,5 +5,5 @@ struct el {
> > >               int data;
> > > @@ -762,7 +775,7 @@ diff shows how closely related RCU and reader-writer
> > locking can be.
> > >               return 0;
> > >        }
> > >
> > > -Or, for those who prefer a side-by-side listing:
> > > +Or, for those who prefer a side-by-side listing::
> > >
> > >   1 struct el {                          1 struct el {
> > >   2   struct list_head list;             2   struct list_head list;
> > > @@ -774,40 +787,44 @@ Or, for those who prefer a side-by-side listing:
> > >   8 rwlock_t listmutex;                  8 spinlock_t listmutex;
> > >   9 struct el head;                      9 struct el head;
> > >
> > > - 1 int search(long key, int *result)    1 int search(long key, int
> > *result)
> > > - 2 {                                    2 {
> > > - 3   struct list_head *lp;              3   struct list_head *lp;
> > > - 4   struct el *p;                      4   struct el *p;
> > > - 5                                      5
> > > - 6   read_lock(&listmutex);             6   rcu_read_lock();
> > > - 7   list_for_each_entry(p, head, lp) { 7   list_for_each_entry_rcu(p,
> > head, lp) {
> > > - 8     if (p->key == key) {             8     if (p->key == key) {
> > > - 9       *result = p->data;             9       *result = p->data;
> > > -10       read_unlock(&listmutex);      10       rcu_read_unlock();
> > > -11       return 1;                     11       return 1;
> > > -12     }                               12     }
> > > -13   }                                 13   }
> > > -14   read_unlock(&listmutex);          14   rcu_read_unlock();
> > > -15   return 0;                         15   return 0;
> > > -16 }                                   16 }
> > > -
> > > - 1 int delete(long key)                 1 int delete(long key)
> > > - 2 {                                    2 {
> > > - 3   struct el *p;                      3   struct el *p;
> > > - 4                                      4
> > > - 5   write_lock(&listmutex);            5   spin_lock(&listmutex);
> > > - 6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p,
> > head, lp) {
> > > - 7     if (p->key == key) {             7     if (p->key == key) {
> > > - 8       list_del(&p->list);            8       list_del_rcu(&p->list);
> > > - 9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
> > > -                                       10       synchronize_rcu();
> > > -10       kfree(p);                     11       kfree(p);
> > > -11       return 1;                     12       return 1;
> > > -12     }                               13     }
> > > -13   }                                 14   }
> > > -14   write_unlock(&listmutex);         15   spin_unlock(&listmutex);
> > > -15   return 0;                         16   return 0;
> > > -16 }                                   17 }
> > > +::
> > > +
> > > +  1 int search(long key, int *result)    1 int search(long key, int
> > *result)
> > > +  2 {                                    2 {
> > > +  3   struct list_head *lp;              3   struct list_head *lp;
> > > +  4   struct el *p;                      4   struct el *p;
> > > +  5                                      5
> > > +  6   read_lock(&listmutex);             6   rcu_read_lock();
> > > +  7   list_for_each_entry(p, head, lp) { 7   list_for_each_entry_rcu(p,
> > head, lp) {
> > > +  8     if (p->key == key) {             8     if (p->key == key) {
> > > +  9       *result = p->data;             9       *result = p->data;
> > > + 10       read_unlock(&listmutex);      10       rcu_read_unlock();
> > > + 11       return 1;                     11       return 1;
> > > + 12     }                               12     }
> > > + 13   }                                 13   }
> > > + 14   read_unlock(&listmutex);          14   rcu_read_unlock();
> > > + 15   return 0;                         15   return 0;
> > > + 16 }                                   16 }
> > > +
> > > +::
> > > +
> > > +  1 int delete(long key)                 1 int delete(long key)
> > > +  2 {                                    2 {
> > > +  3   struct el *p;                      3   struct el *p;
> > > +  4                                      4
> > > +  5   write_lock(&listmutex);            5   spin_lock(&listmutex);
> > > +  6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p,
> > head, lp) {
> > > +  7     if (p->key == key) {             7     if (p->key == key) {
> > > +  8       list_del(&p->list);            8       list_del_rcu(&p->list);
> > > +  9       write_unlock(&listmutex);      9
> >  spin_unlock(&listmutex);
> > > +                                        10       synchronize_rcu();
> > > + 10       kfree(p);                     11       kfree(p);
> > > + 11       return 1;                     12       return 1;
> > > + 12     }                               13     }
> > > + 13   }                                 14   }
> > > + 14   write_unlock(&listmutex);         15   spin_unlock(&listmutex);
> > > + 15   return 0;                         16   return 0;
> > > + 16 }                                   17 }
> > >
> > >  Either way, the differences are quite small.  Read-side locking moves
> > >  to rcu_read_lock() and rcu_read_unlock, update-side locking moves from
> > > @@ -827,13 +844,14 @@ be used in place of synchronize_rcu().
> > >
> > >
> > >  7.  FULL LIST OF RCU APIs
> > > +-------------------------
> > >
> > >  The RCU APIs are documented in docbook-format header comments in the
> > >  Linux-kernel source code, but it helps to have a full list of the
> > >  APIs, since there does not appear to be a way to categorize them
> > >  in docbook.  Here is the list, by category.
> > >
> > > -RCU list traversal:
> > > +RCU list traversal::
> > >
> > >       list_entry_rcu
> > >       list_first_entry_rcu
> > > @@ -854,7 +872,7 @@ RCU list traversal:
> > >       hlist_bl_first_rcu
> > >       hlist_bl_for_each_entry_rcu
> > >
> > > -RCU pointer/list update:
> > > +RCU pointer/list udate::
> > >
> > >       rcu_assign_pointer
> > >       list_add_rcu
> > > @@ -876,7 +894,9 @@ RCU pointer/list update:
> > >       hlist_bl_del_rcu
> > >       hlist_bl_set_first_rcu
> > >
> > > -RCU: Critical sections       Grace period            Barrier
> > > +RCU::
> > > +
> > > +     Critical sections       Grace period            Barrier
> > >
> > >       rcu_read_lock           synchronize_net         rcu_barrier
> > >       rcu_read_unlock         synchronize_rcu
> > > @@ -885,7 +905,9 @@ RCU:      Critical sections       Grace period
> >       Barrier
> > >       rcu_dereference_check   kfree_rcu
> > >       rcu_dereference_protected
> > >
> > > -bh:  Critical sections       Grace period            Barrier
> > > +bh::
> > > +
> > > +     Critical sections       Grace period            Barrier
> > >
> > >       rcu_read_lock_bh        call_rcu                rcu_barrier
> > >       rcu_read_unlock_bh      synchronize_rcu
> > > @@ -896,7 +918,9 @@ bh:       Critical sections       Grace period
> >       Barrier
> > >       rcu_dereference_bh_protected
> > >       rcu_read_lock_bh_held
> > >
> > > -sched:       Critical sections       Grace period            Barrier
> > > +sched::
> > > +
> > > +     Critical sections       Grace period            Barrier
> > >
> > >       rcu_read_lock_sched     call_rcu                rcu_barrier
> > >       rcu_read_unlock_sched   synchronize_rcu
> > > @@ -910,7 +934,9 @@ sched:    Critical sections       Grace period
> >       Barrier
> > >       rcu_read_lock_sched_held
> > >
> > >
> > > -SRCU:        Critical sections       Grace period            Barrier
> > > +SRCU::
> > > +
> > > +     Critical sections       Grace period            Barrier
> > >
> > >       srcu_read_lock          call_srcu               srcu_barrier
> > >       srcu_read_unlock        synchronize_srcu
> > > @@ -918,13 +944,14 @@ SRCU:   Critical sections       Grace period
> >       Barrier
> > >       srcu_dereference_check
> > >       srcu_read_lock_held
> > >
> > > -SRCU:        Initialization/cleanup
> > > +SRCU: Initialization/cleanup::
> > > +
> > >       DEFINE_SRCU
> > >       DEFINE_STATIC_SRCU
> > >       init_srcu_struct
> > >       cleanup_srcu_struct
> > >
> > > -All:  lockdep-checked RCU-protected pointer access
> > > +All: lockdep-checked RCU-protected pointer access::
> > >
> > >       rcu_access_pointer
> > >       rcu_dereference_raw
> > > @@ -976,6 +1003,7 @@ the right tool for your job.
> > >
> > >
> > >  8.  ANSWERS TO QUICK QUIZZES
> > > +----------------------------
> > >
> > >  Quick Quiz #1:       Why is this argument naive?  How could a deadlock
> > >               occur when using this algorithm in a real-world Linux
> > > --
> > > 2.20.1
> > >
> >
