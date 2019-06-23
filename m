Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3746C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9202020679
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFWKe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 06:34:26 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfFWKe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 06:34:26 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45Wpgz6Q4Lz9sBb; Sun, 23 Jun 2019 20:34:23 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9739ab7eda459f0669ec9807e0d9be5020bab88c
X-Patchwork-Hint: ignore
In-Reply-To: <20190613082446.18685-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org,
        paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Larry.Finger@lwfinger.net, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, aaro.koskinen@iki.fi
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
Message-Id: <45Wpgz6Q4Lz9sBb@ozlabs.org>
Date:   Sun, 23 Jun 2019 20:34:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-13 at 08:24:46 UTC, Christoph Hellwig wrote:
> With the strict dma mask checking introduced with the switch to
> the generic DMA direct code common wifi chips on 32-bit powerbooks
> stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> to allow them to reliably allocate dma coherent memory.
> 
> Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9739ab7eda459f0669ec9807e0d9be5020bab88c

cheers
