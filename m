Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157FBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED69924A32
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfFDGGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:06:23 -0400
Received: from verein.lst.de ([213.95.11.211]:33266 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDGGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:06:22 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EF17568B02; Tue,  4 Jun 2019 08:05:54 +0200 (CEST)
Date:   Tue, 4 Jun 2019 08:05:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 07/26] iommu/dma: move the arm64 wrappers to common code
Message-ID: <20190604060554.GA14536@lst.de>
References: <20190422175942.18788-1-hch@lst.de> <20190422175942.18788-8-hch@lst.de> <06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com> <acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 08:47:57PM +0100, Jon Hunter wrote:
> Since next-20190529 one of our tests for MMC has started failing, where
> the symptom is that the data written to the MMC does not match the
> source. Bisecting this is pointing to this commit. Unfortunately, I am
> not able to cleanly revert this on top of -next, but wanted to report
> this if case you have any ideas.

Does this fix your problem?

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=generic-dma-ops&id=1b961423158caaae49d3900b7c9c37477bbfa9b3
