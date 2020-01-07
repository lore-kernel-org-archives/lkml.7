Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969BBC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA62206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432773;
	bh=NKq/ShjDukyYkHHXytvAGFQmdmj1FmVZVGP2CEl4g08=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cgxJeJr6GoGTrRj6VymqyXjWiI4wizbM8RLaVX4ONQXIVc1e9qkq1yKI1pKw8AdqE
	 qNavAP991ENVdQhzZBUlhC5lPdHO0/IoiD5sOve1YPwTi/XBfIS7UTuJMX5ccAK5K5
	 juSl7/Pf7HnEivxmtIc3hGAUl34VmuyW2vZtBMSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgAGVcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:32:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:54884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgAGVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:32:51 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A95206F0;
        Tue,  7 Jan 2020 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578432770;
        bh=NKq/ShjDukyYkHHXytvAGFQmdmj1FmVZVGP2CEl4g08=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TIWQtPwo83QIR4B+6NO13f0GHH3ZcvmB2Ii3csb3mV4s4/7tujZLSKEJ0eToItHlC
         7D3oduy2WB67GgcjgEMmL2JxixGSrhMPhTaz8pqmOnzC3t/nZG1A7TtuXwb8OXgd/1
         ZRxJw4Ps7/7CLxxFmV1jgrcRQi8c/nQI6QRjSrEI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B86473522735; Tue,  7 Jan 2020 13:32:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 13:32:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, madhuparnabhowmik04@gmail.com, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v3 0/7] Fix trivial nits in RCU docs
Message-ID: <20200107213250.GE13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200106200802.26994-1-sj38.park@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106200802.26994-1-sj38.park@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 09:07:55PM +0100, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> This patchset fixes trivial nits in the RCU documentations.
> 
> It is based on the latest dev branch of Paul's linux-rcu git repository.
> The Complete git tree is also available at
> https://github.com/sjp38/linux/tree/patches/rcu/docs/2019-12-31/v3.

I have queued these for further review and testing, thank you!

							Thanx, Paul

> Changes from v2
> (https://lore.kernel.org/linux-doc/20200106191852.22973-1-sjpark@amazon.de/)
>  - Apply author email (sjpark@amazon.de) correctly
> 
> Changes from v1
> (https://lore.kernel.org/linux-doc/20191231151549.12797-1-sjpark@amazon.de/)
>  - Add 'Reviewed-by' from Madhuparna
>  - Fix wrong author email address
>  - Rebased on latest dev branch of Paul's linux-rcu git repository.
> 
> SeongJae Park (7):
>   doc/RCU/Design: Remove remaining HTML tags in ReST files
>   doc/RCU/listRCU: Fix typos in a example code snippets
>   doc/RCU/listRCU: Update example function name
>   doc/RCU/rcu: Use ':ref:' for links to other docs
>   doc/RCU/rcu: Use absolute paths for non-rst files
>   doc/RCU/rcu: Use https instead of http if possible
>   rcu: Fix typos in beginning comments
> 
>  .../Tree-RCU-Memory-Ordering.rst               |  8 ++++----
>  Documentation/RCU/listRCU.rst                  | 10 +++++-----
>  Documentation/RCU/rcu.rst                      | 18 +++++++++---------
>  kernel/rcu/srcutree.c                          |  2 +-
>  kernel/rcu/tree.c                              |  4 ++--
>  5 files changed, 21 insertions(+), 21 deletions(-)
> 
> -- 
> 2.17.1
> 
