Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9254BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ACE21902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCWL3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:29:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42540 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWL3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:29:13 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h7epc-0001y7-9h; Sat, 23 Mar 2019 12:28:56 +0100
Date:   Sat, 23 Mar 2019 12:28:55 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
cc:     Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] x86: remove the x86_dma_fallback_dev hack
In-Reply-To: <20190321225235.30648-8-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1903231227240.2157@nanos.tec.linutronix.de>
References: <20190321225235.30648-1-hch@lst.de> <20190321225235.30648-8-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019, Christoph Hellwig wrote:

Please change the subject to:

 x86/dma: Remove the .... hack

> Now that we removed support for the NULL device argument in the DMA API,
> there is no need to cater for that in the x86 code.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/dma-mapping.h | 10 ----------
>  arch/x86/kernel/amd_gart_64.c      |  6 ------
>  arch/x86/kernel/pci-dma.c          | 20 --------------------
>  kernel/dma/mapping.c               |  7 -------
>  4 files changed, 43 deletions(-)

Feel free to route that through your DMA tree.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
