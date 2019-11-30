Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0717C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC622075C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 08:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfK3ISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 03:18:48 -0500
Received: from verein.lst.de ([213.95.11.211]:59634 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfK3ISr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 03:18:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1D9B168BE1; Sat, 30 Nov 2019 09:18:44 +0100 (CET)
Date:   Sat, 30 Nov 2019 09:18:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma-mapping: use bit macros
Message-ID: <20191130081844.GA8928@lst.de>
References: <1519de9e-0bd6-c7e7-a911-d51481dfb415@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519de9e-0bd6-c7e7-a911-d51481dfb415@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 09:27:26PM +0100, Heiner Kallweit wrote:
> Not necessarily a big leap for mankind, but using bit macros makes
> the code better readable, especially the definition of DMA_BIT_MASK
> is more intuitive.

NAK, I'm against this pointless obsfucation.
