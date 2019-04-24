Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A59C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDE12077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfDXGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:14:40 -0400
Received: from verein.lst.de ([213.95.11.211]:51594 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfDXGOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:14:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4BA6168B02; Wed, 24 Apr 2019 08:14:24 +0200 (CEST)
Date:   Wed, 24 Apr 2019 08:14:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nds32: remove __virt_to_bus and __bus_to_virt
Message-ID: <20190424061423.GA12864@lst.de>
References: <20190409102654.25845-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409102654.25845-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Tue, Apr 09, 2019 at 12:26:54PM +0200, Christoph Hellwig wrote:
> These macros are not used anywhere.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/nds32/include/asm/memory.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
> index 60efc726b56e..9d552ee39bdb 100644
> --- a/arch/nds32/include/asm/memory.h
> +++ b/arch/nds32/include/asm/memory.h
> @@ -15,14 +15,6 @@
>  #define PHYS_OFFSET     (0x0)
>  #endif
>  
> -#ifndef __virt_to_bus
> -#define __virt_to_bus	__virt_to_phys
> -#endif
> -
> -#ifndef __bus_to_virt
> -#define __bus_to_virt	__phys_to_virt
> -#endif
> -
>  /*
>   * TASK_SIZE - the maximum size of a user space task.
>   * TASK_UNMAPPED_BASE - the lower boundary of the mmap VM area
> -- 
> 2.20.1
---end quoted text---
