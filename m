Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16794C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2182073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfG2Guq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:50:46 -0400
Received: from verein.lst.de ([213.95.11.211]:36992 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfG2Guq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:50:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B970A68B02; Mon, 29 Jul 2019 08:50:42 +0200 (CEST)
Date:   Mon, 29 Jul 2019 08:50:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     dafna.hirschfeld@collabora.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dma-contiguous: two bug fixes for
 dma_{alloc,free}_contiguous()
Message-ID: <20190729065042.GA4009@lst.de>
References: <20190726193433.12000-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726193433.12000-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the dma-mapping for-linus tree.
