Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8249F2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1Orc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:47:32 -0400
Received: from verein.lst.de ([213.95.11.211]:38142 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfH1Orc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:47:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA2F368B05; Wed, 28 Aug 2019 16:47:28 +0200 (CEST)
Date:   Wed, 28 Aug 2019 16:47:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH] mm: remove the
 __mmu_notifier_invalidate_range_start/end exports
Message-ID: <20190828144728.GA30428@lst.de>
References: <20190828142109.29012-1-hch@lst.de> <20190828144020.GI914@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828144020.GI914@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 02:40:25PM +0000, Jason Gunthorpe wrote:
> EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
> 
> elixir suggest this is not called outside mm/ either?

Yes, it seems like that one should go away as well.
