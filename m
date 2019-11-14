Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A788C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8D9206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNJHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:07:41 -0500
Received: from ozlabs.org ([203.11.71.1]:48977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfKNJHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:39 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxN5pWqz9sP6; Thu, 14 Nov 2019 20:07:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 93a1544ad4ec4bd9147992e57b4f834ceb2cc159
In-Reply-To: <20190612071901.21736-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <linux@armlinux.org.uk>,
        <fw@strlen.de>, <steffen.klassert@secunet.com>,
        <davem@davemloft.net>, <ralf@linux-mips.org>,
        <paul.burton@mips.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-s390@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-sh@vger.kernel.org, netdev@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] defconfigs: remove obsolete CONFIG_INET_XFRM_MODE_* and CONFIG_INET6_XFRM_MODE_*
Message-Id: <47DFxN5pWqz9sP6@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 07:19:01 UTC, YueHaibing wrote:
> These Kconfig options has been removed in
> commit 4c145dce2601 ("xfrm: make xfrm modes builtin")
> So there is no point to keep it in defconfigs any longer.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/93a1544ad4ec4bd9147992e57b4f834ceb2cc159

cheers
