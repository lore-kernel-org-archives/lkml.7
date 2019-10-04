Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9E0C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BF2222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570227882;
	bh=/1rNu8CVWv+a4qh8uRDvMq0gED61r/4CcMH8+ga6R/Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fhCc4vxQA4OhYKHRjydKlLiNZZVB7pY0QNmev8pdCARXOycwpdKKnR4W5hiWtL5m+
	 PIYbvr2kOEIYZR8M1lWWAKiWtgGWZQb0n64+D88YwsrghKdc41Q+3S50vDTelq1bBJ
	 dJQUWj4vqNEUJwsnRBYYaHfg3Gr5HBQQy1p/iU3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbfJDWYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfJDWYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:24:41 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B11FD222C0;
        Fri,  4 Oct 2019 22:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570227880;
        bh=/1rNu8CVWv+a4qh8uRDvMq0gED61r/4CcMH8+ga6R/Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sb9wMcnuaX+/3taBbhX2+xIXYHwcnlKDeARYNZX7cc+BS0HUEjs0bUCOf6hm2v1pE
         Sn+THIehdjES5UsvPDjhBRGQ0ujQYI05nH+WBVgzmK8Mp9/HV5EglcFjmpLc+aHS1z
         CRWtmRkk122ecVMohuxORrBJA8UYrLoH3AEc2Gek=
Date:   Fri, 4 Oct 2019 15:24:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Describe variadic macro argument in a
 Sphinx-compatible way
Message-ID: <20191004222439.GR2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191004215402.28008-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004215402.28008-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:54:02PM +0200, Jonathan Neuschäfer wrote:
> Without this patch, Sphinx shows "variable arguments" as the description
> of the cond argument, rather than the intended description, and prints
> the following warnings:
> 
> ./include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
> ./include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied for testing and review, thank you!

Joel, does this look sane to you?

							Thanx, Paul

> ---
>  include/linux/rculist.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 4158b7212936..61c6728a71f7 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -361,7 +361,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>   * @pos:	the type * to use as a loop cursor.
>   * @head:	the head for your list.
>   * @member:	the name of the list_head within the struct.
> - * @cond:	optional lockdep expression if called from non-RCU protection.
> + * @cond...:	optional lockdep expression if called from non-RCU protection.
>   *
>   * This list-traversal primitive may safely run concurrently with
>   * the _rcu list-mutation primitives such as list_add_rcu()
> @@ -636,7 +636,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
>   * @pos:	the type * to use as a loop cursor.
>   * @head:	the head for your list.
>   * @member:	the name of the hlist_node within the struct.
> - * @cond:	optional lockdep expression if called from non-RCU protection.
> + * @cond...:	optional lockdep expression if called from non-RCU protection.
>   *
>   * This list-traversal primitive may safely run concurrently with
>   * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> --
> 2.20.1
> 
