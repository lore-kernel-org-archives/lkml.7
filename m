Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60A5C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA272173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfGSMMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:12:07 -0400
Received: from verein.lst.de ([213.95.11.211]:39586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfGSMMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:12:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0942368B02; Fri, 19 Jul 2019 14:12:05 +0200 (CEST)
Date:   Fri, 19 Jul 2019 14:12:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     fugang.duan@nxp.com
Cc:     hch@lst.de, m.szyprowski@samsung.com, festevam@gmail.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com
Subject: Re: [PATCH dma  1/1] dma-direct: correct the physical addr in
 dma_direct_sync_sg_for_cpu/device
Message-ID: <20190719121204.GA28960@lst.de>
References: <20190719092648.11085-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719092648.11085-1-fugang.duan@nxp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping tree and I'll sent it to Linus this
weekend.
