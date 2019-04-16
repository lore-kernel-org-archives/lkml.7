Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7162C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE802206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfDPQKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:10:47 -0400
Received: from shell.v3.sk ([90.176.6.54]:40758 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfDPQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:10:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2646A101F83;
        Tue, 16 Apr 2019 18:10:44 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aKfMMnedUFlJ; Tue, 16 Apr 2019 18:10:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 32E26101FA2;
        Tue, 16 Apr 2019 18:10:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rAVUzQqfSw0q; Tue, 16 Apr 2019 18:10:40 +0200 (CEST)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7C6AE101F83;
        Tue, 16 Apr 2019 18:10:40 +0200 (CEST)
Message-ID: <867198f91838d8e411849364e12864ecda28162d.camel@v3.sk>
Subject: Re: [PATCH] etnaviv: allow building on MMP
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Apr 2019 18:10:39 +0200
In-Reply-To: <20190416160101.6037-1-lkundrak@v3.sk>
References: <20190416160101.6037-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 18:01 +0200, Lubomir Rintel wrote:
> MMP2 has a GC860 core.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 041a77e400d4..7616f695270f 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
> -	depends on ARCH_MXC || ARCH_DOVE || (ARM && COMPILE_TEST)
> +	depends on ARCH_MXC || ARCH_DOVE || ARCH_MMP || (ARM && COMPILE_TEST)
>  	depends on MMU
>  	select SHMEM
>  	select SYNC_FILE

Just noticed this is solved in 5.1. Please ignore this. Sorry for the
noise.

Lubo

