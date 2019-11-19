Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE73DC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E1B222A7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574167048;
	bh=3SRua9bveRcBMHy6i6cnairtbSKL6I4YXWTgid0PSbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cBgQDi80j4Xp/kAqA9dEP1u82QWA5KLYNwa8C4wxcLe3GEv0/O+F7uupoZCK0zXCU
	 EuX9O6Z1RXp0+NeZBeNtc2KiVXrWqysklgpkyY4ErTEyWe6XSLZbPfGCYMF+0m74ju
	 26lC/WdEyn6sKjw5lkkw7uLgIT2Ahs5Vw7nliG4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfKSMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:37:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSMh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:37:27 -0500
Received: from localhost (unknown [89.205.136.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57AF520637;
        Tue, 19 Nov 2019 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574167047;
        bh=3SRua9bveRcBMHy6i6cnairtbSKL6I4YXWTgid0PSbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wcWxtO1UIJsEb7vUeKZ11Y2RojlhWJy92BhE1liCnm/IEF8SOuHo7tfRWVDQtxSRf
         hWj8IZcuYBMpOoywVRojsLQTnGQXuLn7IiHHvcseFp2LkvCXXd6Wlau0vqAuhFbBs0
         PDdXsu7JkP9kRaXyBI6lzuxKm6bfixKJgSTBZW9I=
Date:   Tue, 19 Nov 2019 13:37:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rui_feng@realsil.com.cn
Cc:     arnd@arndb.de, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] misc: rtsx: Fix impossible condition
Message-ID: <20191119123724.GA1975017@kroah.com>
References: <1574151990-3335-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574151990-3335-1-git-send-email-rui_feng@realsil.com.cn>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 04:26:30PM +0800, rui_feng@realsil.com.cn wrote:
> From: Rui Feng <rui_feng@realsil.com.cn>
> 
> A u8 can only go up to 255, condition n > 396 is
> impossible, so change u8 to u16.
> 
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> ---
>  drivers/misc/cardreader/rts5261.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

What changed from v1?  Always put that below the --- line as the
documentation asks you to.

Please fix up and send a v3.

thanks,

greg k-h
