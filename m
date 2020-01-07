Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A12AC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0662080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgAGQDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:03:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:48038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgAGQDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:03:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 01898B240;
        Tue,  7 Jan 2020 16:03:10 +0000 (UTC)
Date:   Tue, 7 Jan 2020 17:03:08 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: fix variable 'cookie' set but not used
Message-ID: <20200107160308.GC5622@suse.de>
References: <20200106152727.1589-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106152727.1589-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 10:27:27AM -0500, Qian Cai wrote:
> The commit c18647900ec8 ("iommu/dma: Relax locking in
> iommu_dma_prepare_msi()") introduced a compliation warning,
> 
> drivers/iommu/dma-iommu.c: In function 'iommu_dma_prepare_msi':
> drivers/iommu/dma-iommu.c:1206:27: warning: variable 'cookie' set but
> not used [-Wunused-but-set-variable]
>   struct iommu_dma_cookie *cookie;
>                            ^~~~~~
> 
> Fixes: c18647900ec8 ("iommu/dma: Relax locking in iommu_dma_prepare_msi()")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/dma-iommu.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied for v5.5, thanks.
