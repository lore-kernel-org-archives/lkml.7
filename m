Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A619FC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D80D2072E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578335745;
	bh=tvOktxxdOsY2Vaw97cRdVlckBmMduaVuO7iggyPxMBg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cW1lQDptsofgQSQ8hjKkMt+idxIYXIR4YI31x70sunc5I4mRn7QttVajFgG6iTObo
	 sTXiutPQA8wIuGb/vOUZWgTg6KKAulRpm6EhQS0AYSgX85UcnXVP2MC8eb8Zw0UTuV
	 FegMBp3evhapCNYxXLGctR301mg4WgBvJOCwFess=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgAFSfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 13:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAFSfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 13:35:44 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BACA2072E;
        Mon,  6 Jan 2020 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578335743;
        bh=tvOktxxdOsY2Vaw97cRdVlckBmMduaVuO7iggyPxMBg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=z1E9L3+WxOSGWZJiQn8ZNd+y976FRz0y3cv89C4E+7J3x7vwBVmyRsR3rIa5XzP4X
         zk8EjHxcUSlyvvnU85DILtNfq63Hx8npITrTSmtpaI4UXMbGiLzPBRuIBtCLqPnAjy
         F4/uJDcIk+hC6LzkLXiKkYiCAE9Ez1H+UMzPkA5s=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 22C79352274D; Mon,  6 Jan 2020 10:35:43 -0800 (PST)
Date:   Mon, 6 Jan 2020 10:35:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik04@gmail.com
Cc:     sj38.park@gmail.com, joel@joelfernandes.or, frextrite@gmail.com,
        corbet@lwn.net, rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 6/7] doc/RCU/rcu: Use https instead of http if possible
Message-ID: <20200106183543.GN13449@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191231151549.12797-1-sjpark@amazon.de>
 <20191231151549.12797-7-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191231151549.12797-7-sjpark@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:59:51PM +0530, madhuparnabhowmik04@gmail.com wrote:
> From: sj38.park@gmail.com
> 
> From: SeongJae Park <sjpark@amazon.de>
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> 
> Hi SeongJae,
> 
> The patch looks fine, but I am not sure if this change is required.
> What do you think Paul?

Thank you, Madhuparna!  This change might not be absolutely required,
but it is a good change.

SeongJae, could you please include Madhuparna's pair of Reviewed-by
tags and also make your email address consistent in your next posting?
You currently have both sj38.park@gmail.com and sjpark@amazon.de.
Either is fine.  ;-)

							Thanx, Paul

> Thanks,
> Madhuparna
> 
> ---
>  Documentation/RCU/rcu.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> index 2a830c51477e..0e03c6ef3147 100644
> --- a/Documentation/RCU/rcu.rst
> +++ b/Documentation/RCU/rcu.rst
> @@ -79,7 +79,7 @@ Frequently Asked Questions
>    Of these, one was allowed to lapse by the assignee, and the
>    others have been contributed to the Linux kernel under GPL.
>    There are now also LGPL implementations of user-level RCU
> -  available (http://liburcu.org/).
> +  available (https://liburcu.org/).
>  
>  - I hear that RCU needs work in order to support realtime kernels?
>  
> -- 
> 2.17.1
> 
> 
