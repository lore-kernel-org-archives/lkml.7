Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B159DECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfJIGvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:51:18 -0400
Received: from verein.lst.de ([213.95.11.211]:50523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIGvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:51:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C056968B05; Wed,  9 Oct 2019 08:51:15 +0200 (CEST)
Date:   Wed, 9 Oct 2019 08:51:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191009065115.GB30157@lst.de>
References: <20191008143357.GA599223@rani.riverdale.lan> <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d680ab-a454-4a69-597a-c0edbfc5014b@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 10:45:15AM +0800, Lu Baolu wrote:
> Do you mind explaining why we always return 32 bit here?

See the comment in dma_get_required_mask().
