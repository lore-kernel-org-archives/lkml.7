Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB616C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B835206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 07:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAHHMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 02:12:00 -0500
Received: from verein.lst.de ([213.95.11.211]:47812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgAHHL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 02:11:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 66A1468BFE; Wed,  8 Jan 2020 08:11:57 +0100 (CET)
Date:   Wed, 8 Jan 2020 08:11:57 +0100
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
Subject: Re: [PATCH 2/3] mm/migrate: clean up some minor coding style
Message-ID: <20200108071157.GB3068@lst.de>
References: <20200107211208.24595-1-rcampbell@nvidia.com> <20200107211208.24595-3-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107211208.24595-3-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 01:12:07PM -0800, Ralph Campbell wrote:
> Fix some comment typos and coding style clean up in preparation for the
> next patch. No functional changes.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
