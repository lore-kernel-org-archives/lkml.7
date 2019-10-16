Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62206FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D2E21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571226685;
	bh=s8NOvL9DXN6weIOAlSUiCZJ3zxOoC96KX0+xZ3xpWf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=huQyD4yLJndJfZzUVDt3Thb1IoJq43FUaueqzIM8Q0k9+reHZ/HVAnvjWINInS0nJ
	 8OHtY2JmQeFhGVQjvS3+BJDaVaquGi5xG31Assv4QbQpmvdJym9xiZwKpWVU36T/nV
	 TeF9dVzpRl/fGg1DRBczVoniqlChyl60NAZ81GTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391148AbfJPLvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:51:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391115AbfJPLvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:51:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2DC7B576;
        Wed, 16 Oct 2019 11:51:19 +0000 (UTC)
Date:   Wed, 16 Oct 2019 13:51:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/page_alloc: Add alloc_contig_pages()
Message-ID: <20191016115119.GA317@dhcp22.suse.cz>
References: <1571223765-10662-1-git-send-email-anshuman.khandual@arm.com>
 <40b8375c-5291-b477-1519-fd7fa799a67d@redhat.com>
 <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdcf77a5-e5c9-71ff-811d-ecd1c1e80f00@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 16:43:57, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 04:39 PM, David Hildenbrand wrote:
[...]
> > Just to make sure, you ignored my comment regarding alignment
> > although I explicitly mentioned it a second time? Thanks.
> 
> I had asked Michal explicitly what to be included for the respin. Anyways
> seems like the previous thread is active again. I am happy to incorporate
> anything new getting agreed on there.

Your patch is using the same alignment as the original code would do. If
an explicit alignement is needed then this can be added on top, right?
-- 
Michal Hocko
SUSE Labs
