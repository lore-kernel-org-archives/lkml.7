Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3440DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DBB206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573508225;
	bh=nhajBxs7kYnBiQiLMOIvJHlDurr9drCgkFPGXH/K05E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ww0BTvYGlEYVVfLLUfGUGTOn503SZjrETMeqZtzBd+EKzMy9YjFKaXt4i0oLGtsoO
	 sYu6xNMsme31Bagc/ypC5SWHc3SKpPSuyPO7/acoYvxs79b2v1vaZirDSjvKVK+gIA
	 PwbNYf6lXNN4uZz4LJvndDEqhC+KpcI+Z5/QY5Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKKVhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfKKVhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:37:01 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC3A206BB;
        Mon, 11 Nov 2019 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573508220;
        bh=nhajBxs7kYnBiQiLMOIvJHlDurr9drCgkFPGXH/K05E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YTe9voE4Op60ivqkXy7H6ugSeHVvVnejFXvNWP1TXBA0l6ltYE+ClfKHpRUwcVbhv
         afGcfIBUPOi4UiOz/e4h/OmDzbmv94eo4Aku5GXOpvzocyhAssPdpVQuB2gnjbT06C
         myUBMh3Mr+5otATasY/u8Si4F3bciwvMzpuiL4FA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D36F935227DC; Mon, 11 Nov 2019 13:36:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:36:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     joel@joelfernandes.org, corbet@lwn.net, mchehab@kernel.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: RCU: whatisRCU: Updated full list of RCU
 API
Message-ID: <20191111213659.GP2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 11:41:22PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch updates the list of RCU API in whatisRCU.rst.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Queued, thank you!  Phong, Amol, could you please take a look at this?

						Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index 2f6f6ebbc8b0..c7f147b8034f 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
>  RCU list traversal::
>  
>  	list_entry_rcu
> +	list_entry_lockless
>  	list_first_entry_rcu
>  	list_next_rcu
>  	list_for_each_entry_rcu
>  	list_for_each_entry_continue_rcu
>  	list_for_each_entry_from_rcu
> +	list_first_or_null_rcu
> +	list_next_or_null_rcu
>  	hlist_first_rcu
>  	hlist_next_rcu
>  	hlist_pprev_rcu
> @@ -902,7 +905,7 @@ RCU list traversal::
>  	hlist_bl_first_rcu
>  	hlist_bl_for_each_entry_rcu
>  
> -RCU pointer/list udate::
> +RCU pointer/list update::
>  
>  	rcu_assign_pointer
>  	list_add_rcu
> @@ -912,10 +915,12 @@ RCU pointer/list udate::
>  	hlist_add_behind_rcu
>  	hlist_add_before_rcu
>  	hlist_add_head_rcu
> +	hlist_add_tail_rcu
>  	hlist_del_rcu
>  	hlist_del_init_rcu
>  	hlist_replace_rcu
> -	list_splice_init_rcu()
> +	list_splice_init_rcu
> +	list_splice_tail_init_rcu
>  	hlist_nulls_del_init_rcu
>  	hlist_nulls_del_rcu
>  	hlist_nulls_add_head_rcu
> -- 
> 2.17.1
> 
