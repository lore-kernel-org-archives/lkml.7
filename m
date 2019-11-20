Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D9AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7777206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfKTKoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:44:00 -0500
Received: from verein.lst.de ([213.95.11.211]:39415 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfKTKn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:43:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 329EE68AFE; Wed, 20 Nov 2019 11:43:57 +0100 (CET)
Date:   Wed, 20 Nov 2019 11:43:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dma-debug: clean up put_hash_bucket()
Message-ID: <20191120104357.GA3800@lst.de>
References: <20191119061819.k6754frfv2wj7swd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119061819.k6754frfv2wj7swd@kili.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 09:18:19AM +0300, Dan Carpenter wrote:
> The put_hash_bucket() is a bit cleaner if it takes an unsigned long
> directly instead of a pointer to unsigned long.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks reasonable to me, I'll apply it to the dma-mapping tree fo 5.5.
