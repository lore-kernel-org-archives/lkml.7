Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C940CA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276712087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572343569;
	bh=FMbuBN1oCdTYjXZWl1ed/CoUuwWzBee+m6QmA4X1wnQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=V+woXV5mHtbYGnIMbcxWjALKaFHLx12VtkSk8nUi4QSUAnTvJhImqKe/1h2ARsSTy
	 2G2mCLMMPUsmet7lSaTUH+hwgCbEp2WMUqKMWut7Dg7MEqbuzukYcoz+cdZ7VF53ug
	 kWDYCf4ha7lwjpP6+wNOepyuMDCu6LcVODDNMaZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfJ2KGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfJ2KGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 06:06:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16EE2087F;
        Tue, 29 Oct 2019 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572343566;
        bh=FMbuBN1oCdTYjXZWl1ed/CoUuwWzBee+m6QmA4X1wnQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J6aDAZx4xqFMpkILuT9p6FzEtCKmEPbnIGD+C6pge10/Ms6Q0paV9BBE/RFW0qSYg
         yLb4VqSYUMjDwubtIlvojneMZvdd1Z5kDgjEQb9zJX0eZoHaejuY0HfS7znCHey88W
         HvsNnFg64Cyma4wDEPnewh+5iccuUnaQN6Kff8bA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C4F163521071; Tue, 29 Oct 2019 03:06:05 -0700 (PDT)
Date:   Tue, 29 Oct 2019 03:06:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: RCU: NMI-RCU: Converted NMI-RCU.txt to
 NMI-RCU.rst.
Message-ID: <20191029100605.GI20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191028214252.17580-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028214252.17580-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 03:12:52AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch converts NMI-RCU from txt to rst format.
> Also adds NMI-RCU in the index.rst file.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Applied for further review, thank you!  Assuming review goes well,
I will be pushing this for v5.6 (not the upcoming merge window, but
the one after it).

							Thanx, Paul

> ---
>  .../RCU/{NMI-RCU.txt => NMI-RCU.rst}          | 53 ++++++++++---------
>  Documentation/RCU/index.rst                   |  1 +
>  2 files changed, 29 insertions(+), 25 deletions(-)
>  rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)
> 
> diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.rst
> similarity index 73%
> rename from Documentation/RCU/NMI-RCU.txt
> rename to Documentation/RCU/NMI-RCU.rst
> index 881353fd5bff..da5861f6a433 100644
> --- a/Documentation/RCU/NMI-RCU.txt
> +++ b/Documentation/RCU/NMI-RCU.rst
> @@ -1,4 +1,7 @@
> +.. _NMI_rcu_doc:
> +
>  Using RCU to Protect Dynamic NMI Handlers
> +=========================================
>  
>  
>  Although RCU is usually used to protect read-mostly data structures,
> @@ -9,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
>  "arch/x86/kernel/traps.c".
>  
>  The relevant pieces of code are listed below, each followed by a
> -brief explanation.
> +brief explanation.::
>  
>  	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
>  	{
> @@ -18,12 +21,12 @@ brief explanation.
>  
>  The dummy_nmi_callback() function is a "dummy" NMI handler that does
>  nothing, but returns zero, thus saying that it did nothing, allowing
> -the NMI handler to take the default machine-specific action.
> +the NMI handler to take the default machine-specific action.::
>  
>  	static nmi_callback_t nmi_callback = dummy_nmi_callback;
>  
>  This nmi_callback variable is a global function pointer to the current
> -NMI handler.
> +NMI handler.::
>  
>  	void do_nmi(struct pt_regs * regs, long error_code)
>  	{
> @@ -53,11 +56,12 @@ anyway.  However, in practice it is a good documentation aid, particularly
>  for anyone attempting to do something similar on Alpha or on systems
>  with aggressive optimizing compilers.
>  
> -Quick Quiz:  Why might the rcu_dereference_sched() be necessary on Alpha,
> -	     given that the code referenced by the pointer is read-only?
> +Quick Quiz:
> +		Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
>  
> +:ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
>  
> -Back to the discussion of NMI and RCU...
> +Back to the discussion of NMI and RCU...::
>  
>  	void set_nmi_callback(nmi_callback_t callback)
>  	{
> @@ -68,7 +72,7 @@ The set_nmi_callback() function registers an NMI handler.  Note that any
>  data that is to be used by the callback must be initialized up -before-
>  the call to set_nmi_callback().  On architectures that do not order
>  writes, the rcu_assign_pointer() ensures that the NMI handler sees the
> -initialized values.
> +initialized values::
>  
>  	void unset_nmi_callback(void)
>  	{
> @@ -82,7 +86,7 @@ up any data structures used by the old NMI handler until execution
>  of it completes on all other CPUs.
>  
>  One way to accomplish this is via synchronize_rcu(), perhaps as
> -follows:
> +follows::
>  
>  	unset_nmi_callback();
>  	synchronize_rcu();
> @@ -98,24 +102,23 @@ to free up the handler's data as soon as synchronize_rcu() returns.
>  Important note: for this to work, the architecture in question must
>  invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
>  
> +.. _answer_quick_quiz_NMI:
>  
> -Answer to Quick Quiz
> -
> -	Why might the rcu_dereference_sched() be necessary on Alpha, given
> -	that the code referenced by the pointer is read-only?
> +Answer to Quick Quiz:
> +	Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
>  
> -	Answer: The caller to set_nmi_callback() might well have
> -		initialized some data that is to be used by the new NMI
> -		handler.  In this case, the rcu_dereference_sched() would
> -		be needed, because otherwise a CPU that received an NMI
> -		just after the new handler was set might see the pointer
> -		to the new NMI handler, but the old pre-initialized
> -		version of the handler's data.
> +	The caller to set_nmi_callback() might well have
> +	initialized some data that is to be used by the new NMI
> +	handler.  In this case, the rcu_dereference_sched() would
> +	be needed, because otherwise a CPU that received an NMI
> +	just after the new handler was set might see the pointer
> +	to the new NMI handler, but the old pre-initialized
> +	version of the handler's data.
>  
> -		This same sad story can happen on other CPUs when using
> -		a compiler with aggressive pointer-value speculation
> -		optimizations.
> +	This same sad story can happen on other CPUs when using
> +	a compiler with aggressive pointer-value speculation
> +	optimizations.
>  
> -		More important, the rcu_dereference_sched() makes it
> -		clear to someone reading the code that the pointer is
> -		being protected by RCU-sched.
> +	More important, the rcu_dereference_sched() makes it
> +	clear to someone reading the code that the pointer is
> +	being protected by RCU-sched.
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 8d20d44f8fd4..627128c230dc 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -10,6 +10,7 @@ RCU concepts
>     arrayRCU
>     rcu
>     listRCU
> +   NMI-RCU
>     UP
>  
>     Design/Memory-Ordering/Tree-RCU-Memory-Ordering
> -- 
> 2.17.1
> 
