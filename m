Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED20CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0384D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572879814;
	bh=PgT8W6DftwnfwmGNL6dHObxLdmfDGv/U93yvXSQ/GmA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ddEPOOBV8FtQcB1i7GmgbOkkEC/nbe87hVqzDykAwbHtQEm0QwPtNVjysPna7FZlx
	 neI5+xsRw0efbK8MOxCYdpdoKVWcYz8j24XsG5egx+AKnr7fBwsYLVrshw04O/s32a
	 jGu9w4aZT6Q43oM8NP6dFqsJSODdWJDhBKe+McCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfKDPDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:03:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDPDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:03:32 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.216.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535AB20659;
        Mon,  4 Nov 2019 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572879810;
        bh=PgT8W6DftwnfwmGNL6dHObxLdmfDGv/U93yvXSQ/GmA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=didDH6wfhWoEueBvV+kpDeLGrNZpzDEiT8R3wgovEhJ+9TYYxPCcEx6in8MlVSZal
         aKOtmgrtocgCI9iIwNO1qsAeb51/JxAj4daou2d8IISESH7oei6HiDgqTHpLZud/zl
         lHMhOkdNJ3IljwboHJIpLiM9oGu1dcdV3sYymlgQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5A33D3520B56; Mon,  4 Nov 2019 07:03:28 -0800 (PST)
Date:   Mon, 4 Nov 2019 07:03:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: RCU: whatisRCU: Fix formatting for
 section 2
Message-ID: <20191104150328.GZ20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191104133315.GA14499@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104133315.GA14499@workstation-kernel-dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 07:03:15PM +0530, Amol Grover wrote:
> Convert RCU API method text to sub-headings and
> add hyperlink and superscript to 2 literary notes
> under rcu_dereference() section
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Good stuff, but Phong Tran beat you to it.  If you are suggesting
changes to that patch, please send a reply to her email, which
may be found here:

https://lore.kernel.org/lkml/20191030233128.14997-1-tranmanphong@gmail.com/

There are several options for replying to this email listed at the
bottom of that web page.

							Thanx, Paul

> ---
>  Documentation/RCU/whatisRCU.rst | 34 +++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index ae40c8bcc56c..3cf6e17d0065 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -150,6 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
>  at the function header comments.
>  
>  rcu_read_lock()
> +^^^^^^^^^^^^^^^
>  
>  	void rcu_read_lock(void);
>  
> @@ -164,6 +165,7 @@ rcu_read_lock()
>  	longer-term references to data structures.
>  
>  rcu_read_unlock()
> +^^^^^^^^^^^^^^^^^
>  
>  	void rcu_read_unlock(void);
>  
> @@ -172,6 +174,7 @@ rcu_read_unlock()
>  	read-side critical sections may be nested and/or overlapping.
>  
>  synchronize_rcu()
> +^^^^^^^^^^^^^^^^^
>  
>  	void synchronize_rcu(void);
>  
> @@ -225,6 +228,7 @@ synchronize_rcu()
>  	checklist.txt for some approaches to limiting the update rate.
>  
>  rcu_assign_pointer()
> +^^^^^^^^^^^^^^^^^^^^
>  
>  	void rcu_assign_pointer(p, typeof(p) v);
>  
> @@ -245,6 +249,7 @@ rcu_assign_pointer()
>  	the _rcu list-manipulation primitives such as list_add_rcu().
>  
>  rcu_dereference()
> +^^^^^^^^^^^^^^^^^
>  
>  	typeof(p) rcu_dereference(p);
>  
> @@ -279,8 +284,10 @@ rcu_dereference()
>  	if an update happened while in the critical section, and incur
>  	unnecessary overhead on Alpha CPUs.
>  
> +.. _back_to_1:
> +
>  	Note that the value returned by rcu_dereference() is valid
> -	only within the enclosing RCU read-side critical section [1].
> +	only within the enclosing RCU read-side critical section |cs_1|.
>  	For example, the following is -not- legal::
>  
>  		rcu_read_lock();
> @@ -298,15 +305,27 @@ rcu_dereference()
>  	it was acquired is just as illegal as doing so with normal
>  	locking.
>  
> +.. _back_to_2:
> +
>  	As with rcu_assign_pointer(), an important function of
>  	rcu_dereference() is to document which pointers are protected by
>  	RCU, in particular, flagging a pointer that is subject to changing
>  	at any time, including immediately after the rcu_dereference().
>  	And, again like rcu_assign_pointer(), rcu_dereference() is
>  	typically used indirectly, via the _rcu list-manipulation
> -	primitives, such as list_for_each_entry_rcu() [2].
> +	primitives, such as list_for_each_entry_rcu() |entry_2|.
> +
> +.. |cs_1| raw:: html
> +
> +	<a href="#cs"><sup>[1]</sup></a>
> +
> +.. |entry_2| raw:: html
>  
> -	[1] The variant rcu_dereference_protected() can be used outside
> +	<a href="#entry"><sup>[2]</sup></a>
> +
> +.. _cs:
> +
> +	\ :sup:`[1]`\  The variant rcu_dereference_protected() can be used outside
>  	of an RCU read-side critical section as long as the usage is
>  	protected by locks acquired by the update-side code.  This variant
>  	avoids the lockdep warning that would happen when using (for
> @@ -317,15 +336,18 @@ rcu_dereference()
>  	a lockdep expression to indicate which locks must be acquired
>  	by the caller. If the indicated protection is not provided,
>  	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
> -	and the API's code comments for more details and example usage.
> +	and the API's code comments for more details and example usage. :ref:`back <back_to_1>`
> +
> +
> +.. _entry:
>  
> -	[2] If the list_for_each_entry_rcu() instance might be used by
> +	\ :sup:`[2]`\  If the list_for_each_entry_rcu() instance might be used by
>  	update-side code as well as by RCU readers, then an additional
>  	lockdep expression can be added to its list of arguments.
>  	For example, given an additional "lock_is_held(&mylock)" argument,
>  	the RCU lockdep code would complain only if this instance was
>  	invoked outside of an RCU read-side critical section and without
> -	the protection of mylock.
> +	the protection of mylock. :ref:`back <back_to_2>`
>  
>  The following diagram shows how each API communicates among the
>  reader, updater, and reclaimer.
> -- 
> 2.20.1
> 
