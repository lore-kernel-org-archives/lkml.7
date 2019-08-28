Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33521C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05153208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLnuWfs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1JdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:33:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfH1JdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eW4BbCsi2ia+wr7tsBDbZ/uSj2hK5fClzQ6uUNUTNDA=; b=NLnuWfs008GJCfFMpZNTgprmy
        WIB4C2j+C32jdt/8LQvkJvaOlsmnVV6ts9+f+MSFKbsWgS3ZQ6ywJAKaPLHLsWZfYr0pKF/FQC0U9
        bS7TjP9J3ZtoQh+Le+jnvcgs1JRwBI7eTtNMyZeXyXGkB5B/KJ8ChukEhFXuEU0ggm7OX48DNNCBM
        YgLdgB/57NQ9+SPo5mh81FR6PlaqZKLixLBt+tQw1LEIOvdKL4siXTVXoN0EtLyXXibXSkIE88gQu
        rXIc0Kn8ICuyxTtZcuAYC8TjsKrbdTQhDvXlSActlAR3rgpJ3lCtu6905sXWRQEwJMscjYIkUHnuX
        NFzKnYRFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2uK7-0006Ei-Rl; Wed, 28 Aug 2019 09:33:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBBFD300B83;
        Wed, 28 Aug 2019 11:32:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5187201F2D46; Wed, 28 Aug 2019 11:33:01 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:33:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -v2 0/5] Further sanitize INTEL_FAM6 naming
Message-ID: <20190828093301.GE2369@hirez.programming.kicks-ass.net>
References: <20190827194820.378516765@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7F43EC93@ORSMSX115.amr.corp.intel.com>
 <20190827215135.GI2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827215135.GI2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 11:51:35PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 27, 2019 at 08:44:23PM +0000, Luck, Tony wrote:
> > > I'm reposting because the version Ingo applied and partially fixed up still
> > > generates build bot failure.
> > 
> > Looks like this version gets them all. I built my standard config, allmodconfig and allyesconfig.
> > 
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > 
> > What happens next? Will Ingo back out the previous set & his partial fixup and replace
> > with this series?  Or just slap one extra patch on top of what is already in tip?
> > 
> > First option changes a TIP branch
> 
> This is uncommon, but not unheard of. I'll talk to Ingo and Thomas
> tomorrow to see what would be the best way forward.

OK, I talked to Thomas and we're going to force update that branch. I've
pushed it out to my queue.git thing and I'll push it to -tip later
(hoping the 0day gets a chance to have a go at it, but that thing's been
soooooo slow recently I'm loath to rely/wait on it).
