Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C914CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DDCE208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572296418;
	bh=wwm/g/IquAE4Y9gTiClWk0zw3UhnWwDbyNiv8CPDbcU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qkNt/XzNKkB/nNSD5bb0ZlFzX2/eIfSox/GCx8xQGSwbgK0ma4ocZpfzhV5Q8+r+D
	 bMqjFK3fZztppXn/2BpMYfgTBwzdxwcjfg0Iq5m/BmfiHKbrfqCJ/dOZjsqlRrvh+N
	 n/orcNXHVaXCBpSgwW7p2CHvbMBlhhlFvzVi6ZDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfJ1VAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfJ1VAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:00:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95BD4218BA;
        Mon, 28 Oct 2019 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572296414;
        bh=wwm/g/IquAE4Y9gTiClWk0zw3UhnWwDbyNiv8CPDbcU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Rk7M/peu0QxJ1PXDReaKjGE0RrFqATy/j3UFbJm/CyHM1Z4IZsiMDqKghZwcDHpHL
         nQrR0WRfxd6UhDgt3PeierO8WZKgTho9OOMW+Ls6a+EoUpLSn7rKGW4N+BRRcMXfY2
         Eng1/e2fIjzpLWWSlcpcPtZ4+1qKLEmVfzizZuWg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 618BF3522C0D; Mon, 28 Oct 2019 14:00:14 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:00:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     paulmck@kernel.org, joel@joelfernandes.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: RCU: arrayRCU: Converted arrayRCU.txt to
 arrayRCU.rst
Message-ID: <20191028210014.GD20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191028202417.13095-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028202417.13095-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 01:54:17AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch converts arrayRCU from txt to rst format.
> arrayRCU.rst is also added in the index.rst file.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Much better, thank you!

I queued this with a small but important change called out below.

> ---
>  .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 +++++++++++++-----
>  Documentation/RCU/index.rst                    |  1 +
>  2 files changed, 14 insertions(+), 5 deletions(-)
>  rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)
> 
> diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
> similarity index 91%
> rename from Documentation/RCU/arrayRCU.txt
> rename to Documentation/RCU/arrayRCU.rst
> index f05a9afb2c39..ed5ae24b196e 100644
> --- a/Documentation/RCU/arrayRCU.txt
> +++ b/Documentation/RCU/arrayRCU.rst
> @@ -1,5 +1,7 @@
> -Using RCU to Protect Read-Mostly Arrays
> +.. _array_rcu_doc:
>  
> +Using RCU to Protect Read-Mostly Arrays
> +=======================================
>  
>  Although RCU is more commonly used to protect linked lists, it can
>  also be used to protect arrays.  Three situations are as follows:
> @@ -26,6 +28,7 @@ described in the following sections.
>  
>  
>  Situation 1: Hash Tables
> +------------------------
>  
>  Hash tables are often implemented as an array, where each array entry
>  has a linked-list hash chain.  Each hash chain can be protected by RCU
> @@ -34,6 +37,7 @@ to other array-of-list situations, such as radix trees.
>  
>  
>  Situation 2: Static Arrays
> +--------------------------
>  
>  Static arrays, where the data (rather than a pointer to the data) is
>  located in each array element, and where the array is never resized,
> @@ -41,11 +45,13 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
>  this situation, which would also have minimal read-side overhead as long
>  as updates are rare.
>  
> -Quick Quiz:  Why is it so important that updates be rare when
> -	     using seqlock?
> +Quick Quiz:  

The above line added trailing whitespace.  I removed it for you, but
please check for this on future submissions.  ;-)

							Thanx, Paul

> +		Why is it so important that updates be rare when using seqlock?
>  
> +:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
>  
>  Situation 3: Resizeable Arrays
> +------------------------------
>  
>  Use of RCU for resizeable arrays is demonstrated by the grow_ary()
>  function formerly used by the System V IPC code.  The array is used
> @@ -60,7 +66,7 @@ the remainder of the new, updates the ids->entries pointer to point to
>  the new array, and invokes ipc_rcu_putref() to free up the old array.
>  Note that rcu_assign_pointer() is used to update the ids->entries pointer,
>  which includes any memory barriers required on whatever architecture
> -you are running on.
> +you are running on.::
>  
>  	static int grow_ary(struct ipc_ids* ids, int newsize)
>  	{
> @@ -112,7 +118,7 @@ a simple check suffices.  The pointer to the structure corresponding
>  to the desired IPC object is placed in "out", with NULL indicating
>  a non-existent entry.  After acquiring "out->lock", the "out->deleted"
>  flag indicates whether the IPC object is in the process of being
> -deleted, and, if not, the pointer is returned.
> +deleted, and, if not, the pointer is returned.::
>  
>  	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
>  	{
> @@ -144,8 +150,10 @@ deleted, and, if not, the pointer is returned.
>  		return out;
>  	}
>  
> +.. _answer_quick_quiz_seqlock:
>  
>  Answer to Quick Quiz:
> +	Why is it so important that updates be rare when using seqlock?
>  
>  	The reason that it is important that updates be rare when
>  	using seqlock is that frequent updates can livelock readers.
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 5c99185710fa..8d20d44f8fd4 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -7,6 +7,7 @@ RCU concepts
>  .. toctree::
>     :maxdepth: 3
>  
> +   arrayRCU
>     rcu
>     listRCU
>     UP
> -- 
> 2.17.1
> 
