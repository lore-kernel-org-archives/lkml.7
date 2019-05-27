Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D9C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9858A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE0Pix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:38:53 -0400
Received: from verein.lst.de ([213.95.11.211]:41057 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfE0Pix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:38:53 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 79D5C68AA6; Mon, 27 May 2019 17:38:29 +0200 (CEST)
Date:   Mon, 27 May 2019 17:38:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Murphy <tmurphy@arista.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: implement generic dma_map_ops for IOMMUs v5
Message-ID: <20190527153829.GA31620@lst.de>
References: <20190520072948.11412-1-hch@lst.de> <20190527153751.GF12745@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527153751.GF12745@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:37:51PM +0200, Joerg Roedel wrote:
> I applied this series to a new generic-dma-ops branch in the iommu
> tree and plan to send it upstream in the next merge window.

Thanks!  Can you push the branch out ASAP, as I'll need to pull it
into the dma-mapping tree to avoid creating nasty conflicts for the
pending rework of the DMA CMA and contigous allocators?
