Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB6CC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DC221835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575556957;
	bh=FtTd8bVxAAjI67XfQn8v1CtQq1OrzGzVsHz99P5CJdo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EvXDy326h5mo5nbPpcDM1Xl1Tza4LTmr67oBAzRtFq44DFV+10ROomH7kSLG+pivz
	 figUB8Fd0Zmqge44DuLN7phxK69VlR4lA6maL8j9I510LzG9qC2O4+xGHO7iB9TTeR
	 mDegAJsHY1s/Trd6IQwYb5JHdWhwF/xk6xSJqhYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfLEOmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfLEOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:42:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57BE21835;
        Thu,  5 Dec 2019 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575556955;
        bh=FtTd8bVxAAjI67XfQn8v1CtQq1OrzGzVsHz99P5CJdo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wyB/qcr7cl/TP8lD54Vc7qc5PKSdWWbxLU/jD1ESiCX238PRKuX2vUf5uT872/UqM
         8v8DKdfIwCLe+OqlL6CjnaicKcl7FMooslC4nu8T0GcDWyRHyoZTnsrWSOhiB6t7do
         EsVLSL1biRboSkS8IPxWZn4JS7A15urYFkuSF+6k=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7A49E35202C9; Thu,  5 Dec 2019 06:42:35 -0800 (PST)
Date:   Thu, 5 Dec 2019 06:42:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Include: Linux: rculist_nulls: Add docbook comment
 headers
Message-ID: <20191205144235.GQ2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191204120357.11658-1-madhuparnabhowmik04@gmail.com>
 <20191205002518.GP2889@paulmck-ThinkPad-P72>
 <CAF65HP1WL2yw8nVZi-j9=eehkUJP-eKUy+w9unFXddmPf7_Hqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF65HP1WL2yw8nVZi-j9=eehkUJP-eKUy+w9unFXddmPf7_Hqg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:25:39AM +0530, Madhuparna Bhowmik wrote:
> On Thu, Dec 5, 2019 at 5:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > On Wed, Dec 04, 2019 at 05:33:57PM +0530, madhuparnabhowmik04@gmail.com
> > wrote:
> > > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > >
> > > This patch adds docbook comment headers for hlist_nulls_first_rcu
> > > and hlist_nulls_next_rcu in rculist_nulls.h.
> > >
> > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > > ---
> >
> > Good to see, thank you!  A few grammar nits below -- could you please
> > update and re-send?
> >
> > Thank you, I will send the updated patch soon.
> 
> 
> >                                                         Thanx, Paul
> >
> > >  include/linux/rculist_nulls.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/linux/rculist_nulls.h
> > b/include/linux/rculist_nulls.h
> > > index 517a06f36c7a..d796ef18ec52 100644
> > > --- a/include/linux/rculist_nulls.h
> > > +++ b/include/linux/rculist_nulls.h
> > > @@ -38,9 +38,17 @@ static inline void hlist_nulls_del_init_rcu(struct
> > hlist_nulls_node *n)
> > >       }
> > >  }
> > >
> > > +/**
> > > + * hlist_nulls_first_rcu - returns the first element of the hash list.
> > > + * @head: the head for your list.
> >
> > Could you please say something like "The head of the list."?
> > Just to keep point of view more consistent through the documentation.
> >
> > Sure, I will change it to "head of the list".
> Moreover, in the rest of the docbook comments in the same file
> (rculist_nulls.h), "head for your list" is used.
> So, should I change that as well in a separate patch, such that it is
> consistent throughout the file?

Please do!

						Thanx, Paul

> > > + */
> > >  #define hlist_nulls_first_rcu(head) \
> > >       (*((struct hlist_nulls_node __rcu __force **)&(head)->first))
> > >
> > > +/**
> > > + * hlist_nulls_next_rcu - returns the element of the list next to @node.
> >
> > Here, could you please change "next to" to "after"?  This removes the
> > ambiguity where both the prior and the subsequent elements might be
> > thought of as "next to".
> >
> > Sure, I will do it. Thank you for pointing out.
> 
> Regards,
> Madhuparna
> 
> 
> > > + * @node: Element of the list.
> > > + */
> > >  #define hlist_nulls_next_rcu(node) \
> > >       (*((struct hlist_nulls_node __rcu __force **)&(node)->next))
> > >
> > > --
> > > 2.17.1
> > >
> >
> ᐧ
