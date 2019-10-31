Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC78C47E49
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603B20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 06:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJaGgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 02:36:07 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:43516
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbfJaGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 02:36:07 -0400
X-IronPort-AV: E=Sophos;i="5.68,250,1569276000"; 
   d="scan'208";a="325190394"
Received: from abo-45-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.45])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 07:35:55 +0100
Date:   Thu, 31 Oct 2019 07:35:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, kim.jamie.bradley@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [Outreachy kernel] [PATCH v3 3/3] staging: rts5208: Eliminate
 the use of Camel Case in file sd.h
In-Reply-To: <20191030190514.10011-4-gabrielabittencourt00@gmail.com>
Message-ID: <alpine.DEB.2.21.1910310734520.2718@hadrien>
References: <20191030190514.10011-1-gabrielabittencourt00@gmail.com> <20191030190514.10011-4-gabrielabittencourt00@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 30 Oct 2019, Gabriela Bittencourt wrote:

> Cleans up checks of "Avoid CamelCase" in file sd.h
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/rts5208/sd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rts5208/sd.h b/drivers/staging/rts5208/sd.h
> index dc9e8cad7a74..f4ff62653b56 100644
> --- a/drivers/staging/rts5208/sd.h
> +++ b/drivers/staging/rts5208/sd.h
> @@ -232,7 +232,7 @@
>  #define DCM_LOW_FREQUENCY_MODE   0x01
>
>  #define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
> -#define DCM_Low_FREQUENCY_MODE_SET   0x00
> +#define DCM_LOW_FREQUENCY_MODE_SET   0x00

So this is never used in the kernel?  In that case, maybe it would still
be useful to keep it, because it somehow documents the device.  But the
log message should say that this is the case.

julia

>
>  #define MULTIPLY_BY_1    0x00
>  #define MULTIPLY_BY_2    0x01
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191030190514.10011-4-gabrielabittencourt00%40gmail.com.
>
