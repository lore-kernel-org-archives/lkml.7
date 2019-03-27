Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D459CC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A681D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711388;
	bh=m9gATZnVYhH/fEiBV9NZqrCcBRrJT6ChP5qNC07drvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S3471u+YkMh5XMkeVoewRZj+0YuxLMjnzmSNo3ZBkIgZNQa7AMNeODF9zTJkPR5Sk
	 6VKkaEaTv7ICBlW9yZtmkMCSgG8jImw2FWqHK40tzTycBIFz/OytnB9xecdsiQ+c5w
	 kLoXI6IimMp11xA1RDzp3iWfG60PinJkaVTU3QK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbfC0S3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404065AbfC0S3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:29:46 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038602177E;
        Wed, 27 Mar 2019 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711385;
        bh=m9gATZnVYhH/fEiBV9NZqrCcBRrJT6ChP5qNC07drvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RU+UnlNJWw2WOHWMBreX0j06GKIazrSwSvQBTCrmd8Yj0cQr9Sp/fI/wdFqIBB7wX
         Ie9iYd/06pUIHBS/auUghCpFMVHrDMuE4+gt8u5H72a56Hu/LGn7Z96ZMl54LoxSAi
         VcnJItog4ZAu+vpvxdzsb9hXDe5CPAtdtKURfmQI=
Date:   Thu, 28 Mar 2019 02:10:29 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, yuzibode@126.com
Subject: Re: [PATCH] misc/fastrpc: add checked value for dma_set_mask
Message-ID: <20190327171029.GA13738@kroah.com>
References: <20190319020519.15209-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319020519.15209-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:05:19PM -0400, Bo YU wrote:
> There be should check return value from dma_set_mask to throw some infos
> if fail to set dma mask.
> 
> Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)
> 
> Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This patch no longer applies to my tree due to other fastrpc fixes being
sent before your patch :(

Please rebase and resend.

thanks,
greg k-h
