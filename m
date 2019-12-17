Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51867C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDDB206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfLQLt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:49:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLQLt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:49:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5504DACA7;
        Tue, 17 Dec 2019 11:49:56 +0000 (UTC)
Subject: Re: [PATCH] lib: crc64: include <linux/crc64.h> for 'crc64_be'
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <2a06908d-8dc4-5c7f-a40c-e9fb9ec96e70@suse.de>
Date:   Tue, 17 Dec 2019 19:49:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191217112633.2108845-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/17 7:26 下午, Ben Dooks (Codethink) wrote:
> The crc64_be() is declared in <linux/crc64.h> so include
> this where the symbol is defined to avoid the following
> warning:
> 
> lib/crc64.c:43:12: warning: symbol 'crc64_be' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

It is good to me. Added to my for-test patches. Thanks.

Coly Li

> ---
> Cc: Coly Li <colyli@suse.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  lib/crc64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/crc64.c b/lib/crc64.c
> index 0ef8ae6ac047..f8928ce28280 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -28,6 +28,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/crc64.h>
>  #include "crc64table.h"
>  
>  MODULE_DESCRIPTION("CRC64 calculations");
> 
