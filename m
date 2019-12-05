Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71783C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481C521744
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575505524;
	bh=T/Kj7aasoT8tfhY99yWbDoxlX9qhhOFSHcc6kCya+w4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=AhND2ApHVUDb0ko2wjy+gYahBYtW3mtmcN/AiOpnHQKCxSk7gXC1zoYAAbfFltMMV
	 TxMBkTZ/N6jV9PP0mDR6E5rJagCk32o7Nndh+rooGIAnPwyeStCeBHpBNucOJ8OjPn
	 frTor1M1RViWoOz/7nzrzUFn1rLhy3GR7sOn1ya8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfLEAZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbfLEAZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:25:19 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6F221823;
        Thu,  5 Dec 2019 00:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575505518;
        bh=T/Kj7aasoT8tfhY99yWbDoxlX9qhhOFSHcc6kCya+w4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ryvX+ChrgSSB1Io3Gi7dVPJWmmRMoJY7/wQgtM0WahgDcb7IZkre4B1T7fdhsr3Tm
         VF8Qw6spRW2HMCohpoeq+MH5/VK6x+F+Tf3OpsgsjoeMMRsSMTnTA8BfQb246fKlUL
         fF5OD8qLXHdSujHPiANYICYblDdT3VPUADY062/M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3EA8E3522922; Wed,  4 Dec 2019 16:25:18 -0800 (PST)
Date:   Wed, 4 Dec 2019 16:25:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Include: Linux: rculist_nulls: Add docbook comment
 headers
Message-ID: <20191205002518.GP2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 05:33:57PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch adds docbook comment headers for hlist_nulls_first_rcu
> and hlist_nulls_next_rcu in rculist_nulls.h.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> ---

Good to see, thank you!  A few grammar nits below -- could you please
update and re-send?

							Thanx, Paul

>  include/linux/rculist_nulls.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index 517a06f36c7a..d796ef18ec52 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
>  	}
>  }
>  
> +/**
> + * hlist_nulls_first_rcu - returns the first element of the hash list.
> + * @head: the head for your list.

Could you please say something like "The head of the list."?
Just to keep point of view more consistent through the documentation.

> + */
>  #define hlist_nulls_first_rcu(head) \
>  	(*((struct hlist_nulls_node __rcu __force **)&(head)->first))
>  
> +/**
> + * hlist_nulls_next_rcu - returns the element of the list next to @node.

Here, could you please change "next to" to "after"?  This removes the
ambiguity where both the prior and the subsequent elements might be
thought of as "next to".

> + * @node: Element of the list.
> + */
>  #define hlist_nulls_next_rcu(node) \
>  	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
>  
> -- 
> 2.17.1
> 
