Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19487C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B19218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562170844;
	bh=QZTPaJThXyCvilVBec9jdvthL4N/0KWr9NeInDRs86I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KLrgVMqkEdSEw9ZXfarpdmI7zFUsWzpc64QAaEEubnPC/s8MqKSircZnTP21lWjfG
	 +EbOvdMJpJwxdtq+cSXKsulJ7f1N/pMWegziJs/fl0y/l+r/Pv8Nb37tm7ew5aEX8J
	 NskwCmi8Vx1yWll0RjFQ4AfRudALc0q/8grmAHfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfGCQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfGCQUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:20:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BEF21882;
        Wed,  3 Jul 2019 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562170841;
        bh=QZTPaJThXyCvilVBec9jdvthL4N/0KWr9NeInDRs86I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfpGpXQqZjJsZny78dtBwtSQTqC1dHZjhi8Hrif6Avo5MfSEozLRGTIE9B1x64R8i
         mew4YG2xBl8Wwk5N+AtUJuHbjQjlAlDWM1cldJIKfPMs2rg/bSKWtvfzs14BCplYCF
         /C18P3Lbt0894GMMkrWmnwOu66TSWAhruJauTaH0=
Date:   Wed, 3 Jul 2019 18:20:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        devel@driverdev.osuosl.org, huyue2@yulong.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] staging: erofs: remove unsupported ->datamode
 check in fill_inline_data()
Message-ID: <20190703162038.GA31307@kroah.com>
References: <20190702025601.7976-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702025601.7976-1-zbestahu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:56:01AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Already check if ->datamode is supported in read_inode(), no need to check
> again in the next fill_inline_data() only called by fill_inode().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> ---
> no change
> 
>  drivers/staging/erofs/inode.c | 2 --
>  1 file changed, 2 deletions(-)

This is already in my tree, right?

confused,

greg k-h
