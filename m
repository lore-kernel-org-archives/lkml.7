Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB44C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678E1206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556277823;
	bh=3bzZ2r5lWZdVtw8CtpxfUbi9NGF6ozDmxq0Do81o3BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ue9PfYIWmjTpUQJkMJO7QX63szArxRT0AV+6VVqTrIPtvzbxiUoFgGTPParxyJK3H
	 Gn9vLoDtgdy9g5u9tgz2SFVZWzblyY0ei19BEfzpWuVet0FSC7elH/MnFb0+4VmBFm
	 Gsap3r8cMLA9vdQcLxe1lrETVJyGQRqDMYlN42Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfDZLXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfDZLXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:23:41 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4315C206A3;
        Fri, 26 Apr 2019 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556277821;
        bh=3bzZ2r5lWZdVtw8CtpxfUbi9NGF6ozDmxq0Do81o3BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URPn1sEQTjeNJIYIJ51giByxL0CctrDMTbbQ/enjX7olLMfytVYS0Qx6HiJLhYoUd
         DhzuxalaCE5axg+cWf4D7Te+TvLmrFo9rW5pQmpOjY2OxqQXPMIwLivcYVW3160A5t
         fcam28ZA5OYbX7MPgNWhrgYAf1DcT/rKI/LOAuCk=
Date:   Fri, 26 Apr 2019 16:53:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] dmaengine: bcm2835: Drop duplicate capability setting.
Message-ID: <20190426112335.GR28103@vkoul-mobl>
References: <20190404172503.12155-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404172503.12155-1-msuchanek@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-19, 19:25, Michal Suchanek wrote:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  drivers/dma/bcm2835-dma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index ec8a291d62ba..e38b19dd2895 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -891,7 +891,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
> -	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
>  	od->ddev.device_alloc_chan_resources = bcm2835_dma_alloc_chan_resources;
>  	od->ddev.device_free_chan_resources = bcm2835_dma_free_chan_resources;

Applied, thanks

-- 
~Vinod
