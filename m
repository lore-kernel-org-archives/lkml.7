Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CEEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C6206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfLMIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:41:29 -0500
Received: from [167.172.186.51] ([167.172.186.51]:40868 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfLMIl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 03:41:29 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 03:41:28 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 541DBDF383;
        Fri, 13 Dec 2019 08:32:22 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UZXf3XBqoR-G; Fri, 13 Dec 2019 08:32:21 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 918A9DFB07;
        Fri, 13 Dec 2019 08:32:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4I-m5DADgw5t; Fri, 13 Dec 2019 08:32:21 +0000 (UTC)
Received: from nedofet.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3B4CDDFB03;
        Fri, 13 Dec 2019 08:32:21 +0000 (UTC)
Message-ID: <71a8139e603f697c734134faedfb3ce87067918f.camel@v3.sk>
Subject: Re: [PATCH] ARM: mmp: include the correct cputype.h
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 13 Dec 2019 09:32:19 +0100
In-Reply-To: <20191210203409.2875880-1-arnd@arndb.de>
References: <20191210203409.2875880-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 21:34 +0100, Arnd Bergmann wrote:
> The file was moved, causing a build error:
> 
> In file included from /git/arm-soc/arch/arm/mach-mmp/pxa168.c:28:
> arch/arm/mach-mmp/pxa168.h:22:10: fatal error: cputype.h: No such file or directory
> 
> Include it from the new location.
> 
> Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
>  arch/arm/mach-mmp/pxa168.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
> index 6dd17986e360..34f907cd165a 100644
> --- a/arch/arm/mach-mmp/pxa168.h
> +++ b/arch/arm/mach-mmp/pxa168.h
> @@ -17,9 +17,9 @@ extern void pxa168_clear_keypad_wakeup(void);
>  #include <linux/platform_data/keypad-pxa27x.h>
>  #include <linux/pxa168_eth.h>
>  #include <linux/platform_data/mv_usb.h>
> +#include <linux/soc/mmp/cputype.h>
>  
>  #include "devices.h"
> -#include "cputype.h"
>  
>  extern struct mmp_device_desc pxa168_device_uart1;
>  extern struct mmp_device_desc pxa168_device_uart2;

