Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0359CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3619217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572594791;
	bh=VXpWqY01SDpgB8O1tjrELEhTWmvnU/VWql3TetZxFMY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qkEioRvAzzXdXlwsFpzurtv2RkdKgnkRcv85wqTMSlRhoaroQw8/G7JZadhy4HFFH
	 QpGamP43MKHPZ73nh29kGOVkjlzrOXJKq/lEfbr9Lst4WbV4eGRFs7TGlbqm1/Bsh4
	 Xpkm5trQPV5mcQm9CDwDJZ2QttdYiEaYnxjg/PK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfKAHxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfKAHxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:53:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CDC2080F;
        Fri,  1 Nov 2019 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572594789;
        bh=VXpWqY01SDpgB8O1tjrELEhTWmvnU/VWql3TetZxFMY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qHz7eIoZKQmC0/Rha3kHXDK1mg18t4hyHvyH7bfHnIxuQnZfum3oj5nhs6tULtSQN
         OL/ixtmbI0iRXe3plF5EbKVdWBF9vf/Iec5Qc4WFcv993SqV8rQKfyP60Cre4PqoYY
         hXUBxvgoQcB/CacmFA2PZAxw+BixqbAOVKIgIvpw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 55A1635207E6; Fri,  1 Nov 2019 00:53:09 -0700 (PDT)
Date:   Fri, 1 Nov 2019 00:53:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     madhuparnabhowmik04@gmail.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Doc: convert whatisRCU.txt to rst
Message-ID: <20191101075309.GH20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191030233128.14997-1-tranmanphong@gmail.com>
 <20191031225439.GD20975@paulmck-ThinkPad-P72>
 <35bb2f18-791a-caf3-957d-01e43a4b3afc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bb2f18-791a-caf3-957d-01e43a4b3afc@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 08:17:36AM +0700, Phong Tran wrote:
> Hi Paul,
> On 11/1/19 5:54 AM, Paul E. McKenney wrote:
> > Could you and Madhuparna please review and test each other's
> > .rst-conversion patches?
> 
> It's fine.
> pull and "make SPHINXDIRS="RCU" htmldocs pdfdocs" rcu dev branch
> without error or warning.

Very good, thank you!

Once you have done that (or if you have already done that) and have
verified that the resulting .html and .pdf files for the changed portions
look good, you can respond with a Tested-by tag, which has "Tested-by:",
your name, and your email within "<" and ">".  For example, commit
127068abe85b ("i2c: qcom-geni: Disable DMA processing on the Lenovo Yoga
C630") has this:

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

After you review the code, for example, by checking either the patch or the
resulting .rst file, you can respond with a very similar Reviewed-by tag.
Which allows you to get a start on participating in the code-review
process.

							Thanx, Paul
