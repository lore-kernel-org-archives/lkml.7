Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C30C74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD5D2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 10:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfGKKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 06:05:19 -0400
Received: from verein.lst.de ([213.95.11.211]:56818 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfGKKFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 06:05:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1EF0B68B20; Thu, 11 Jul 2019 12:05:17 +0200 (CEST)
Date:   Thu, 11 Jul 2019 12:05:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for
 certain DMA masks
Message-ID: <20190711100516.GB5853@lst.de>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

this looks good to me.  I'll wait a bit for feedback from the x86 folks,
and if everything is fine I'll apply it to the dma-mapping tree.
