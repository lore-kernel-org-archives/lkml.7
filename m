Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2EDC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAB120693
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="Fj4O1eqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIBIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:08:41 -0400
Received: from owa.iluvatar.ai ([103.91.158.24]:5253 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbfDIBIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:08:40 -0400
X-AuditID: 0a650161-78bff700000078a3-8f-5cabf093b18d
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id 06.44.30883.390FBAC5; Tue,  9 Apr 2019 09:08:35 +0800 (HKT)
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1554772115; h=from:subject:to:date:message-id;
        bh=7PoxFksW/7Y5mrW/Yb3Kse3GMSMGjxnGjzU1zXRdg8I=;
        b=Fj4O1eqLq9eKptCrCrpUPwnVDMk/Bcb81pxPlkLUsXqS951w230uGx869AGQh+OKFwcd7xE4amB
        QE8j8AJ/1tRPncTNw/YMemB4TG8C3Fvuqe/Ub3CJOBuYz0h5FHNOIEgIrnwOEoTa0baTlQrNSEwWR
        l5d7WBuX91Fqq4b1Flo=
Received: from hsj-Precision-5520 (10.101.199.253) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 9 Apr 2019 09:08:35 +0800
Date:   Tue, 9 Apr 2019 09:08:33 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <william.kucharski@oracle.com>,
        <ira.weiny@intel.com>, <palmer@sifive.com>, <axboe@kernel.dk>,
        <keescook@chromium.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190409010832.GA28081@hsj-Precision-5520>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20190408141313.GU22763@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.101.199.253]
X-ClientProxiedBy: S-10-101-1-102.iluvatar.local (10.101.1.102) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsXClcqYpjv5w+oYg7ufDSzmrF/DZrH6bj+b
        xf6nz1ksznTnWlzeNYfN4t6a/6wWmycsABKLu5gsfv+Yw+bA6TG74SKLx+YVWh6L97xk8rh8
        ttRj06dJ7B4nZvxm8fj49BaLx6Xm6+wenzfJBXBGcdmkpOZklqUW6dslcGWsejaBueCtQMWZ
        e5eZGhiX8nQxcnJICJhITP28jLWLkYtDSOAEo8Tl+50sIAlmAR2JBbs/sXUxcgDZ0hLL/3GA
        1LAIvGWSuP3vBTtEwzdGib377rKDNLAIqEgse/wXzGYT0JCYe+IuM0izCJD9ZosRSD2zwEVG
        iQ0zjoMtEBawlFjXfQysnlfAXGLHk7lsILaQQJbEsZ7HzBBxQYmTM5+A1XMK2EjsXriJCcQW
        FVCWOLDtOBPIfCEBBYkXK7UgnlGSWLJ3FhOEXSjx/eVdlgmMwrOQvDML4Z1ZSBYsYGRexchf
        nJuul5lTWpZYklikl5i5iRESVYk7GG90vtQ7xCjAwajEw6vguDpGiDWxrLgy9xCjBAezkgjv
        zqmrYoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzlk00iRESSE8sSc1OTS1ILYLJMnFwSjUwJc7U
        m8r46sXv7J3/Y4Oa6lQ8HRnNzsgGPzm9uWRz8O3Jc80mcEw7flz22iQzSw826yzFnUeaZ+Zr
        FCj9DoxnZFlxmLf16HU7v9Sjgnc/BsTO6V7EejBijpeN2vXIslt+Ke9/1GmbTb06qXyBl0b/
        szsGmc/Xdcelr5oatfPwhafuv/Rue6zm/bP7QHfFz42eftlPileFLax5oLR7Rg93lu2WpwfW
        rVTyCuermLxP6Jm2w2EvsbjLPUFd1/RubGWs9rmxsu/z1OuNArusb/GFl7B88rj5Km/y+9My
        /5/O5FvVv/jyialzTZev/9RWwbnm3P0qWZZ9N0RmfXGuf/b+0zWuk3bhE7yCjbkmfcxhmKPE
        UpyRaKjFXFScCADnserWJwMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > When CONFIG_HAVE_GENERIC_GUP is defined, the kernel will use its own
> > get_user_pages_fast().
> > 
> > In the following scenario, we will may meet the bug in the DMA case:
> > 	    .....................
> > 	    get_user_pages_fast(start,,, pages);
> > 	        ......
> > 	    sg_alloc_table_from_pages(, pages, ...);
> > 	    .....................
> > 
> > The root cause is that sg_alloc_table_from_pages() requires the
> > page order to keep the same as it used in the user space, but
> > get_user_pages_fast() will mess it up.
> 
> I don't understand how get_user_pages_fast() can return the pages in a
> different order in the array from the order they appear in userspace.
> Can you explain?
Please see the code in gup.c:

	int get_user_pages_fast(unsigned long start, int nr_pages,
				unsigned int gup_flags, struct page **pages)
	{
		.......
		if (gup_fast_permitted(start, nr_pages)) {
			local_irq_disable();
			gup_pgd_range(addr, end, gup_flags, pages, &nr);               // The @pages array maybe filled at the first time.
			local_irq_enable();
			ret = nr;
		}
		.......
		if (nr < nr_pages) {
			/* Try to get the remaining pages with get_user_pages */
			start += nr << PAGE_SHIFT;
			pages += nr;                                                  // The @pages is moved forward.

			if (gup_flags & FOLL_LONGTERM) {
				down_read(&current->mm->mmap_sem);
				ret = __gup_longterm_locked(current, current->mm,      // The @pages maybe filled at the second time
							    start, nr_pages - nr,
							    pages, NULL, gup_flags);
				up_read(&current->mm->mmap_sem);
			} else {
				/*
				 * retain FAULT_FOLL_ALLOW_RETRY optimization if
				 * possible
				 */
				ret = get_user_pages_unlocked(start, nr_pages - nr,    // The @pages maybe filled at the second time.
							      pages, gup_flags);
			}
		}


		.....................

BTW, I do not know why we mess up the page order. It maybe used in some special case.

Thanks
Huang Shijie
