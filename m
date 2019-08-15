Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D30C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAA620C01
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfHOCoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:44:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5376 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727659AbfHOCoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:44:11 -0400
X-IronPort-AV: E=Sophos;i="5.64,387,1559491200"; 
   d="scan'208";a="73693497"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Aug 2019 10:44:03 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 973C64CE032B;
        Thu, 15 Aug 2019 10:44:00 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 15 Aug 2019 10:44:10 +0800
Subject: Re: [PATCH] x86/fixmap: update stale comments
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <tglx@linutronix.de>, <bp@alien8.de>, <hpa@zytor.com>,
        <mingo@redhat.com>
References: <20190809114612.2569-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <69f31bf8-e957-951c-9c18-9a804ee770b7@cn.fujitsu.com>
Date:   Thu, 15 Aug 2019 10:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190809114612.2569-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 973C64CE032B.A65EF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Wish to know whether the patch make sense.

On 8/9/19 7:46 PM, Cao jin wrote:
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/fixmap.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
> index 9da8cccdf3fb..0c47aa82e2e2 100644
> --- a/arch/x86/include/asm/fixmap.h
> +++ b/arch/x86/include/asm/fixmap.h
> @@ -42,8 +42,7 @@
>   * Because of this, FIXADDR_TOP x86 integration was left as later work.
>   */
>  #ifdef CONFIG_X86_32
> -/* used by vmalloc.c, vsyscall.lds.S.
> - *
> +/*

Not seeing variable __FIXADDR_TOP & macro FIXADDR_TOP under
CONFIG_X86_32 referred in vmalloc.c, and there is no vsyscall.lds.S now.

>   * Leave one empty page between vmalloc'ed areas and
>   * the start of the fixmap.
>   */
> @@ -120,7 +119,7 @@ enum fixed_addresses {
>  	 * before ioremap() is functional.
>  	 *
>  	 * If necessary we round it up to the next 512 pages boundary so
> -	 * that we can have a single pgd entry and a single pte table:
> +	 * that we can have a single pmd entry and a single pte table:

The comments seems missed to be updated in an ancient commit 551889a6e2a24
>  	 */
>  #define NR_FIX_BTMAPS		64
>  #define FIX_BTMAPS_SLOTS	8
> 

-- 
Sincerely,
Cao jin


