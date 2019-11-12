Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD7BC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB6A2084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573565804;
	bh=XX3XVc0MSDw2E2A+jg5k1cCET51VCwMRMUCwPHmsBSI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=P1tVH/194ZL4AXEHMJdCPMWA2EbAkvoJI6SXKD8DiL2/3/zEsOwFhld9IqW0TiqaX
	 0KUV2QxrvOWFe1D+HwNkypQXV6rsas+r/mUjXK8BMDwijFABM9hBE24KHTHOvcEfa+
	 KyrnU3I1lcM338hUIK9AESrwAkh38YLghKt+ewGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKLNgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:36:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfKLNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:36:43 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BA82084F;
        Tue, 12 Nov 2019 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573565801;
        bh=XX3XVc0MSDw2E2A+jg5k1cCET51VCwMRMUCwPHmsBSI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kRFGLFQm98n3Dh5st1Un9FmTwKGuS/oC8M6kYI6gcKdAvKVz9g4h8Yk8EZLNOSrZ2
         OT/Fh0FSf79qYiSVQlmhZ1iPO68cUOFjZ0CFDjqJp0C8isui1WOJUthuSjJIRcOI5c
         IOFa5bgdxWLPl1HKUzlSax11Xc10jTIRkXfiq+Ks=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AEF0235227E6; Tue, 12 Nov 2019 05:36:41 -0800 (PST)
Date:   Tue, 12 Nov 2019 05:36:41 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, mchehab@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] Documentation: RCU: whatisRCU:
 Updated full list of RCU API
Message-ID: <20191112133641.GQ2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191111181122.28083-1-madhuparnabhowmik04@gmail.com>
 <CAD3AR6E486EAJ5EW_Wr4qiPeZU_M7TnDTC0g-CB+=6ob9Ru6mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD3AR6E486EAJ5EW_Wr4qiPeZU_M7TnDTC0g-CB+=6ob9Ru6mQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 07:03:10AM +0700, Phong Tran wrote:
> On Tue, Nov 12, 2019 at 1:12 AM <madhuparnabhowmik04@gmail.com> wrote:
> >
> > From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> >
> > This patch updates the list of RCU API in whatisRCU.rst.
> 
> Tested-by: Phong Tran <tranmanphong@gmail.com>

Applied, thanks to all three of you!

							Thanx, Paul

> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> > ---
> >  Documentation/RCU/whatisRCU.rst | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> > index 2f6f6ebbc8b0..c7f147b8034f 100644
> > --- a/Documentation/RCU/whatisRCU.rst
> > +++ b/Documentation/RCU/whatisRCU.rst
> > @@ -884,11 +884,14 @@ in docbook.  Here is the list, by category.
> >  RCU list traversal::
> >
> >         list_entry_rcu
> > +       list_entry_lockless
> >         list_first_entry_rcu
> >         list_next_rcu
> >         list_for_each_entry_rcu
> >         list_for_each_entry_continue_rcu
> >         list_for_each_entry_from_rcu
> > +       list_first_or_null_rcu
> > +       list_next_or_null_rcu
> >         hlist_first_rcu
> >         hlist_next_rcu
> >         hlist_pprev_rcu
> > @@ -902,7 +905,7 @@ RCU list traversal::
> >         hlist_bl_first_rcu
> >         hlist_bl_for_each_entry_rcu
> >
> > -RCU pointer/list udate::
> > +RCU pointer/list update::
> >
> >         rcu_assign_pointer
> >         list_add_rcu
> > @@ -912,10 +915,12 @@ RCU pointer/list udate::
> >         hlist_add_behind_rcu
> >         hlist_add_before_rcu
> >         hlist_add_head_rcu
> > +       hlist_add_tail_rcu
> >         hlist_del_rcu
> >         hlist_del_init_rcu
> >         hlist_replace_rcu
> > -       list_splice_init_rcu()
> > +       list_splice_init_rcu
> > +       list_splice_tail_init_rcu
> >         hlist_nulls_del_init_rcu
> >         hlist_nulls_del_rcu
> >         hlist_nulls_add_head_rcu
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
