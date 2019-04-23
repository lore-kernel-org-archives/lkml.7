Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C353C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E7A20675
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfDWNRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:17:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:60998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfDWNRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:17:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A81EABB1;
        Tue, 23 Apr 2019 13:17:15 +0000 (UTC)
Message-ID: <1556025416.2956.0.camel@suse.de>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
From:   Oscar Salvador <osalvador@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Apr 2019 15:16:56 +0200
In-Reply-To: <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
         <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-17 at 15:59 -0700, Dan Williams wrote:
> On Wed, Apr 17, 2019 at 3:04 PM Andrew Morton <akpm@linux-foundation.
> org> wrote:
> > 
> > On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@int
> > el.com> wrote:
> > 
> > > The memory hotplug section is an arbitrary / convenient unit for
> > > memory
> > > hotplug. 'Section-size' units have bled into the user interface
> > > ('memblock' sysfs) and can not be changed without breaking
> > > existing
> > > userspace. The section-size constraint, while mostly benign for
> > > typical
> > > memory hotplug, has and continues to wreak havoc with 'device-
> > > memory'
> > > use cases, persistent memory (pmem) in particular. Recall that
> > > pmem uses
> > > devm_memremap_pages(), and subsequently arch_add_memory(), to
> > > allocate a
> > > 'struct page' memmap for pmem. However, it does not use the
> > > 'bottom
> > > half' of memory hotplug, i.e. never marks pmem pages online and
> > > never
> > > exposes the userspace memblock interface for pmem. This leaves an
> > > opening to redress the section-size constraint.
> > 
> > v6 and we're not showing any review activity.  Who would be
> > suitable
> > people to help out here?
> 
> There was quite a bit of review of the cover letter from Michal and
> David, but you're right the details not so much as of yet. I'd like
> to
> call out other people where I can reciprocate with some review of my
> own. Oscar's altmap work looks like a good candidate for that.

Thanks Dan for ccing me.
I will take a look at the patches soon.

-- 
Oscar Salvador
SUSE L3
