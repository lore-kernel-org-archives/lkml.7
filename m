Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44B1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8095720644
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfH2OyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:54:20 -0400
Received: from verein.lst.de ([213.95.11.211]:46987 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfH2OyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:54:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 11F1468B20; Thu, 29 Aug 2019 16:54:17 +0200 (CEST)
Date:   Thu, 29 Aug 2019 16:54:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Christoph Hellwig <hch@lst.de>, tomi.valkeinen@ti.com,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Message-ID: <20190829145416.GA19460@lst.de>
References: <20190730061849.29686-1-hch@lst.de> <20190730135045.GA4806@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730135045.GA4806@pendragon.ideasonboard.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 04:50:45PM +0300, Laurent Pinchart wrote:
> I would have indented this line to match the rest. Apart from that,

I've fixed that up now that I've applied the patch.
