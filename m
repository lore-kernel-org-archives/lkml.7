Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A921CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7827920881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561970564;
	bh=bxRp0wzioxPO5LSZMl5y6eVW5avDuj3NK25QSOZQ8Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2aLByzzZyzCno7obEPs0/6+HxcjoN1kKBjfhPsMpX8zZkifzT4197e8UZmgOZ2jFT
	 bug+O4cynxWKQUKmHtR89pZ9pTKqJxT6tfyAILDaVePZIgcEhLZqLJYTM5nPpGY0wj
	 XAHmkl9EAj2kIS2+MvzWQfZhrqAb5pdaF5kpFlXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfGAImn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfGAImn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:42:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD16620881;
        Mon,  1 Jul 2019 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561970562;
        bh=bxRp0wzioxPO5LSZMl5y6eVW5avDuj3NK25QSOZQ8Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lq+qL62AE7ambKrarLmAT5KQ+YPxVtSGXMrqUAfisU18Vt5iwjNsHthJFBIiT5k7e
         8GuCnThOV/MzC0mNYw5XqaMN+GyPLB+gTwXMDSDj6uVm6O8Lck6taA8G0V4b8G4H5M
         rZKmNW1rXKzNuE8cvzUIJ0BuwXjWohfGIlHiPdjc=
Date:   Mon, 1 Jul 2019 10:42:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: kpc2000: fix brace issues in kpc2000_spi.c
Message-ID: <20190701084239.GA20886@kroah.com>
References: <20190627195323.28913-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627195323.28913-1-simon@nikanor.nu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 09:53:23PM +0200, Simon Sandström wrote:
> Fixes issues found by checkpatch:
> 
> - "WARNING: braces {} are not necessary for single statement blocks"
> - "WARNING: braces {} are not necessary for any arm of this statement"
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 39 ++++++++++-----------------
>  1 file changed, 14 insertions(+), 25 deletions(-)

Patch does not apply to my tree :(

Please rebase it and resend.

thanks,

greg k-h
