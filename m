Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4547BC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A24C20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfFFQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:56:26 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:56548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfFFQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:56:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 58A02180A8CDF;
        Thu,  6 Jun 2019 16:56:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nut86_1a1703edf4d45
X-Filterd-Recvd-Size: 3676
Received: from XPS-9350 (unknown [172.58.75.111])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Jun 2019 16:56:19 +0000 (UTC)
Message-ID: <8ce6c5322918828db16134b45d7b0d6b208f943d.camel@perches.com>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
From:   Joe Perches <joe@perches.com>
To:     Jerome Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
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
Date:   Thu, 06 Jun 2019 09:55:49 -0700
In-Reply-To: <20190606155213.GB8053@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
         <20190506232942.12623-3-rcampbell@nvidia.com>
         <20190606141644.GA2876@ziepe.ca> <20190606142743.GA8053@redhat.com>
         <20190606154129.GB17373@ziepe.ca> <20190606155213.GB8053@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 11:52 -0400, Jerome Glisse wrote:
> On Thu, Jun 06, 2019 at 12:41:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 06, 2019 at 10:27:43AM -0400, Jerome Glisse wrote:
> > > On Thu, Jun 06, 2019 at 11:16:44AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> > > > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > > > 
> > > > > There are no functional changes, just some coding style clean ups and
> > > > > minor comment changes.
> > > > > 
> > > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
> > > > >  mm/hmm.c            | 51 ++++++++++++++++----------------
> > > > >  2 files changed, 62 insertions(+), 60 deletions(-)
> > > > 
> > > > Applied to hmm.git, thanks
> > > 
> > > 
> > > Can you hold off, i was already collecting patches and we will
> > > be stepping on each other toe ... for instance i had
> > 
> > I'd really rather not, I have a lot of work to do for this cycle and
> > this part needs to start to move forward now. I can't do everything
> > last minute, sorry.
> > 
> > The patches I picked up all look very safe to move ahead.
> 
> I want to post all the patch you need to apply soon, it is really
> painful because they are lot of different branches i have to work
> with if you start pulling patches that differ from the below branch
> then you are making thing ever more difficult for me.
> 
> If you hold of i will be posting all the patches in one big set so
> that you can apply all of them in one go and it will be a _lot_
> easier for me that way.

Easier for you is not necessarily easier for a community.
Publish early and often.



