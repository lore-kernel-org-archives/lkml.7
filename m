Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC885C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E34620726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575884682;
	bh=imotwJ4gICaZ02FoqooFcZsxweEm3UFRbehyTXXWTKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KwOW7C4eLyL99DkyPP56tL/fgaPyB2oi15GcGOy6GLIzBoiuEd6gMrYbfV/rWxhvf
	 bnU1rFNoFH+uFS5kq3ranvcJHxjuNQxJDLUsT8twplfv1BdIICFFO2IBO4aA1mob3s
	 aUjEUzQzYbPsU3NeGqFFU0NIGR5J3XcTjR8qSsVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLIJol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 04:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfLIJoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 04:44:39 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AAD720726;
        Mon,  9 Dec 2019 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575884678;
        bh=imotwJ4gICaZ02FoqooFcZsxweEm3UFRbehyTXXWTKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SmMvhnhGIWsZOdi+RMzfniaJ+94EMedHgnL+d+RxHRwLvG+q+EihVC4tU2P5SmuRl
         J54YIH/aKb8LkZzI2HFd6+rwqAdD5cQoivfoINv1IwuAlfwXUzMPUmlaNy+Oq2Orgs
         Si257mCJ1/JWZj8r9K+/njClLcptsysHWwGBsvb8=
Date:   Mon, 9 Dec 2019 09:44:33 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, notify@kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2] Documentation/barriers/kokr: Remove references to
 [smp_]read_barrier_depends()
Message-ID: <20191209094432.GA3306@willie-the-truck>
References: <20191121193209.15687-1-sj38.park@gmail.com>
 <20191129180837.7233-1-sjpark@amazon.de>
 <CAEjAshpsnrfkb83738rtkPbQohoFP0LZbP_45rUqyBX-RvsVwg@mail.gmail.com>
 <20191206204406.GK2889@paulmck-ThinkPad-P72>
 <CAEjAshrGRafO4-k0tDD_XjC8EDq11AOh3PX+bPUhrjkuo+N76A@mail.gmail.com>
 <20191206220858.GL2889@paulmck-ThinkPad-P72>
 <CAEjAshosihoc7YR4WrseZDe_oquiJPeP+2yyCDRJuMJ4rzsp8w@mail.gmail.com>
 <20191206225156.GM2889@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206225156.GM2889@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:51:56PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 06, 2019 at 11:38:22PM +0100, SeongJae Park wrote:
> > On Fri, Dec 6, 2019 at 11:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > But since Jon seems to be taking these in his capacity and Documentation
> > > maintainer, could you please resend CCing him?  If we have these changes
> > > scattered across too many trees, someone is going to get confused,
> > > and it probably will be me.  ;-)
> > 
> > Agreed, CC-ing Jon to this mail.  That said, this is a followup of Will's
> > patch[1] and the patch is also not queued in Jon's tree.  So, I would like to
> > hear Will's opinion either, if possible.
> > 
> > [1]  https://lore.kernel.org/lkml/20191108170120.22331-10-will@kernel.org/
> 
> Ah, this one got caught out in the conversion from .html to .rst.
> 
> I did get an ack on one of those, and thus queued it.  I clearly need to
> take another look at Will's series, and thank you for the reminder!

I was planning to include this in the next posting of my series, but I was
waiting for the merge window to close first. Now that we have -rc1, I'll
post it this week, although the patches are also queued up in my tree here
[1] (warning -- rebasing development branch).

I'll leave the patches that are unrelated to smp_read_barrier_depends() to
Paul and Jon, unless they indicate a preference to the contrary.

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=lto
