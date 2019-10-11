Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516CC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2DC206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570813415;
	bh=1Hli6rSRTCC/5zc4mgxTswUrMtvRKAPnA9Ms67W/ABY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7sqQQXgz9NcakSpx79uNm/+PwjxnvJRwB3YWhTLbdo5frMmIgn4zVX5DKaPC6gnc
	 mFvPu7mYl/1p3dsgsC2vTIXbZ0obU+qD5qPBOEZyacBLO3TIvIFEetJ+QC4EtTfbDz
	 ++ZThg9tmcrnf7MAkgtmVbqGfmQex8QEnaIuWzZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfJKRDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfJKRDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:03:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289462054F;
        Fri, 11 Oct 2019 17:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570813413;
        bh=1Hli6rSRTCC/5zc4mgxTswUrMtvRKAPnA9Ms67W/ABY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ye8s7tCi6sJHRJtRWPU6AAEb1vVyRqOXKd+9IyJiKTx9U21ByZqia4mUiFnUVy/Jt
         hicP8wd7MooFkafAiGAbaRMFI91U5rclGyzw6xXmPYM+4g5NOBpLCOx6w3PHlrpdq2
         GvMu03Wz4bEWhnr9FJ4zU351tEGuPGKoJxRvqx9Y=
Date:   Fri, 11 Oct 2019 19:03:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     Jerome.Pouiller@silabs.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] staging: wfx: fix an undefined reference error
 when CONFIG_MMC=m
Message-ID: <20191011170331.GA1296994@kroah.com>
References: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570811647-64905-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:34:07AM +0800, zhong jiang wrote:
> I hit the following error when compile the kernel.
> 
> drivers/staging/wfx/main.o: In function `wfx_core_init':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:488: undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o: In function `wfx_core_exit':
> /home/z00352263/linux-next/linux-next/drivers/staging/wfx/main.c:496: undefined reference to `sdio_unregister_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x1a8): undefined reference to `sdio_register_driver'
> drivers/staging/wfx/main.o:(.debug_addr+0x6f0): undefined reference to `sdio_unregister_driver'
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/staging/wfx/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What changed from v1?  Always put that below the --- line.

v3 please?

thanks,

greg k-h
