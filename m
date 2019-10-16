Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA135FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FAF2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571222000;
	bh=EbrxeaPNAlAguwQQl7WYa3PEV44S2l+JJ5C4oGRTxEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G2W8ia8byHb5CGAwLSkR1FZpm9St5T+KUygDFCr8vBq8FXsXppWx047Q9tJM+xlY4
	 WjcFbg94FdTrXzz/slO4wGaULFH2Xfsz1GZDfgn22QQm4ywa6gLY2BjVK0zFZInLXy
	 bSflRF8DorDgoIKeY0TE4V/KVjnLlBuIy8H4Rv/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404655AbfJPKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:33:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:58926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbfJPKdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27A56B266;
        Wed, 16 Oct 2019 10:33:17 +0000 (UTC)
Date:   Wed, 16 Oct 2019 12:33:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
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
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Make alloc_gigantic_page() available for
 general use
Message-ID: <20191016103315.GR317@dhcp22.suse.cz>
References: <1571211293-29974-1-git-send-email-anshuman.khandual@arm.com>
 <20191016085839.GP317@dhcp22.suse.cz>
 <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c344224c-e8ae-ccea-911b-2d08f257b6f4@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16-10-19 15:58:32, Anshuman Khandual wrote:
> 
> 
> On 10/16/2019 02:28 PM, Michal Hocko wrote:
[...]
> > After other issues mentioned by David get resolved you can add
> 
> Just to confirm. Only the styling issues, right ? pfn_range_valid_contig(),
> pfn alignment and zone scanning all remain the same like before ?

Yes, if they need any special handling then let's do it in a separate
patch with a proper justification.
-- 
Michal Hocko
SUSE Labs
