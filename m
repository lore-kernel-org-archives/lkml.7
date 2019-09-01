Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D76C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 08:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1E322CF7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 08:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfIAIBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 04:01:02 -0400
Received: from verein.lst.de ([213.95.11.211]:40643 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfIAIBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 04:01:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3211227A8B; Sun,  1 Sep 2019 10:00:56 +0200 (CEST)
Date:   Sun, 1 Sep 2019 10:00:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190901080055.GA12035@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan> <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 07:53:17PM -0700, Paul Walmsley wrote:
> There's already a MAINTAINERS entry that should cover drivers/soc/sifive.  
> Probably it's not needed to add another one here.

So are you going to apply the original patch to the riscv tree?
I dont want to keep this file lingering around as a force built part
of the riscv build for another merge window.
