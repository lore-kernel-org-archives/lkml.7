Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC4AC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967D620674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574864829;
	bh=GKX7EG2gsuqike/iGhVOQHvsxUfyW3BYSHoQohWUpIY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SbmYelzfBD0lxZjKaGydgAY05MI5GhGH0a08Lv3LeX7OFk38DVo5+EFxCfel9Drpn
	 T/O7FzE2p+55MMUxtmjk0eqCYlEjA7lHGf4TWAQwTR6n9qeBKrVhTE+7QJfx3BQL/x
	 hwbKb5D2a8Q+UkAt9N6cKa1v9dEfDpQ5lMz31gg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfK0O1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfK0O1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:27:08 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E8A20674;
        Wed, 27 Nov 2019 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574864827;
        bh=GKX7EG2gsuqike/iGhVOQHvsxUfyW3BYSHoQohWUpIY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yq+Otw3Qy3Nb0X7125ZNOAUI0RyKattNT+iUTDEVXRJuSD3XjGiyWqSS7G6FDQ7Fc
         gSv8CAuPm+kBe1PHEJbk6ERrR5+s1NHxeChoMf0dvvvapUYNVVFhBH7cFrwWN9Cq+2
         ZL1wsfLMF5cGBTb+oA5kthO+fGaWI09ipuMANtwo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AD89B352083A; Wed, 27 Nov 2019 06:27:07 -0800 (PST)
Date:   Wed, 27 Nov 2019 06:27:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj38.park@gmail.com>, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/7] docs: Update ko_KR translations
Message-ID: <20191127142707.GB2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191121234125.28032-1-sj38.park@gmail.com>
 <20191126222144.GW2889@paulmck-ThinkPad-P72>
 <20191127071205.723a33d4@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127071205.723a33d4@lwn.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 07:12:05AM -0700, Jonathan Corbet wrote:
> On Tue, 26 Nov 2019 14:21:44 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Fri, Nov 22, 2019 at 12:41:18AM +0100, SeongJae Park wrote:
> > > This patchset contains updates of Korean translation documents and a fix
> > > of original document.
> > > 
> > > First 4 patches update the Korean translation of memory-barriers.txt.
> > > Fifth patch fixes a broken section reference in the original
> > > memory-barriers.txt.
> > > 
> > > Sixth and seventh patches update the Korean translation of howto.rst.  
> > 
> > The sixth and seventh probably have some other more natural path,
> > but I queued them.  Any chance of a Reviewed-by from one of our other
> > Korean-language kernel hackers?
> 
> I applied the whole set to docs-next a few days ago...apologies if that's
> not the way you wanted these handled.

Even better!  I will drop them from -rcu.

							Thanx, Paul
