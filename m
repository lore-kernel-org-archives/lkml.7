Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A18C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C22206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573030223;
	bh=gSCNYnvybXaFKN/pomF/RlMMre8A0JZrFJwWxYzSl54=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Eh28syT5ZoQ06/XN+qnC2sjyuiz5xlJsxHoeFLThLT4t45de4kOoNoIRN8HLs7vkr
	 xQmKQ7oNJ/euEXy0BPF3cYCqumIwXSRQb57ZeQIR8CleykLfgPQIfQIsHikRnb3QsK
	 BBn+Bfk7OVdkFpTx5Bei471Rlq2BADJN2EKKwlDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfKFIuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKFIuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 03:50:21 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 824C5206A3;
        Wed,  6 Nov 2019 08:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573030220;
        bh=gSCNYnvybXaFKN/pomF/RlMMre8A0JZrFJwWxYzSl54=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pm30crSKj1fdy4ElGNGzdoydeJvy5t1WaBx/mKgGXojvqSd+Vn/oaJrTyqPor/us3
         QddBzYau48K0bi63ExnBJjetNZih2EZEmmJ1K9EMjDes15ZphbIKQB4J15CaZZaJvJ
         HZS/n8kL+2zLIFVqAijDA+EhcCs1a3vtVKJGBOY4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EAEF33520B54; Wed,  6 Nov 2019 00:50:17 -0800 (PST)
Date:   Wed, 6 Nov 2019 00:50:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     tranmanphong@gmail.com, frextrite@gmail.com,
        joel@joelfernandes.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] Documentation: RCU: arrayRCU: Improve format for
 arrayRCU.rst
Message-ID: <20191106085017.GX20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191105212927.13924-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105212927.13924-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:59:27AM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch adds cross-references and fixes a few formtting issues.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Hearing no objections, applied to be squashed into this commit:

7e42de651ffd ("Documentation: RCU: arrayRCU: Converted arrayRCU.txt
to arrayRCU.rst")

And with the addition of Phong's and Amol's Tested-by tags.

							Thanx, Paul

> ---
>  Documentation/RCU/arrayRCU.rst | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/arrayRCU.rst b/Documentation/RCU/arrayRCU.rst
> index ed5ae24b196e..30c007edfbfb 100644
> --- a/Documentation/RCU/arrayRCU.rst
> +++ b/Documentation/RCU/arrayRCU.rst
> @@ -6,16 +6,16 @@ Using RCU to Protect Read-Mostly Arrays
>  Although RCU is more commonly used to protect linked lists, it can
>  also be used to protect arrays.  Three situations are as follows:
>  
> -1.  Hash Tables
> +1.  :ref:`Hash Tables <hash_tables>`
>  
> -2.  Static Arrays
> +2.  :ref:`Static Arrays <static_arrays>`
>  
> -3.  Resizeable Arrays
> +3.  :ref:`Resizeable Arrays <resizeable_arrays>`
>  
>  Each of these three situations involves an RCU-protected pointer to an
>  array that is separately indexed.  It might be tempting to consider use
>  of RCU to instead protect the index into an array, however, this use
> -case is -not- supported.  The problem with RCU-protected indexes into
> +case is **not** supported.  The problem with RCU-protected indexes into
>  arrays is that compilers can play way too many optimization games with
>  integers, which means that the rules governing handling of these indexes
>  are far more trouble than they are worth.  If RCU-protected indexes into
> @@ -26,6 +26,7 @@ to be safely used.
>  That aside, each of the three RCU-protected pointer situations are
>  described in the following sections.
>  
> +.. _hash_tables:
>  
>  Situation 1: Hash Tables
>  ------------------------
> @@ -35,6 +36,7 @@ has a linked-list hash chain.  Each hash chain can be protected by RCU
>  as described in the listRCU.txt document.  This approach also applies
>  to other array-of-list situations, such as radix trees.
>  
> +.. _static_arrays:
>  
>  Situation 2: Static Arrays
>  --------------------------
> @@ -50,6 +52,8 @@ Quick Quiz:
>  
>  :ref:`Answer to Quick Quiz <answer_quick_quiz_seqlock>`
>  
> +.. _resizeable_arrays:
> +
>  Situation 3: Resizeable Arrays
>  ------------------------------
>  
> @@ -66,7 +70,7 @@ the remainder of the new, updates the ids->entries pointer to point to
>  the new array, and invokes ipc_rcu_putref() to free up the old array.
>  Note that rcu_assign_pointer() is used to update the ids->entries pointer,
>  which includes any memory barriers required on whatever architecture
> -you are running on.::
> +you are running on::
>  
>  	static int grow_ary(struct ipc_ids* ids, int newsize)
>  	{
> @@ -118,7 +122,7 @@ a simple check suffices.  The pointer to the structure corresponding
>  to the desired IPC object is placed in "out", with NULL indicating
>  a non-existent entry.  After acquiring "out->lock", the "out->deleted"
>  flag indicates whether the IPC object is in the process of being
> -deleted, and, if not, the pointer is returned.::
> +deleted, and, if not, the pointer is returned::
>  
>  	struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
>  	{
> -- 
> 2.17.1
> 
