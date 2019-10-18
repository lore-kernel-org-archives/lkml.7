Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1700CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9849222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="M64u0/vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410164AbfJRM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:57:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:31567 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733180AbfJRM50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:57:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46vmJz4VtKzB09b0;
        Fri, 18 Oct 2019 14:57:23 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=M64u0/vx; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MA8gt4jfKrnu; Fri, 18 Oct 2019 14:57:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46vmJz3NhFzB09Zw;
        Fri, 18 Oct 2019 14:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1571403443; bh=P+VjSeFKR0YVZlm5oe6xprbP52ac0pv0a6AOQUrclV0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M64u0/vx1KJeUMfPLBz2jFxYbbMSbfmpl2+OuzWSbkbGwFaNqegzEC67qIu3LFiPX
         6P4YxoIVPsXKPTqIgr1qlPuSVJny52O2xFRTtfoZW90pa8kk0AyHXaZfrhqunqGvWK
         hwU92378jbMtIN5poP5BwtAJX5Att83hc9NSfPj0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6F8038B802;
        Fri, 18 Oct 2019 14:57:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JnffNplE4Ump; Fri, 18 Oct 2019 14:57:23 +0200 (CEST)
Received: from [192.168.204.43] (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 661508B800;
        Fri, 18 Oct 2019 14:57:22 +0200 (CEST)
Subject: Re: [PATCH 1/7] soc: fsl: qe: remove space-before-tab
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191018125234.21825-2-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <89dc8d74-b1fc-19f5-d8a5-cd43eda27b4d@c-s.fr>
Date:   Fri, 18 Oct 2019 14:57:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191018125234.21825-2-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/10/2019 à 14:52, Rasmus Villemoes a écrit :
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/soc/fsl/qe/qe.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 417df7e19281..6fcbfad408de 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -378,8 +378,8 @@ static int qe_sdma_init(void)
>   	}
>   
>   	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
> - 	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
> - 					(0x1 << QE_SDMR_CEN_SHIFT)));
> +	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
> +					(0x1 << QE_SDMR_CEN_SHIFT)));

Could you also align the second line properly ?

Christophe

>   
>   	return 0;
>   }
> 
