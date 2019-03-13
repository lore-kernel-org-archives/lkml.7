Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CCEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE297214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfCMKb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:31:29 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:41854 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfCMKb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:31:29 -0400
Received: from jain.kot-begemot.co.uk ([192.168.3.3] helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h40VI-0007GG-Gl; Wed, 13 Mar 2019 09:48:52 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by smaug.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1h40VH-0005iG-GX; Wed, 13 Mar 2019 09:48:51 +0000
Subject: Re: [PATCH] um: remove unused variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190312133037.5665-1-brgl@bgdev.pl>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4afb5d38-f2bd-9e79-fc62-c0cae83953e3@cambridgegreys.com>
Date:   Wed, 13 Mar 2019 09:48:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312133037.5665-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2019 13:30, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The buf variable is unused. Remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/um/kernel/skas/uaccess.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index 7f06fdbc7ee1..bd3cb694322c 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -59,7 +59,6 @@ static pte_t *maybe_map(unsigned long virt, int is_write)
>   static int do_op_one_page(unsigned long addr, int len, int is_write,
>   		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
>   {
> -	jmp_buf buf;
>   	struct page *page;
>   	pte_t *pte;
>   	int n;
> 
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
