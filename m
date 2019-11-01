Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C6CCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF33F20650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Qh2apHPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfKAQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:19:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2613 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfKAQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:19:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 474S7r1fhQz9v2yk;
        Fri,  1 Nov 2019 17:19:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Qh2apHPi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LL34SHhx5NAd; Fri,  1 Nov 2019 17:19:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 474S7r0Vhdz9v2yj;
        Fri,  1 Nov 2019 17:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572625176; bh=zDfTuyr5rEX4zI99jRtwwUmmmD2R9ZF+lJ3geVUTGqg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Qh2apHPiLmfs6EJags73uaZqx7IGD2FVk7wvpRg1Xm9W8sHg4b8c0XYoz89a/MRlq
         ifUiSWAlsgpiZgs2eFg46/a/REe+tZT7GJvh/RMS1qeGrUk0/VtRCaLsvr61qV3h9f
         2IebLlE11RurHHXZJeawbhGKSNai0y6xorR+vquA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F8768B8F6;
        Fri,  1 Nov 2019 17:19:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ornw-bnFdm4u; Fri,  1 Nov 2019 17:19:37 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3884C8B7C2;
        Fri,  1 Nov 2019 17:19:37 +0100 (CET)
Subject: Re: [PATCH v3 28/36] serial: ucc_uart: explicitly include
 soc/fsl/cpm.h
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-29-linux@rasmusvillemoes.dk>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a921b57b-04d5-4874-89e2-df29dfe99bfc@c-s.fr>
Date:   Fri, 1 Nov 2019 17:19:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101124210.14510-29-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
> This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
> some other header pulling that in, do that explicitly. This is
> preparation for allowing this driver to build on ARM.
> 

UCC are only on QE.
CPM has SCCs. instead.
So this driver shouldn't need cpm.h

Christophe

> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/tty/serial/ucc_uart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
> index a0555ae2b1ef..7e802616cba8 100644
> --- a/drivers/tty/serial/ucc_uart.c
> +++ b/drivers/tty/serial/ucc_uart.c
> @@ -32,6 +32,7 @@
>   #include <soc/fsl/qe/ucc_slow.h>
>   
>   #include <linux/firmware.h>
> +#include <soc/fsl/cpm.h>
>   #include <asm/reg.h>
>   
>   /*
> 
