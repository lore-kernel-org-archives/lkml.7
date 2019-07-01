Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0448C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D3520881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561970608;
	bh=0NA1/7KLb+cyKHN4XxT0JUUlB2v/LMeQRKGWYY+tSL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QysaLFF/cXK2/8F/Nh16U5iK3wgnUHba+gL+/NAkSPvU3Xx4GIPFpG6PED9AFrY2v
	 FQwcUxp0oEpLsntHiHRxAEq72TRsA9g8Y5Bl9eVJ4IwkeSxNlE1Yu6PCPMFsPPTVUk
	 zJfuGsPSopI3RgvUrNGPVjqBLilXRfgvYIWqXybg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfGAIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbfGAIn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:43:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7DF208E4;
        Mon,  1 Jul 2019 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561970606;
        bh=0NA1/7KLb+cyKHN4XxT0JUUlB2v/LMeQRKGWYY+tSL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/qgc/htOo3Uv83ZbeoSEyiDWw0kpslcG6HW8GNh3kma9esMgLz5Qg9a7e/l/Jkvq
         +W+7VwpCQbvjIw33Fnjh3RuMA9HW24/6CuW4cj1vxubvrRubsxlphXX/ffxsmPLLS6
         vYWHlsxUiWXgyYYNbKVpsGb3EQWuHTu4JGzyT3kI=
Date:   Mon, 1 Jul 2019 10:43:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harsh Jain <harshjain32@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        harshjain.prof@gmail.com
Subject: Re: [PATCH 1/2] staging:kpc2000:Fix symbol not declared warning
Message-ID: <20190701084323.GA21007@kroah.com>
References: <20190628172724.2689-1-harshjain32@gmail.com>
 <20190628172724.2689-2-harshjain32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628172724.2689-2-harshjain32@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:57:23PM +0530, Harsh Jain wrote:
> It fixes "symbol was not declared. Should it be static?"
> sparse warning.
> 
> Signed-off-by: Harsh Jain <harshjain32@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc_i2c/i2c_driver.c | 4 ++--

This file isn't even in the linux-next tree at all, it has moved weeks
ago.

Always be sure to work against linux-next so that you do not create
things that are not able to be accepted.

thanks,

greg k-h
