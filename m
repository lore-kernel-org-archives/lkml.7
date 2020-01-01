Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90BEC32764
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8EB2080A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577898062;
	bh=p44QX7qkhhAsrDQvnh6TLdMG6Dc5n99KiON82LzgW1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MmoTUHsHgnO2cp2FjoJLKwunxx6/uWH/FtRizuNu+4mt6VWaGMMNiYn/QNtTS7PJi
	 03EBtgcgoRFIFnZtKpAk0Xs20BIhxAF9p5f2g/71cEPHw2cNsY0RmO9MguysdCdaT6
	 ipBYW5qdqG77Xe8fhzu7dtqtMNjZV8EF2BqlRItk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgAARBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 12:01:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgAARBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 12:01:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662F92073D;
        Wed,  1 Jan 2020 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577898060;
        bh=p44QX7qkhhAsrDQvnh6TLdMG6Dc5n99KiON82LzgW1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYnN4sP9K+rdgnisY++8fHI9VICwuScNDaIt299Ip8jo+TXVLszbUsC4dd+pMna3J
         hi+ixD8jPsMvi6wJEsZth2rQG/FJdzOOLgQabDDCds9Dps5HubFYSUlH4U0ewM8v3h
         lJwCfjg7vnDPU+iVonIeEFKC/b0sfY3qu3bqvibc=
Date:   Wed, 1 Jan 2020 18:00:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Chandrasekaran <csiddharth@vmware.com>
Cc:     torvalds@linux-foundation.org, sashal@kernel.org, jannh@google.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        siddharth@embedjournal.com
Subject: Re: [PATCH 4.14 0/2] Backport readdir sanity checking patches
Message-ID: <20200101170058.GB2712976@kroah.com>
References: <cover.1577128778.git.csiddharth@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577128778.git.csiddharth@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 01:06:25AM +0530, Siddharth Chandrasekaran wrote:
> Hello,
> 
> This patchset is a backport of upstream commits that makes getdents() and
> getdents64() do sanity checking on the pathname that it gives to user
> space.
> 
> Sid
> 
> Linus Torvalds (2):
>   Make filldir[64]() verify the directory entry filename is valid
>   filldir[64]: remove WARN_ON_ONCE() for bad directory entries
> 
>  fs/readdir.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

All applied to all branches, thanks.

greg k-h
