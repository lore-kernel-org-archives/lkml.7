Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B42C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F31020854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfCSQ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:58:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbfCSQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F9E870D63;
        Tue, 19 Mar 2019 16:58:06 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD11060856;
        Tue, 19 Mar 2019 16:58:04 +0000 (UTC)
Date:   Tue, 19 Mar 2019 12:58:02 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190319165802.GA3656@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com>
 <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Mar 2019 16:58:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:40:07AM -0700, Andrew Morton wrote:
> On Mon, 18 Mar 2019 13:04:04 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> 
> > On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> > > On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > > 
> > > > Andrew you will not be pushing this patchset in 5.1 ?
> > > 
> > > I'd like to.  It sounds like we're converging on a plan.
> > > 
> > > It would be good to hear more from the driver developers who will be
> > > consuming these new features - links to patchsets, review feedback,
> > > etc.  Which individuals should we be asking?  Felix, Christian and
> > > Jason, perhaps?
> > > 
> > 
> > So i am guessing you will not send this to Linus ?
> 
> I was waiting to see how the discussion proceeds.  Was also expecting
> various changelog updates (at least) - more acks from driver
> developers, additional pointers to client driver patchsets, description
> of their readiness, etc.

nouveau will benefit from this patchset and is already upstream in 5.1
so i am not sure what kind of pointer i can give for that, it is already
there. amdgpu will also benefit from it and is queue up AFAICT. ODP RDMA
is the third driver and i gave link to the patch that also use the 2
new functions that this patchset introduce. Do you want more ?

I guess i will repost with updated ack as Felix, Jason and few others
told me they were fine with it.

> 
> Today I discover that Alex has cherrypicked "mm/hmm: use reference
> counting for HMM struct" into a tree which is fed into linux-next which
> rather messes things up from my end and makes it hard to feed a
> (possibly modified version of) that into Linus.

:( i did not know the tree they pull that in was fed into next. I will
discourage them from doing so going forward.

> So I think I'll throw up my hands, drop them all and shall await
> developments :(

What more do you want to see ? I can repost with the ack already given
and the improve commit wording on some of the patch. But from user point
of view nouveau is already upstream, ODP RDMA depends on this patchset
and is posted and i have given link to it. amdgpu is queue up. What more
do i need ?

Cheers,
Jérôme
