Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30193C76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1291C2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390606AbfGYFZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:25:33 -0400
Received: from verein.lst.de ([213.95.11.211]:58041 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390562AbfGYFZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:25:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E280168B20; Thu, 25 Jul 2019 07:25:29 +0200 (CEST)
Date:   Thu, 25 Jul 2019 07:25:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        m.szyprowski@samsung.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size
 call
Message-ID: <20190725052529.GA24355@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com> <20190722145509.1284-3-eric.auger@redhat.com> <e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com> <20190723153851.GE720@lst.de> <20190723114750-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723114750-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:10:53PM -0400, Michael S. Tsirkin wrote:
> Christoph - would a documented API wrapping dma_mask make sense?
> With the documentation explaining how users must
> desist from using DMA APIs if that returns false ...

We have some bigger changes in this are planned, including turning
dma_mask into a scalar instead of a pointer, please stay tuned.
