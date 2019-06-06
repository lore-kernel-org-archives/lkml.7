Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C49C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF93207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfFFPwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:52:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729156AbfFFPwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:52:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FBCF88E57;
        Thu,  6 Jun 2019 15:52:21 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 344227BE8E;
        Thu,  6 Jun 2019 15:52:15 +0000 (UTC)
Date:   Thu, 6 Jun 2019 11:52:13 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     rcampbell@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
Message-ID: <20190606155213.GB8053@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-3-rcampbell@nvidia.com>
 <20190606141644.GA2876@ziepe.ca>
 <20190606142743.GA8053@redhat.com>
 <20190606154129.GB17373@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190606154129.GB17373@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 06 Jun 2019 15:52:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 12:41:29PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 10:27:43AM -0400, Jerome Glisse wrote:
> > On Thu, Jun 06, 2019 at 11:16:44AM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> > > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > > 
> > > > There are no functional changes, just some coding style clean ups and
> > > > minor comment changes.
> > > > 
> > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > >  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
> > > >  mm/hmm.c            | 51 ++++++++++++++++----------------
> > > >  2 files changed, 62 insertions(+), 60 deletions(-)
> > > 
> > > Applied to hmm.git, thanks
> > 
> > Can you hold off, i was already collecting patches and we will
> > be stepping on each other toe ... for instance i had
> 
> I'd really rather not, I have a lot of work to do for this cycle and
> this part needs to start to move forward now. I can't do everything
> last minute, sorry.
> 
> The patches I picked up all look very safe to move ahead.

I want to post all the patch you need to apply soon, it is really
painful because they are lot of different branches i have to work
with if you start pulling patches that differ from the below branch
then you are making thing ever more difficult for me.

If you hold of i will be posting all the patches in one big set so
that you can apply all of them in one go and it will be a _lot_
easier for me that way.

> 
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.3
> 
> I'm aware, and am referring to this tree. You can trivially rebase it
> on top of hmm.git..
> 
> BTW, what were you planning to do with this git branch anyhow?

This is just something i use to do testing and stack-up all patches.

> 
> As we'd already agreed I will send the hmm patches to Linus on a clean
> git branch so we can properly collaborate between the various involved
> trees.
> 
> As a tree-runner I very much prefer to take patches directly from the
> mailing list where everything is public. This is the standard kernel
> workflow.

Like i said above i want to resend all the patches in one big set.

On process thing it would be easier if we ask Dave/Daniel to merge
hmm within drm this cycle. Merging with Linus will break drm drivers
and it seems easier to me to fix all this within the drm tree.

But if you want to do everything with Linus fine.

Cheers,
Jérôme
