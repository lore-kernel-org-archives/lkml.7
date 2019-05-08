Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C27C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AECDB20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfEHMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:53:17 -0400
Received: from verein.lst.de ([213.95.11.211]:39480 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfEHMxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:53:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A1D2B68B20; Wed,  8 May 2019 14:52:54 +0200 (CEST)
Date:   Wed, 8 May 2019 14:52:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 0/2] Optimize dma_*_from_contiguous calls
Message-ID: <20190508125254.GA26785@lst.de>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506223334.1834-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

modulo a trivial comment typo I found this looks fine to me.  I plan
to apply it with that fixed up around -rc2 time when I open the
dma mapping tree opens for the the 5.3 merge window, unless someone
finds an issue until then.
