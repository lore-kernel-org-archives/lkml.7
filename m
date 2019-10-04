Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0914C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA85215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570206100;
	bh=Zj3ZXkyCt1r4hMw2T6c5tTxTaIk9C9fs5VAJF+At57s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uuN2tRAnJeYCUIkN4cDqyRm6TBnis4I4nqsqDRgor5jCZeMInFne/Jn6xMw/pOLI+
	 yJMXo/Hg/92ce9VcRk2kO4TPT9mtybbcLCnqWHddWfmvC0X4Qabd/VfV263F8Lxn5i
	 5A04ZTthnku//MPdo/2vD3hvHdNDOif2S2VFDRP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390262AbfJDQVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390201AbfJDQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:21:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB5420873;
        Fri,  4 Oct 2019 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570206099;
        bh=Zj3ZXkyCt1r4hMw2T6c5tTxTaIk9C9fs5VAJF+At57s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8jQnJAgxftHCj/az0ZPGhHaBYbPBTQWIjVsKQ13ADZRhRTwhVx48T6nobs0ILxoP
         QT385sl1fU7XvW+44S76edWSy+ewcnEBgA2an2vsD0XA/AP4C6DoKwA9gUDnS+Ek+f
         LCurdFSFQuzXo+K/9831+Qi6YrGgoX40sXvl/DIc=
Date:   Fri, 4 Oct 2019 18:21:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     arnd@arndb.de, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] misc: fastrpc: add mmap/unmap support
Message-ID: <20191004162136.GC854302@kroah.com>
References: <20190916122451.12546-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916122451.12546-1-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 02:24:51PM +0200, Jorge Ramirez-Ortiz wrote:
> Support the allocation/deallocation of buffers mapped to the DSP.
> 
> When the memory mapped to the DSP at process creation is not enough,
> the fastrpc library can extend it at runtime. This avoids having to do
> large preallocations by default.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
>  v2: fixes kbuild warning
>      cast from pointer to integer of different size

Please resend the whole series, only doing it for one patch is a pain to
try to keep in sync and figure out.

thanks,

greg k-h
