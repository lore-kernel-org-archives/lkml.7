Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A1ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1745C21925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 03:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571281571;
	bh=/7P9U6hBC/03noff8EYSntg+AUIwP6IM0A7MyXlG0F8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=GhJr7AOaa9Netqv888ZFoUz9C/OFIKn3TgVkHi9J4iTgQE07+oWlCm5QXoL1O2b/G
	 cx5msHtWoPbg5jPwgkKpT/xjxabfCme+vZTqmELQlZ5SCowcK1OzvctykiIz4rkZJM
	 G+aDydUXiIYf8LC+DFNuSdgJ5uUZVcnrkiGpSm6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbfJQDGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 23:06:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbfJQDGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 23:06:07 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD20F218DE;
        Thu, 17 Oct 2019 03:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571281567;
        bh=/7P9U6hBC/03noff8EYSntg+AUIwP6IM0A7MyXlG0F8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IYcnZErzgNJZn+bbr6geQkVDjg+ou5d01KR1uZ4lWCwYH/TN/YB8eG3cgnnmAHQey
         uJTq8pb7YC58ZAz9883DyzXRv8HFBKO9ECgduANCbhVwjJq8JoGsYeQp3MMaxgrfkG
         onplF5YC7Gq+uCFrZxl7n7MdY/EkSuViFGTWVvu0=
Date:   Wed, 16 Oct 2019 20:06:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 26/34] Documentation/RCU: Use CONFIG_PREEMPTION where
 appropriate
Message-ID: <20191017030605.GD2588@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-27-bigeasy@linutronix.de>
 <20191016041330.GF2689@paulmck-ThinkPad-P72>
 <20191016073131.b35nfcc3vzbm2pfk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016073131.b35nfcc3vzbm2pfk@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:31:32AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-10-15 21:13:30 [-0700], Paul E. McKenney wrote:
> > Sadly, this one ran afoul of the .txt-to-.rst migration.  Even applying
> > it against linus/master and cherry-picking it does not help.  I will
> > defer it for the moment -- perhaps Mauro or Joel have some advice.
> 
> Don't worry about it then. Just point me to the tree once it is done.

Thank you very much and will do!

							Thanx, Paul
