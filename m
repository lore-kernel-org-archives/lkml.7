Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFE5C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42239222F9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfGVG4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:56:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54985 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:56:34 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MOzCW-1i3efv0yMO-00PJWn; Mon, 22 Jul 2019 08:56:19 +0200
Subject: Re: [PATCH] ia64: perfmon: Fix a typo
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tony.luck@intel.com, fenghua.yu@intel.com, david@redhat.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190721165144.3152-1-christophe.jaillet@wanadoo.fr>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a08f8eff-5043-dcf5-b4e1-22c0512bd8d3@metux.net>
Date:   Mon, 22 Jul 2019 08:56:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721165144.3152-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K6xyMsoIN7d243CUu0mPcMW7cw/GTRFrllJlYrKeOtfB9PgbTxf
 QjS3P6QtIGsuXAM2G6AofATlwsBkwq4OiIaAm23ZV9YPLmPaoc6hBl+azvjhyjB9l3eosyW
 BA3JzycnYh1Y6jqEUwfLR8eSpimvyKILTYtUzx3AAyftKIQfOJ+jDxVfx5HGkJe0kCdTloG
 OxAXtynS6tU0JATfxeX2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z8W/lO/kXJQ=:g/MJhBhg7xPCEJDgc+BbQh
 MXFdFiiJjoGCZKZcmyaNcgzmojhQhumgbCPNhzpKqdMcloz0EcNokgzaPu5CywxV/143i9nPC
 9Y1aLYXaKGQn5XFktHYMvfg0Us/ojRjzrk+UKMsI+IMsxJXf9glHPLhijnwuJU7x76p2HT7x7
 MmB1xBpeokUWskJC8sOTc3Wc+2I8ETvbe3MazTEBCkEeOt+zFTSYbnj4lCYPpx/k6mhNI6jIS
 jSHl5DGpAPs24hEqlx1rynWO0ZpD9VGCQBVvJ6HefQlgjYwlSKmgP6MLE0gbgx/7TDxOGblzB
 7C0OICHuce/ateEum3Lo9LkeG7xoGBsoycz1wq7J7fvjDEw1fJM3tJrJbH/zJhiBtj5Dwho/j
 EgdRd+kN/Bo1UJFNO6G3PfxT1TDX5rKRABAh1akforwmMJGiDNK6ZuvooJf99VQZz/rC1lSxQ
 PF0DR6+rsRUZQZ2tyaXLFCjvs4i0HtRIEADLuFP1jHuO4Ap/9RtWE4J9Xpn9NTTH5B+HPnSIB
 siI/Ap+cml70HXbS74iG40M7qOQDN/SY9u9mi1D/6CIaCKCrwPQKRFZx01BA9adm54mep5O0U
 GofiJH1tMsE8nSWwuBR1+cyCN/0F0Wk3kZKfp7ebRkJLpJRzHZ8UCMkXORfIjZu3P7Er0J05f
 SR4NN3pCk0usc+3fw2xBLhM2nE57+N0yLD3ujDc+D+zhTBDlXkitAHd3PsI5rlK0uTw4m5V+x
 pIywP7hOiboZvJ5T5NFAqG09aR0IEHht4pAFz6+aFxJSchc153tHldDjs6M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.19 18:51, Christophe JAILLET wrote:
> s/permfon.h/perfmon.h/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The reference to perfmon.h should maybe be just removed because I've found
> no information about the increasing order to respect.
> This is maybe now in another file?
> ---
>   arch/ia64/kernel/perfmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
> index 58a6337c0690..22795b420b10 100644
> --- a/arch/ia64/kernel/perfmon.c
> +++ b/arch/ia64/kernel/perfmon.c
> @@ -4550,7 +4550,7 @@ pfm_exit_thread(struct task_struct *task)
>   }
>   
>   /*
> - * functions MUST be listed in the increasing order of their index (see permfon.h)
> + * functions MUST be listed in the increasing order of their index (see perfmon.h)
>    */
>   #define PFM_CMD(name, flags, arg_count, arg_type, getsz) { name, #name, flags, arg_count, sizeof(arg_type), getsz }
>   #define PFM_CMD_S(name, flags) { name, #name, flags, 0, 0, NULL }
> 

Reviewed-By: Enrico Weigelt <info@metux.net>
-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
