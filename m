Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08488CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6707217D9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572714613;
	bh=Pd1Str5GC7XGhzGQCBbPGLO3+GGPMDvyzlzuW1vIPgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kdZY1KaEECm2jkEq54/8lnzj/6GYH6h9Hp47zRIheE2qwfWKdvcXiLhbv2Vk+fnN
	 IVHoocptckMRYqovYO0a8VNbg4KYv9owSlLRn+vaER96+yeUFH1MnMztJTezw1tcIO
	 XD+9Czq2BJAAbGlm16B1bEhP/9CUWj8UqhmUYTlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKBRKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbfKBRKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:10:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B62120862;
        Sat,  2 Nov 2019 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714611;
        bh=Pd1Str5GC7XGhzGQCBbPGLO3+GGPMDvyzlzuW1vIPgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyBMPBmYSUF83EAqL/HLtHmPjTQ9qHLUR1PZAtT4aUeyvdBkDi9ww1RiCEGoFI+Ay
         XN42pLVynEhCr+lRmT4fXfZAhcUd2RjKeooJv2Ma23mDKlu9z4g3LNOiBE3vkA1RKg
         AHVPX5FYysOtLQb6hyeK3z1wMhNjaSG4yRG2mJpQ=
Date:   Sat, 2 Nov 2019 18:10:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     akinobu.mita@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fault-inject: Use debugfs_create_ulong() instead
 of debugfs_create_ul()
Message-ID: <20191102171009.GA479906@kroah.com>
References: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
 <1572486977-14195-2-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572486977-14195-2-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 09:56:16AM +0800, zhong jiang wrote:
> debugfs_create_ulong() has implemented the function of debugfs_create_ul()
> in lib/fault-inject.c. hence we can replace it.
> 
> Suggested-by: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  lib/fault-inject.c | 39 ++++++++++++---------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
