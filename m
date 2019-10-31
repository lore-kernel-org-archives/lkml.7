Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B59CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E0220862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572504635;
	bh=gbbppg5IoX5D4b7/HzOcXXHVR2UkAXTX0S0crnRQdWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kI+/QQqSrtJOHaQXpPSpfUz+pCBsDfqPA6citK2fd1yVJm4VPPD4lGxHEIEn0cbuW
	 3CQZhJ3/tmNkmCONjtUTiEpEXVZ+e9+AekvCtZVDaS24QlGLdq8KRvVPEaCdyBKncy
	 Pur+VOeT72r7wJlxFoy/FU/lbbJs5L97rmb10PS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfJaGud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:50:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfJaGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:50:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD88E2083E;
        Thu, 31 Oct 2019 06:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572504631;
        bh=gbbppg5IoX5D4b7/HzOcXXHVR2UkAXTX0S0crnRQdWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juXdlb9bZcMTtyT4MYJBmreT4PtueRB/7G1rGLLIVmRNSpd60hLrtvJ4PAYc2avlA
         mW3QPtMtdv4bF865BwLs+0FGz10hEVY6FbzYaw1dui3ois+coXMTXjwBhQA2ys1WVA
         qHXedv2PDRSQjzgkQZAJbSYAkWGv9ZQFB7IbU6TM=
Date:   Thu, 31 Oct 2019 07:50:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb: core: Remove redundant vmap checks
Message-ID: <20191031065027.GA728148@kroah.com>
References: <20191029213423.28949-1-keescook@chromium.org>
 <20191029213423.28949-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029213423.28949-3-keescook@chromium.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 02:34:23PM -0700, Kees Cook wrote:
> Now that the vmap area checks are being performed in the DMA
> infrastructure directly, there is no need to repeat them in USB.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/core/hcd.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
