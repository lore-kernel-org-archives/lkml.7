Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2AC21871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfCTIAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:00:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfCTIAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:00:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3235DC057F9A;
        Wed, 20 Mar 2019 08:00:14 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E0465D70A;
        Wed, 20 Mar 2019 08:00:11 +0000 (UTC)
Date:   Wed, 20 Mar 2019 16:00:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pasha.tatashin@oracle.com, mhocko@suse.com,
        rppt@linux.vnet.ibm.com, richard.weiyang@gmail.com,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190320080008.GK18740@MiWiFi-R3L-srv>
References: <20190320073540.12866-1-bhe@redhat.com>
 <20190320075058.GB13626@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320075058.GB13626@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 20 Mar 2019 08:00:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/19 at 09:50am, Mike Rapoport wrote:
> Hi,
> 
> On Wed, Mar 20, 2019 at 03:35:38PM +0800, Baoquan He wrote:
> > The code comment above sparse_add_one_section() is obsolete and
> > incorrect, clean it up and write new one.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 77a0554fa5bd..0a0f82c5d969 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -674,9 +674,12 @@ static void free_map_bootmem(struct page *memmap)
> >  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
> > 
> >  /*
> > - * returns the number of sections whose mem_maps were properly
> > - * set.  If this is <=0, then that means that the passed-in
> > - * map was not consumed and must be freed.
> > + * sparse_add_one_section - add a memory section
> 
> Please mention that this is only intended for memory hotplug

Will do. Thanks for reviewing.

> 
> > + * @nid:	The node to add section on
> > + * @start_pfn:	start pfn of the memory range
> > + * @altmap:	device page map
> > + *
> > + * Return 0 on success and an appropriate error code otherwise.
> 
> s/Return/Return:/ please

Thanks, will change.

> 
> >   */
> >  int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
> >  				     struct vmem_altmap *altmap)
> > -- 
> > 2.17.2
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 
