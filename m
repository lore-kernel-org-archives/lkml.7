Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8586ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAC120873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfJPHIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:08:32 -0400
Received: from verein.lst.de ([213.95.11.211]:59282 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfJPHIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:08:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4A9C168B20; Wed, 16 Oct 2019 09:08:28 +0200 (CEST)
Date:   Wed, 16 Oct 2019 09:08:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xtensa: implement arch_dma_coherent_to_pfn
Message-ID: <20191016070827.GA23051@lst.de>
References: <20191015212526.1775-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015212526.1775-1-jcmvbkbc@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 02:25:26PM -0700, Max Filippov wrote:
> Add trivial implementation for arch_dma_coherent_to_pfn.
> This change enables communication with PCI ALSA devices through mmapped
> buffers.

This looks fine, although I'd much rather convert xtensa to the
generic DMA remap / uncached segment support.

Do you want this fix for 5.4?  If so please queue it up ASAP so that
I can do the proper thing for 5.5.  If you don't need it that urgent
I'd rather go straight to the generic code.
