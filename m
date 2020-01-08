Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58466C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393DA206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgAHHMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:12:47 -0500
Received: from verein.lst.de ([213.95.11.211]:47823 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgAHHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:12:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E17B68BFE; Wed,  8 Jan 2020 08:12:45 +0100 (CET)
Date:   Wed, 8 Jan 2020 08:12:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/migrate: add stable check in
 migrate_vma_insert_page()
Message-ID: <20200108071245.GC3068@lst.de>
References: <20200107211208.24595-1-rcampbell@nvidia.com> <20200107211208.24595-4-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107211208.24595-4-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:12:08PM -0800, Ralph Campbell wrote:
> migrate_vma_insert_page() closely follows the code in:
>   __handle_mm_fault()
>     handle_pte_fault()
>       do_anonymous_page()

I wonder if we could share more code there?

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
