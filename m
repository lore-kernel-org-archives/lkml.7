Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA6EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBEA217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893382;
	bh=xeEo/MfNpk6Uz7mw6BDjWahzBUPG8cMBEdzoxcXEJwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQ0uyvaheAYyylfQhf+QJnWlyZxC2oKLQFl4FvCNQRxJbnIAJC8Yks1GdWg96tjsc
	 et2DVVlMrt0+AXP0DFTE9aEFutKci3XVm7Ytn+NdDp1939yC6zhfA2y/4CaxXTSOY0
	 w69L2G1Skx+kJY3FeyFVS94q3TqRO6YzPsbjLmKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfH0IJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfH0IJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:09:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB51D2184D;
        Tue, 27 Aug 2019 08:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893376;
        bh=xeEo/MfNpk6Uz7mw6BDjWahzBUPG8cMBEdzoxcXEJwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay+ZOT9rC7VN9Bvl+845jEX+pHHHfAcXumQaog+rqH24MrRyFfEC6Zgw9RaSDvkRZ
         OU4I4iEQs3pfWeliV43b5tJVGe16mAJbkfu0o8KLLUrKRaB0Aro0uTS8RUSUNSn419
         1M0TPuqm7H3vyAeXbdv4RRTADAhuNSY0qf7AA97Y=
Date:   Tue, 27 Aug 2019 10:08:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peikan Tsai <peikantsai@gmail.com>
Cc:     christian.gromm@microchip.com, gustavo@embeddedor.com,
        suzuki.poulose@arm.com, colin.king@canonical.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most-core: Fix checkpatch warnings
Message-ID: <20190827080825.GA27271@kroah.com>
References: <20190825175849.GA74586@MarkdeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825175849.GA74586@MarkdeMacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:58:49AM +0800, Peikan Tsai wrote:
> Hi,
> 
> This patch solves the following checkpatch.pl's messages in drivers/staging/most/core.c.
> 
> WARNING: line over 80 characters
> +			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
> 
> CHECK: Please use a blank line after function/struct/union/enum declarations
> +}
> +/**
> 
> Signed-off-by: Peikan Tsai <peikantsai@gmail.com>
> ---
>  drivers/staging/most/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Normally we want only one "type" of cleanup per patch, but this is so
tiny I'll just take it as-is.

thanks,

greg k-h
