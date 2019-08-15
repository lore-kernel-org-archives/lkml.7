Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63608C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43961208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfHON2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:28:49 -0400
Received: from verein.lst.de ([213.95.11.211]:46712 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHON2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:28:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D963768B05; Thu, 15 Aug 2019 15:28:45 +0200 (CEST)
Date:   Thu, 15 Aug 2019 15:28:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: turn hmm migrate_vma upside down v3
Message-ID: <20190815132845.GC12036@lst.de>
References: <20190814075928.23766-1-hch@lst.de> <8e3b17ef-0b9e-6866-128f-403c8ba3a322@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3b17ef-0b9e-6866-128f-403c8ba3a322@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 05:09:54PM -0700, Ralph Campbell wrote:
> Some of the patches seem to have been mangled in the mail.

Weird, I never had such a an issue with git-send-email.

But to be covered for such weird cases I also posted a git url
for exactly the tree I've been working on.

> I was able to edit them and apply to Jason's tree
> https://github.com/jgunthorpe/linux.git mmu_notifier branch.
> So for the series you can add:
>
> Tested-by: Ralph Campbell <rcampbell@nvidia.com>

Thanks!
