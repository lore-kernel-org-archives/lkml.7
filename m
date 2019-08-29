Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4234C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF72722CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH2P2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:28:23 -0400
Received: from verein.lst.de ([213.95.11.211]:47223 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727294AbfH2P2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:28:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C63D5227A81; Thu, 29 Aug 2019 17:28:16 +0200 (CEST)
Date:   Thu, 29 Aug 2019 17:28:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Shawn Anastasio <shawn@anastas.io>, Will Deacon <will@kernel.org>,
        linux-m68k@lists.linux-m68k.org, Guan Xuetao <gxt@pku.edu.cn>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: cleanup the dma_pgprot handling v2
Message-ID: <20190829152816.GA20232@lst.de>
References: <20190826132553.4116-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826132553.4116-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've pulled this into the dma-mapping for-next tree now.
