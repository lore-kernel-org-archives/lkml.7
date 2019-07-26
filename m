Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDFCC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F01C217D4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfGZGZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:25:07 -0400
Received: from verein.lst.de ([213.95.11.211]:41766 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZGZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:25:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A2F9468B02; Fri, 26 Jul 2019 08:25:04 +0200 (CEST)
Date:   Fri, 26 Jul 2019 08:25:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Jason Gunthorpe <jgg@mellanox.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 7/7] mm/hmm: remove hmm_range vma
Message-ID: <20190726062504.GD22881@lst.de>
References: <20190726005650.2566-1-rcampbell@nvidia.com> <20190726005650.2566-8-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726005650.2566-8-rcampbell@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:56:50PM -0700, Ralph Campbell wrote:
> Since hmm_range_fault() doesn't use the struct hmm_range vma field,
> remove it.
> 
> Suggested-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
