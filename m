Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4872077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDKN5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:57:52 -0400
Received: from 8bytes.org ([81.169.241.247]:34140 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:57:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C0AD442D; Thu, 11 Apr 2019 15:57:50 +0200 (CEST)
Date:   Thu, 11 Apr 2019 15:57:49 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: per-device dma_map_ops for intel-iommu?
Message-ID: <20190411135749.GE4518@8bytes.org>
References: <20190409135924.GA11431@lst.de>
 <b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b491bb987c8cc3f95328d33586ec25c497cc8b8b.camel@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 05:03:52PM +0300, David Woodhouse wrote:
> On Tue, 2019-04-09 at 15:59 +0200, Christoph Hellwig wrote:
> > Hi David and Joerg,
> > 
> > do you remember a good reason why intel-iommu is not using per-device
> > dma_map_ops like the AMD iommu or the various ARM iommus?
> > 
> > Right now intel-iommu.c contains a half-asses reimplementation of the
> > dma direct code for the iommu_no_mapping() case, and it would seem
> > much nicer to just fall back to that case and not even call into
> > intel-iommu in that case.
> 
> Other than the complexities about passthrough mode and various "oh shit
> we forgot to actually test that iommu+gfx actually works before
> shipping hardware" type of quirks that bypass the IOMMU for certain
> devices — and retpolines, which I think you already dealt with — no, no
> good reason that I recall.

Same here, I looked into this in the past as well, but I can't recall
any reason this was left in place.


	Joerg
