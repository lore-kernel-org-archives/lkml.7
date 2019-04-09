Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40809C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D4F20674
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDIOze convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:55:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:57918 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfDIOze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:55:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 07:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="129878638"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 09 Apr 2019 07:55:33 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 9 Apr 2019 07:55:33 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 9 Apr 2019 07:55:33 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.94]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.179]) with mapi id 14.03.0415.000;
 Tue, 9 Apr 2019 08:55:31 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Huang Shijie <sjhuang@iluvatar.ai>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mm/gup.c: fix the wrong comments
Thread-Topic: [PATCH 1/2] mm/gup.c: fix the wrong comments
Thread-Index: AQHU7bQlN2diAK7eV0icdWdVKwXx36Yys5SAgAC3GYCAABwzgIAABCQAgACKPoD//9cAcA==
Date:   Tue, 9 Apr 2019 14:55:31 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79CA51BA@CRSMSX101.amr.corp.intel.com>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
 <20190409024929.GW22763@bombadil.infradead.org>
 <20190409030417.GA3324@hsj-Precision-5520>
 <20190409111905.GY22763@bombadil.infradead.org>
In-Reply-To: <20190409111905.GY22763@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzRhODcyZmYtMzU1Yi00NzdjLTk0ODItMzE5OTNlNDc2YmY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoianRaRFRkODRvY1wvbGYyQzVXQzNsSmE1SlwvVW9qOWlhSHlBcWNLQUlCeCtmaGpGcHdOMmVxdjY2Z3hIejBPU0tPIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Apr 09, 2019 at 11:04:18AM +0800, Huang Shijie wrote:
> > On Mon, Apr 08, 2019 at 07:49:29PM -0700, Matthew Wilcox wrote:
> > > On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> > > > On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > > > > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > > > > The root cause is that sg_alloc_table_from_pages() requires
> > > > > > the page order to keep the same as it used in the user space,
> > > > > > but
> > > > > > get_user_pages_fast() will mess it up.
> > > > >
> > > > > I don't understand how get_user_pages_fast() can return the
> > > > > pages in a different order in the array from the order they appear in
> userspace.
> > > > > Can you explain?
> > > > Please see the code in gup.c:
> > > >
> > > > 	int get_user_pages_fast(unsigned long start, int nr_pages,
> > > > 				unsigned int gup_flags, struct page **pages)
> > > > 	{
> > > > 		.......
> > > > 		if (gup_fast_permitted(start, nr_pages)) {
> > > > 			local_irq_disable();
> > > > 			gup_pgd_range(addr, end, gup_flags, pages, &nr);
> // The @pages array maybe filled at the first time.
> > >
> > > Right ... but if it's not filled entirely, it will be filled
> > > part-way, and then we stop.
> > >
> > > > 			local_irq_enable();
> > > > 			ret = nr;
> > > > 		}
> > > > 		.......
> > > > 		if (nr < nr_pages) {
> > > > 			/* Try to get the remaining pages with
> get_user_pages */
> > > > 			start += nr << PAGE_SHIFT;
> > > > 			pages += nr;                                                  // The
> @pages is moved forward.
> > >
> > > Yes, to the point where gup_pgd_range() stopped.
> > >
> > > > 			if (gup_flags & FOLL_LONGTERM) {
> > > > 				down_read(&current->mm->mmap_sem);
> > > > 				ret = __gup_longterm_locked(current,
> current->mm,      // The @pages maybe filled at the second time
> > >
> > > Right.
> > >
> > > > 				/*
> > > > 				 * retain FAULT_FOLL_ALLOW_RETRY
> optimization if
> > > > 				 * possible
> > > > 				 */
> > > > 				ret = get_user_pages_unlocked(start,
> nr_pages - nr,    // The @pages maybe filled at the second time.
> > > > 							      pages, gup_flags);
> > >
> > > Yes.  But they'll be in the same order.
> > >
> > > > BTW, I do not know why we mess up the page order. It maybe used in
> some special case.
> > >
> > > I'm not discounting the possibility that you've found a bug.
> > > But documenting that a bug exists is not the solution; the solution
> > > is fixing the bug.
> > I do not think it is a bug :)
> >
> > If we use the get_user_pages_unlocked(), DMA is okay, such as:
> >                      ....
> > 		     get_user_pages_unlocked()
> > 		     sg_alloc_table_from_pages()
> > 	             .....
> >
> > I think the comment is not accurate enough. So just add more comments,
> > and tell the driver users how to use the GUPs.
> 
> gup_fast() and gup_unlocked() should return the pages in the same order.
> If they do not, then it is a bug.

Is there a reproducer for this?  Or do you have some debug output which shows this problem?

Ira

