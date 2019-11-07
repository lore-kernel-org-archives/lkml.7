Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6E9FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070C02085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573120559;
	bh=11m4wZfJjMPzk2fEBKdsC1rwpRjYVXA31fkds2/+/E8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=S9pz8QYxQwBvLoyYUr4MOCLy2i9/eRJsYRkBK1CygzYYxKOsGS30ISAzPyR1FMEc6
	 1P8rqF554CEhZxhMbkwActxoVZ/Yj7sBYdPaFYRYdGLdfITTMVRtUC+4wg9LVw17fi
	 cQdkkVEJYOEVO3U2/JgfcIg1+ESgD+WIwg+czxpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfKGJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:55:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfKGJz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:55:57 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [109.144.217.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14592084D;
        Thu,  7 Nov 2019 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573120556;
        bh=11m4wZfJjMPzk2fEBKdsC1rwpRjYVXA31fkds2/+/E8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K8YgBirCk1MCAIe836pAstA8lN5eLPqh66hjhqYqOJ+eVfgsBwM5gkYY4S67NSEUc
         OVKLnNN9rQUhA/BKSu/Fky1xh6+Ppz1NmfhB7gtw6UcHHuGPfvrcxM/rSqIy+B64Ri
         qf3qKUt387bEclE5+IwlngVc39emcU9CcFYiTGxM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05DB735227FC; Thu,  7 Nov 2019 01:55:54 -0800 (PST)
Date:   Thu, 7 Nov 2019 01:55:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Phong Tran <tranmanphong@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: rcubarrier:
 Convert to reST
Message-ID: <20191107095553.GM20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191106165617.GA12205@workstation-kernel-dev>
 <15512469-fc7e-24c8-d407-72ba7015a099@gmail.com>
 <20191107063949.GA2310@workstation-kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107063949.GA2310@workstation-kernel-dev>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 12:09:49PM +0530, Amol Grover wrote:
> On Thu, Nov 07, 2019 at 07:19:27AM +0700, Phong Tran wrote:
> > On 11/6/19 11:56 PM, Amol Grover wrote:

[ . . . ]

> > >   We instead need the rcu_barrier() primitive.  Rather than waiting for
> > >   a grace period to elapse, rcu_barrier() waits for all outstanding RCU
> > > -callbacks to complete.  Please note that rcu_barrier() does -not- imply
> > > +callbacks to complete.  Please note that rcu_barrier() does **not** imply
> > >   synchronize_rcu(), in particular, if there are no RCU callbacks queued
> > >   anywhere, rcu_barrier() is within its rights to return immediately,
> > >   without waiting for a grace period to elapse.
> > > @@ -89,78 +94,78 @@ module uses multiple flavors of call_rcu(), then it must also use multiple
> > >   flavors of rcu_barrier() when unloading that module.  For example, if
> > >   it uses call_rcu(), call_srcu() on srcu_struct_1, and call_srcu() on
> > >   srcu_struct_2(), then the following three lines of code will be required
> > 
> > Hello Amol,
> > 
> > srcu_struct_2() should be srcu_struct_2
> 
> Hey Phong,
> Thanks for the review! Fixed and sent the new patch
> https://lore.kernel.org/lkml/20191107063241.GA2234@workstation-kernel-dev/

Phong, please let us know whether Amol's new version looks good to you.
If it does, preferably with your Reviewed-by and/or Tested by.  ;-)

							Thanx, Paul
