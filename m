Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27640ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006582070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbfJGQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:53:21 -0400
Received: from verein.lst.de ([213.95.11.211]:39336 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfJGQxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:53:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 471F668B20; Mon,  7 Oct 2019 18:53:15 +0200 (CEST)
Date:   Mon, 7 Oct 2019 18:53:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ryohei Suzuki <ryh.szk.cmnty@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peng Fan <peng.fan@nxp.com>, linux-mm@kvack.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm: export cma alloc and release
Message-ID: <20191007165315.GA10317@lst.de>
References: <20191002212257.196849-1-salyzyn@android.com> <20191003085528.GB21629@arrakis.emea.arm.com> <20191005083753.GA14691@lst.de> <aa1c5b2f-fa90-4390-edc6-33b87fab5e09@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1c5b2f-fa90-4390-edc6-33b87fab5e09@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:50:31AM -0700, Mark Salyzyn wrote:
> On 10/5/19 1:37 AM, Christoph Hellwig wrote:
>> On Thu, Oct 03, 2019 at 09:55:28AM +0100, Catalin Marinas wrote:
>>> Aren't drivers supposed to use the DMA API for such allocations rather
>>> than invoking cma_*() directly?
>> Yes, they are.
>
> We have an engineer assigned to rewriting the ion memory driver to use 
> dma_buf interfaces. Hopefully that effort will solve the problem of 
> requiring these interfaces to be exported so that that driver (and others) 
> can be modularized.
>
> Thanks for the reviews, drop this patch from the list and we will regroup, 
> and accept that standing code in the kernel can not be modularized for the 
> moment.

How is that different from the "DMA-BUF Heaps (destaging ION)" series
floating around?
