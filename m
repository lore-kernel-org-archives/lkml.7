Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E65C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4A02719C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFAJAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 05:00:31 -0400
Received: from verein.lst.de ([213.95.11.211]:45937 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfFAJAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:00:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4902068B02; Sat,  1 Jun 2019 11:00:06 +0200 (CEST)
Date:   Sat, 1 Jun 2019 11:00:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     jroedel@suse.de, akpm@linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: replace single-char identifiers in macros
Message-ID: <20190601090005.GC6453@lst.de>
References: <1559079041-525-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559079041-525-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 05:30:41PM -0400, Qian Cai wrote:
> There are a few macros in DMA have single-char identifiers make the code
> hard to read. Replace them with meaningful names.

Well, this code isn't really supposed to be read much, it just has
minimal stubs.  and dmar.h is not related at all to the dma-mapping
subsystem.
