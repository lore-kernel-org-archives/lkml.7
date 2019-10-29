Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FBFCA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821E0217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 00:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572309481;
	bh=VOgGAaaLiIO7/29MD6ZQiMJrsJpHBIYfQrkY2UI4QOo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Nny/jl6QiZl/b5+SYQWD6nXzMe1POE0bZTytLh02pOer+bzxyKtltPSdPr4VgvGcB
	 nIBegr+6zGPo79e1XyjVWn47z3YBL+TSpgTdMqthiPmNOzuqptoDEyMvRON/5ztAk9
	 +DJyu6YhD2pkPe00YDNuMzVBimjpfzjFIeGQ0pXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfJ2Ah6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 20:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfJ2Ah6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 20:37:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B6F217D6;
        Tue, 29 Oct 2019 00:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572309478;
        bh=VOgGAaaLiIO7/29MD6ZQiMJrsJpHBIYfQrkY2UI4QOo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a6VyX7PjOyi6anNVmpixeC8ko6ZpnVhErYMGCUG0qCNCaHoG+6X02n5gCoQmHDnj7
         l228uVDuxlx14LbS0FeOjR9Qn2jJ18qGopkfL5uzRZNNdTY9UlV4hcYNX/MTPM7x9i
         c5RAz9mCIHpesMeLTGAwRjCYKwWfm4vgYK2EZU8E=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EA5E33522C0D; Mon, 28 Oct 2019 17:37:57 -0700 (PDT)
Date:   Mon, 28 Oct 2019 17:37:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <20191029003757.GF20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191029075359.59d06466@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029075359.59d06466@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:53:59AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   51db3f987f62 ("Restore docs "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"")
>   a0c1ba228721 ("Restore docs "treewide: Rename rcu_dereference_raw_notrace() to _check()"")
>   8b3b77cca47f ("Revert docs from "treewide: Rename rcu_dereference_raw_notrace() to _check()"")
>   f7bf64a4ff9e ("Revert docs from "rcu: Restore barrier() to rcu_read_lock() and rcu_read_unlock()"")
> 
> are missing a Signed-off-by from their authors.

Again, good catch, thank you!

Joel, if you have any objections to my adding your Signed-off-by, please
let me know.  (In which case, I will defer them to the v5.6 merge window,
which would allow us time to work out what to do instead.)

							Thanx, Paul
