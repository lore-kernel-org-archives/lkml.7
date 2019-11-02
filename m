Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E4CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700C721855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572711508;
	bh=n/vOOmRhhGpI87ptfX62Dhb0xDsS6+L8sMPLL5amXfU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QxJqio6nN+PbjAw/6CCzkcjvErwWJaiAaU2v6AXdVa+1VH1ySM8uP3mL7wZaCU6ek
	 ftWursx0mEJFmaA4mZmLXVuCcKPZaZ8+mSVPaVHtb+mD+f3ttQ3NYPuycqEnWXeSlk
	 y/h/wOHLzIiqiUeGv/0hclR7mef7Sk9/meXaNVFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKBQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfKBQS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:18:27 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [65.158.186.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA842084D;
        Sat,  2 Nov 2019 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572711505;
        bh=n/vOOmRhhGpI87ptfX62Dhb0xDsS6+L8sMPLL5amXfU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UlNT3XnaE1lxKroKNyptS3OoL+lWu0mSthymudMaT2GerFVPbOVNPFvjG0f3SrL9y
         108YrtORwBJt+amm+LGyx7pTrB7hL2cWcca8dYywb+HUZmZjs+NbEtQjDTEJSmuoIj
         vNmNHYOU/G19Finc5vx074DOtwshHAxEmvE+O+fQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 426BB35204A2; Sat,  2 Nov 2019 09:18:25 -0700 (PDT)
Date:   Sat, 2 Nov 2019 09:18:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net,
        madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Doc: Improve format for whatisRCU.rst
Message-ID: <20191102161825.GR20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102115517.6378-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102115517.6378-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2019 at 06:55:17PM +0700, Phong Tran wrote:
> Adding crossreference target for some headers, answer of quizzes
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

I have queued this, thank you!

Once Madhuparna reviews/tests, I will merge it into your earlier version.

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.rst | 73 +++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 70d0e4c21917..ae40c8bcc56c 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -1,4 +1,4 @@
> -.. _rcu_doc:
> +.. _whatisrcu_doc:
>  
>  What is RCU?  --  "Read, Copy, Update"
>  ======================================
> @@ -27,14 +27,21 @@ the experience has been that different people must take different paths
>  to arrive at an understanding of RCU.  This document provides several
>  different paths, as follows:
>  
> -1.	RCU OVERVIEW
> -2.	WHAT IS RCU'S CORE API?
> -3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
> -4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK?
> -5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
> -6.	ANALOGY WITH READER-WRITER LOCKING
> -7.	FULL LIST OF RCU APIs
> -8.	ANSWERS TO QUICK QUIZZES
> +:ref:`1.	RCU OVERVIEW <1_whatisRCU>`
> +
> +:ref:`2.	WHAT IS RCU'S CORE API? <2_whatisRCU>`
> +
> +:ref:`3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API? <3_whatisRCU>`
> +
> +:ref:`4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK? <4_whatisRCU>`
> +
> +:ref:`5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU? <5_whatisRCU>`
> +
> +:ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
> +
> +:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
> +
> +:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
>  
>  People who prefer starting with a conceptual overview should focus on
>  Section 1, though most readers will profit by reading this section at
> @@ -52,6 +59,7 @@ everything, feel free to read the whole thing -- but if you are really
>  that type of person, you have perused the source code and will therefore
>  never need this document anyway.  ;-)
>  
> +.. _1_whatisRCU:
>  
>  1.  RCU OVERVIEW
>  ----------------
> @@ -120,6 +128,7 @@ So how the heck can a reclaimer tell when a reader is done, given
>  that readers are not doing any sort of synchronization operations???
>  Read on to learn about how RCU's API makes this easy.
>  
> +.. _2_whatisRCU:
>  
>  2.  WHAT IS RCU'S CORE API?
>  ---------------------------
> @@ -381,13 +390,15 @@ c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
>  Again, most uses will be of (a).  The (b) and (c) cases are important
>  for specialized uses, but are relatively uncommon.
>  
> +.. _3_whatisRCU:
>  
>  3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
>  -----------------------------------------------
>  
>  This section shows a simple use of the core RCU API to protect a
>  global pointer to a dynamically allocated structure.  More-typical
> -uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
> +uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
> +:ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst <NMI_rcu_doc>`.
>  ::
>  
>  	struct foo {
> @@ -470,9 +481,11 @@ o	Use synchronize_rcu() -after- removing a data element from an
>  	data item.
>  
>  See checklist.txt for additional rules to follow when using RCU.
> -And again, more-typical uses of RCU may be found in listRCU.txt,
> -arrayRCU.txt, and NMI-RCU.txt.
> +And again, more-typical uses of RCU may be found in :ref:`listRCU.rst
> +<list_rcu_doc>`, :ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst
> +<NMI_rcu_doc>`.
>  
> +.. _4_whatisRCU:
>  
>  4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
>  --------------------------------------------
> @@ -567,6 +580,7 @@ to avoid having to write your own callback::
>  
>  Again, see checklist.txt for additional rules governing the use of RCU.
>  
> +.. _5_whatisRCU:
>  
>  5.  WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
>  ------------------------------------------------
> @@ -657,10 +671,12 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
>  But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
>  so there can be no deadlock cycle.
>  
> -Quick Quiz #1:	Why is this argument naive?  How could a deadlock
> +Quick Quiz #1:
> +		Why is this argument naive?  How could a deadlock
>  		occur when using this algorithm in a real-world Linux
>  		kernel?  How could this deadlock be avoided?
>  
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
>  
>  5B.  "TOY" EXAMPLE #2: CLASSIC RCU
>  
> @@ -709,13 +725,20 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
>  that there are no RCU read-side critical sections holding a reference
>  to that data item, so we can safely reclaim it.
>  
> -Quick Quiz #2:	Give an example where Classic RCU's read-side
> +Quick Quiz #2:
> +		Give an example where Classic RCU's read-side
>  		overhead is -negative-.
>  
> -Quick Quiz #3:  If it is illegal to block in an RCU read-side
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +
> +Quick Quiz #3:
> +		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
>  		PREEMPT_RT, where normal spinlocks can block???
>  
> +:ref:`Answers to Quick Quiz <8_whatisRCU>`
> +
> +.. _6_whatisRCU:
>  
>  6.  ANALOGY WITH READER-WRITER LOCKING
>  --------------------------------------
> @@ -842,6 +865,7 @@ delete() can now block.  If this is a problem, there is a callback-based
>  mechanism that never blocks, namely call_rcu() or kfree_rcu(), that can
>  be used in place of synchronize_rcu().
>  
> +.. _7_whatisRCU:
>  
>  7.  FULL LIST OF RCU APIs
>  -------------------------
> @@ -1001,16 +1025,19 @@ g.	Otherwise, use RCU.
>  Of course, this all assumes that you have determined that RCU is in fact
>  the right tool for your job.
>  
> +.. _8_whatisRCU:
>  
>  8.  ANSWERS TO QUICK QUIZZES
>  ----------------------------
>  
> -Quick Quiz #1:	Why is this argument naive?  How could a deadlock
> +Quick Quiz #1:
> +		Why is this argument naive?  How could a deadlock
>  		occur when using this algorithm in a real-world Linux
>  		kernel?  [Referring to the lock-based "toy" RCU
>  		algorithm.]
>  
> -Answer:		Consider the following sequence of events:
> +Answer:
> +		Consider the following sequence of events:
>  
>  		1.	CPU 0 acquires some unrelated lock, call it
>  			"problematic_lock", disabling irq via
> @@ -1049,10 +1076,12 @@ Answer:		Consider the following sequence of events:
>  		approach where tasks in RCU read-side critical sections
>  		cannot be blocked by tasks executing synchronize_rcu().
>  
> -Quick Quiz #2:	Give an example where Classic RCU's read-side
> +Quick Quiz #2:
> +		Give an example where Classic RCU's read-side
>  		overhead is -negative-.
>  
> -Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
> +Answer:
> +		Imagine a single-CPU system with a non-CONFIG_PREEMPT
>  		kernel where a routing table is used by process-context
>  		code, but can be updated by irq-context code (for example,
>  		by an "ICMP REDIRECT" packet).	The usual way of handling
> @@ -1074,11 +1103,13 @@ Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
>  		even the theoretical possibility of negative overhead for
>  		a synchronization primitive is a bit unexpected.  ;-)
>  
> -Quick Quiz #3:  If it is illegal to block in an RCU read-side
> +Quick Quiz #3:
> +		If it is illegal to block in an RCU read-side
>  		critical section, what the heck do you do in
>  		PREEMPT_RT, where normal spinlocks can block???
>  
> -Answer:		Just as PREEMPT_RT permits preemption of spinlock
> +Answer:
> +		Just as PREEMPT_RT permits preemption of spinlock
>  		critical sections, it permits preemption of RCU
>  		read-side critical sections.  It also permits
>  		spinlocks blocking while in RCU read-side critical
> -- 
> 2.20.1
> 
