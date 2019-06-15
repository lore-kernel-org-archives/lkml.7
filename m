Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0C3C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEC92070B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfFOIgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 04:36:24 -0400
Received: from verein.lst.de ([213.95.11.211]:52431 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOIgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 04:36:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A382E68AFE; Sat, 15 Jun 2019 10:35:54 +0200 (CEST)
Date:   Sat, 15 Jun 2019 10:35:54 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "stefan.kristiansson@saunalahti.fi" 
        <stefan.kristiansson@saunalahti.fi>,
        "jonas@southpole.se" <jonas@southpole.se>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for
 coherent DMA allocations
Message-ID: <20190615083554.GC23406@lst.de>
References: <20190614144431.21760-1-hch@lst.de> <20190614144431.21760-8-hch@lst.de> <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 06:05:01PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> Regular question - do you have any public git repository with all this dma changes?
> I want to test it for ARC.
> 
> Pretty sure the
>  [PATCH 2/7] arc: remove the partial DMA_ATTR_NON_CONSISTENT support
> is fine.
> 
> Not so sure about
>  [PATCH 7/7] arc: use the generic remapping allocator for coherent DMA allocations
> :)

   git://git.infradead.org/users/hch/misc.git dma-not-consistent-cleanup

Gitweb:

   http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-not-consistent-cleanup
