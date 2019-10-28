Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D8CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDA20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572285758;
	bh=Hyg++zfQSMX+47X9Z7dJD9TriyOsl/OxnbC82FMuQLA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=mJjNAH/sQiyx+vwz22J0sYyGRHij9YPOWXCwnsYSRk2QFkOsHy1os0uJLbHd078xj
	 8XVbA52pfkG/a9E6cEIO9r7EG57g2z2K212n9/YkQl8ehly+LeDcb7UTuRInOraP+g
	 7kLn/QkhE3n1yFmmmxJGcd6+bzhlQXY4tf3vhl6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbfJ1SCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfJ1SCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:02:36 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253A620862;
        Mon, 28 Oct 2019 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572285755;
        bh=Hyg++zfQSMX+47X9Z7dJD9TriyOsl/OxnbC82FMuQLA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qNfN5tlvR6Bc/HSOU2T5NwEH9tG876FuSY2Z9rzu8ckVYKZhUlhZZrUo7IRm8luG7
         l0Q0zKiZWrYCqc1okeIwqoF0Sz28N1jbDTXgyTGrEUqW+h9PMDoTFT33gV0cByPup+
         IsGWDrTlyxhOLYfdMgB19mVKHTo1nMBXgKCq8tT8=
Date:   Mon, 28 Oct 2019 11:02:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     joel@joelfernandes.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnbhowmik04@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: RCU: Converted arrayRCU.txt to
 arrayRCU.rst.
Message-ID: <20191028180233.GO4465@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191028151936.27016-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028151936.27016-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:49:36PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch converts arrayRCU from txt to rst format.
> arrayRCU.rst is also added in the index.rst file.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnbhowmik04@gmail.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Thank you, but this does not apply to the -rcu git repo's "dev" branch.
Could you please tell me what commit you developed this against?

FYI, the location and much more about -rcu may be found here:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html

							Thanx, Paul

> ---
>  .../RCU/{arrayRCU.txt => arrayRCU.rst}         | 18 ++++++++++++++----
>  Documentation/RCU/index.rst                    |  1 +
>  2 files changed, 15 insertions(+), 4 deletions(-)
>  rename Documentation/RCU/{arrayRCU.txt => arrayRCU.rst} (91%)
> 
> diff --git a/Documentation/RCU/arrayRCU.txt b/Documentation/RCU/arrayRCU.rst
> similarity index 91%
> rename from Documentation/RCU/arrayRCU.txt
> rename to Documentation/RCU/arrayRCU.rst
> index f05a9afb2c39..c8a26f7b2577 100644
> --- a/Documentation/RCU/arrayRCU.txt
> +++ b/Documentation/RCU/arrayRCU.rst
> @@ -1,4 +1,7 @@
> +.. _array_rcu_doc:
> +
>  Using RCU to Protect Read-Mostly Arrays
> +=======================================
>  
>  
>  Although RCU is more commonly used to protect linked lists, it can
> @@ -26,6 +29,7 @@ described in the following sections.
>  
>  
>  Situation 1: Hash Tables
> +------------------------
>  
>  Hash tables are often implemented as an array, where each array entry
>  has a linked-list hash chain.  Each hash chain can be protected by RCU
> @@ -34,6 +38,7 @@ to other array-of-list situations, such as radix trees.
>  
>  
>  Situation 2: Static Arrays
> +--------------------------
>  
>  Static arrays, where the data (rather than a pointer to the data) is
>  located in each array element, and where the array is never resized,
> @@ -41,11 +46,14 @@ have not been used with RCU.  Rik van Riel recommends using seqlock in
>  this situation, which would also have minimal read-side overhead as long
>  as updates are rare.
>  
> -Quick Quiz:  Why is it so important that updates be rare when
> -	     using seqlock?
> +Quick Quiz:
> +		Why is it so important that updates be rare when using seqlock?
> +
> +:ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
>  
>  
>  Situation 3: Resizeable Arrays
> +------------------------------
>  
>  Use of RCU for resizeable arrays is demonstrated by the grow_ary()
>  function formerly used by the System V IPC code.  The array is used
> @@ -60,7 +68,7 @@ the remainder of the new, updates the ids->entries pointer to point to
>  the new array, and invokes ipc_rcu_putref() to free up the old array.
>  Note that rcu_assign_pointer() is used to update the ids->entries pointer,
>  which includes any memory barriers required on whatever architecture
> -you are running on.
> +you are running on.::
>  
>  	static int grow_ary(struct ipc_ids* ids, int newsize)
>  	{
> @@ -112,7 +120,7 @@ a simple check suffices.  The pointer to the structure corresponding
>  to the desired IPC object is placed in "out", with NULL indicating
>  a non-existent entry.  After acquiring "out->lock", the "out->deleted"
>  flag indicates whether the IPC object is in the process of being
> -deleted, and, if not, the pointer is returned.
> +deleted, and, if not, the pointer is returned.::
>  
>  	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
>  	{
> @@ -144,8 +152,10 @@ deleted, and, if not, the pointer is returned.
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
> index 340a9725676c..c4586602e7e2 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -7,6 +7,7 @@ RCU concepts
>  .. toctree::
>     :maxdepth: 1
>  
> +   arrayRCU
>     rcu
>     listRCU
>     UP
> -- 
> 2.17.1
> 
