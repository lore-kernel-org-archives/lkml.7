Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4FE222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QFPRw2wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfJCCaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:30:46 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:39839 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbfJCCap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:30:45 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x932UWK9009002;
        Thu, 3 Oct 2019 11:30:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x932UWK9009002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570069832;
        bh=QxHhOEkIkq/jgs8YrzxW3BX+4WyvGRMGDurXlzbJLNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QFPRw2wfVMCji3syDnpvCHwp8kK0dVYzk3nYnJEO4D7lTvXFUqNfSp8LYr8vGd7A1
         B2sUDfm+2re1JvhvcokT3R98T1NHZzxvSOcE2j8EG9rWDOC3K50yyzZgXsm24CdS2B
         bp2dXf7lBAYdy6XLlL2ZxNPDCvE1mfSVLyoCvfnpe/QEO8wgHxUr6R2pNeY1jUDqwZ
         UIsnQLWxhI3mStgM3IuZRUfGOcZZRrllCfrtMv37XwOKTpCQQjfQEu96zoVUhkCFIN
         GjkvLaj5mD90crUci0xY+xV9BS8wyaRKffUn+CiDMhoz5/pLJ7yLJ4XB9l104I9Z/n
         DVLHn8V+g5Thg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id n63so410418uan.2;
        Wed, 02 Oct 2019 19:30:32 -0700 (PDT)
X-Gm-Message-State: APjAAAUSfBFRLB7XIPTPDAuw4MboeL9iGbS2RjBYuP1fjt906ons2CGt
        lpO+7qsbtoL4daxckTZSx/EOE1qwYJaxx+VKvYI=
X-Google-Smtp-Source: APXvYqyPyKxRpctDgXuUq/UtQJslEs0EOOS02aE4Im9+sSa0rLz2rp4unVI8jUbCTn2oElIg69i7KQzg5ObTVtqtVRM=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr952585uad.25.1570069831431;
 Wed, 02 Oct 2019 19:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190720120526.7722-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190720120526.7722-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 3 Oct 2019 11:29:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATW+pS4WY_P=ZQirPO_byQXREFZ7yKrCnPLxUH5EeNhQQ@mail.gmail.com>
Message-ID: <CAK7LNATW+pS4WY_P=ZQirPO_byQXREFZ7yKrCnPLxUH5EeNhQQ@mail.gmail.com>
Subject: Re: [PATCH] block: pg: add header include guard
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Sat, Jul 20, 2019 at 9:06 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add a header include guard just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Ping?


> ---
>
>  include/uapi/linux/pg.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/pg.h b/include/uapi/linux/pg.h
> index 364c350e85cd..62b6f69bd9fb 100644
> --- a/include/uapi/linux/pg.h
> +++ b/include/uapi/linux/pg.h
> @@ -35,6 +35,9 @@
>
>  */
>
> +#ifndef _UAPI_LINUX_PG_H
> +#define _UAPI_LINUX_PG_H
> +
>  #define PG_MAGIC       'P'
>  #define PG_RESET       'Z'
>  #define PG_COMMAND     'C'
> @@ -61,4 +64,4 @@ struct pg_read_hdr {
>
>  };
>
> -/* end of pg.h */
> +#endif /* _UAPI_LINUX_PG_H */
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
