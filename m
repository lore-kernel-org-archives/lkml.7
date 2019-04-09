Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBFDC10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADF820883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Icf5Z+Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDIDEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:04:25 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5255 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfDIDEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:04:25 -0400
X-AuditID: 0a650161-78bff700000078a3-ba-5cac0bb4f71c
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id C0.64.30883.4BB0CAC5; Tue,  9 Apr 2019 11:04:20 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554779060; h=from:subject:to:date:message-id;
        bh=XCvCiL37W5XW4bkYbgyGsUhyFfYmLTpkuWZ3Cpm5jks=;
        b=Icf5Z+Q01cvzcZ7vZhssppW9D6x0aQHpeVzdLw9NbZRCdZtffiSzQDx6XPkdqqmWPApbMsQNvbc
        ubo2xAis69pAI21zQerkgM7XrhwU78oxG8Yjllqo2c9kzshySVFda+fvaj+BhDlgpQ/oqxUW1+WNA
        8ZYnn8rzbZWEhGYO+zI=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 9 Apr 2019 11:04:19 +0800
Date:   Tue, 9 Apr 2019 11:04:18 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <william.kucharski@oracle.com>,
        <ira.weiny@intel.com>, <palmer@sifive.com>, <axboe@kernel.dk>,
        <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190409030417.GA3324@hsj-Precision-5520>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
 <20190409024929.GW22763@bombadil.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20190409024929.GW22763@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsXClcqYpruFe02MwdOzmhZz1q9hs1h9t5/N
        Yv/T5ywWZ7pzLS7vmsNmcW/Nf1aLzRMWAInFXUwWv3/MYXPg9JjdcJHFY/MKLY/Fe14yeVw+
        W+qx6dMkdo8TM36zeHx8eovF41LzdXaPz5vkAjijuGxSUnMyy1KL9O0SuDIOntnEWHBApOLg
        3MQGxid8XYycHBICJhK3uhYxdjFycQgJnGCUOPT0NytIgllAR2LB7k9sXYwcQLa0xPJ/HCA1
        LAJvmSRe7j3FCFIjJPCNUWLhbWuQGhYBFYn9B01BwmwCGhJzT9xlBgmLANlvthiBtDILXGSU
        2DDjOAtIjbCApcS67mPsIDavgJnEmv1PWSBuOMUosWbrdCaIhKDEyZlPwBo4BWwkznxsYAOx
        RQWUJQ5sO84EskBIQEHixUotiF+UJJbsncUEYRdKfH95l2UCo/AsJN/MQvhmFpIFCxiZVzHy
        F+em62XmlJYlliQW6SVmbmKERFTiDsYbnS/1DjEKcDAq8fAqOK6OEWJNLCuuzD3EKMHBrCTC
        u3Pqqhgh3pTEyqrUovz4otKc1OJDjNIcLErivGUTTWKEBNITS1KzU1MLUotgskwcnFINTI92
        lno9Wb1np4ignf+3W1q3kvWCH7GkSDzftOnS2a3rHh934KwU6+2fqnXDIeDmL9+8J9OM/mad
        4GjdcbVCxNLlSfE/WWWFlHt7b1d99tD/EsdcwJoasPf4dJ7lTxfmhj2TZPg6vzLxwONa++Mi
        Ei9+HGn1kd78z6T3go1g1oqlG+dueZ7gtettBHvb/E1nxf9+mtge8kFp55TjXNM+7OmpuzJV
        e99C/TVPwiZ1OuhfTGd9o7PnXtbX4yWtXzrebfW88fKinIzTy7Vvq5ZLRHxYLfR72q7VPduz
        e84cUVxjoD7jpwiH1JMPov/eGE//IHmJ89zOmezp0imXXwdUKfac9VJcVvMjI8L+xpzDVRNe
        K7EUZyQaajEXFScCANDZWEQlAwAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:49:29PM -0700, Matthew Wilcox wrote:
> On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> > On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > > The root cause is that sg_alloc_table_from_pages() requires the
> > > > page order to keep the same as it used in the user space, but
> > > > get_user_pages_fast() will mess it up.
> > > 
> > > I don't understand how get_user_pages_fast() can return the pages in a
> > > different order in the array from the order they appear in userspace.
> > > Can you explain?
> > Please see the code in gup.c:
> > 
> > 	int get_user_pages_fast(unsigned long start, int nr_pages,
> > 				unsigned int gup_flags, struct page **pages)
> > 	{
> > 		.......
> > 		if (gup_fast_permitted(start, nr_pages)) {
> > 			local_irq_disable();
> > 			gup_pgd_range(addr, end, gup_flags, pages, &nr);               // The @pages array maybe filled at the first time.
> 
> Right ... but if it's not filled entirely, it will be filled part-way,
> and then we stop.
> 
> > 			local_irq_enable();
> > 			ret = nr;
> > 		}
> > 		.......
> > 		if (nr < nr_pages) {
> > 			/* Try to get the remaining pages with get_user_pages */
> > 			start += nr << PAGE_SHIFT;
> > 			pages += nr;                                                  // The @pages is moved forward.
> 
> Yes, to the point where gup_pgd_range() stopped.
> 
> > 			if (gup_flags & FOLL_LONGTERM) {
> > 				down_read(&current->mm->mmap_sem);
> > 				ret = __gup_longterm_locked(current, current->mm,      // The @pages maybe filled at the second time
> 
> Right.
> 
> > 				/*
> > 				 * retain FAULT_FOLL_ALLOW_RETRY optimization if
> > 				 * possible
> > 				 */
> > 				ret = get_user_pages_unlocked(start, nr_pages - nr,    // The @pages maybe filled at the second time.
> > 							      pages, gup_flags);
> 
> Yes.  But they'll be in the same order.
> 
> > BTW, I do not know why we mess up the page order. It maybe used in some special case.
> 
> I'm not discounting the possibility that you've found a bug.
> But documenting that a bug exists is not the solution; the solution is
> fixing the bug.
I do not think it is a bug :)

If we use the get_user_pages_unlocked(), DMA is okay, such as:
                     ....
		     get_user_pages_unlocked()
		     sg_alloc_table_from_pages()
	             .....

I think the comment is not accurate enough. So just add more comments, and tell the driver
users how to use the GUPs.

Thanks
Huang Shijie
