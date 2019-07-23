Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0416C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F0D2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563902205;
	bh=AhMUEigBVGgjkqk8XoCkrqk5l7DyuxEw5bsGofwzDS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LXkpt3ZBdMCXWdfk0U4B1lFiLn+Zyfr/3COLmdqt0WKoJK82bIJF7rTOU0bAm8+Lj
	 T99+HJqJWJquHTQz887nCkxBZCyygEb9d/5BGCFPPSIlimKs+zba+pkpiJbEG7lW0R
	 WGb8Lo5bm/5jnyM8gn2Qkb7Z9BPLnco8v7vGZ6JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390999AbfGWRQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:16:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388267AbfGWRQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:16:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498D42239F;
        Tue, 23 Jul 2019 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563902203;
        bh=AhMUEigBVGgjkqk8XoCkrqk5l7DyuxEw5bsGofwzDS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLAPoQsrnIFw77o74ZsbhCw4KtI2HqtBvNitEL1VmCvwG8NgOzm9Id6zBXjGjaXeS
         ++wNyjzYU/pU8eLqFn/syaPLNa/5pKL50YOvuDR95bGwn0ZM+phDaf782oHzqTvLf4
         fgq+RrbpVtl6uEFlmuMW3MjnInL03S8uZyhfhbTM=
Date:   Tue, 23 Jul 2019 18:16:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove unneeded uapi/asm/stat.h
Message-ID: <20190723171638.ctzz6jt3442zvg2d@willie-the-truck>
References: <20190723112922.14315-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723112922.14315-1-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:29:22PM +0900, Masahiro Yamada wrote:
> stat.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
> automatically generate it.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/arm64/include/uapi/asm/stat.h | 17 -----------------
>  1 file changed, 17 deletions(-)
>  delete mode 100644 arch/arm64/include/uapi/asm/stat.h

Thanks, I'll pick this up for 5.4.

Will
