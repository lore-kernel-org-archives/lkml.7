Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0BFC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CDD2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbfFYGee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:34:34 -0400
Received: from verein.lst.de ([213.95.11.211]:59917 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfFYGee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:34:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2A77268B02; Tue, 25 Jun 2019 08:34:03 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:34:02 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 7/7] arc: use the generic remapping allocator for
 coherent DMA allocations
Message-ID: <20190625063402.GC29561@lst.de>
References: <20190614144431.21760-1-hch@lst.de> <20190614144431.21760-8-hch@lst.de> <78ac563f2815a9a14bfab6076d0ef948497f5b9f.camel@synopsys.com> <20190615083554.GC23406@lst.de> <20190624131417.GA10593@lst.de> <d9ed8f6a82801b94d1d7792eb74effdbce09ce51.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9ed8f6a82801b94d1d7792eb74effdbce09ce51.camel@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:13:17PM +0000, Eugeniy Paltsev wrote:
> Hi Christoph,
> 
> Yep I've reviewed and tested it for both cases:
> - coherent/noncoherent dma
> - allocation from atomic_pool/regular allocation
> 
> everything works fine for ARC.

Thanks.  I've applied the whole series to the dma-mapping for-next
branch.
