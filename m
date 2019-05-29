Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6C6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7EE21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559129670;
	bh=5qqB+LkxFWgDdcgULhenSbq10dxUOlAU30DJl8fvWpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QbYHDE5rjGRlG+a8kGzWqniLam1AfGIKj4KijK2XbBwdiZ62BJstNerf+/zZPyxAT
	 p9ZweCnCfuUg9515HwXli7LI9ATyLXZFmHq4b30iqC4ZL8tOWrN9weDVUV+2PgksLA
	 ZRGf4JpMQGWE33fYFaT/xa/aTnP5mpQEu2EiP9Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfE2Le3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfE2Le2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:34:28 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BE2120B1F;
        Wed, 29 May 2019 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559129668;
        bh=5qqB+LkxFWgDdcgULhenSbq10dxUOlAU30DJl8fvWpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yg88l+06JcDZRH85MGOkFgJs9WdzrVF9m1mDG5YhVhWhjzQuKHIC+vh0h9ixW5dmA
         3gDhCyiwz9JrXQvWSIwm6CG5oQkHDMHK2i6Q0q8eqXagYZ12duIW4MLdEWeg64sJF0
         RS+LZ6nBDFuXrtuKJEwgT0c3y/6WXku6RfVeKZ0s=
Date:   Wed, 29 May 2019 04:34:27 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laurentiu.tudor@nxp.com
Cc:     hch@lst.de, stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, noring@nocrew.org, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 0/5] prerequisites for device reserved local mem rework
Message-ID: <20190529113427.GC11952@kroah.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 01:28:38PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> For HCs that have local memory, replace the current DMA API usage
> with a genalloc generic allocator to manage the mappings for these
> devices.
> This is in preparation for dropping the existing "coherent" dma
> mem declaration APIs. Current implementation was relying on a short
> circuit in the DMA API that in the end, was acting as an allocator
> for these type of devices.
> 
> Only compiled tested, so any volunteers willing to test are most welcome.
> 
> Thank you!
> 
> For context, see thread here: https://lkml.org/lkml/2019/4/22/357

All look good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Christoph, this is going through your tree, right?

thanks,

greg k-h
