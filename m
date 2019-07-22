Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF6CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED1222FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfGVG4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:56:47 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:56:47 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mow06-1iDF8x0XgE-00qTUg; Mon, 22 Jul 2019 08:56:33 +0200
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
Message-ID: <6bc78765-fc54-8af9-18ad-7ed268a27439@metux.net>
Date:   Mon, 22 Jul 2019 08:56:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721165144.3152-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oMInqEll8Am+s4bDdCpGJEUj+H4PvNyxN1BZ6eIgIEUA+xiQjNg
 tlzgVf2KVvVDJ3hgNVywJQTx4Nd9cAx2zysPvmjF1tWWL5VE3onKexooY8QAgfH1KxRs0ow
 5BVbA/zwNcsTbU+xE9RuDVNMY4hDgzXdUoRqXkvfR0HYRFOxaGz+OH+vggwTLnQqKYPdDKf
 fZSW5R+b5gVGVNcIkorJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l8x6OU4UfjA=:VqFYd4addRDPIWw+F2Ickn
 3H+3o7Fp4KE8/kSIfZOjmxYU4uycL70nUFuc3QUOCKH0/KHJcAMtFzstnfFs740sCV9fCcLpN
 DorFw+6z/eAO4D7lyQjEsFJH9/bSLMHFVh8bNAPJDUM9Ph4NpSCwBINnzEQe4ioS/v+sYMaqR
 7UNcn+46Ktgx45W7/VYWK9fDuYjvmUK7gliKu2POL95bJ+OC/Rsl0ic2V71noetow9U0iKNu6
 UTp4jJimAYa2Dx7p6OpHx4un0gOh35njXiRaeuYg5n4i2/DRF8DEVWg/1CLqzP4Tvfcvy0kOg
 vSy/UZVZrFnG0pjusEz7OksSeBEneGR3M6gmwV7JwdJTfDpVebpxettieUIY2PWFI5aZP67+K
 jyO0LHgJwhtw+wJWA9vT283ZeTQ6MbCDYfDm8DkWhW3lyRio18IjlHbPWafvOUMTVljxZ+meV
 Kl75Uy0koRjg1q0MZjJCblypD1djc22n8IRjr2hK+TYo20Uecr5iABtTvAT86+Mh0S9YEzMLA
 1Flg2SNdv06f1lNx1DsLYheCGrVqgfAL2S+p/+MLHc/7hherLWyMhDCycUrQTt0VSlB8+YgX5
 6M1SwOTFkB692RRdY/TbkfWQI9jbelgdXrEz6zA+G4ZmOMtUPGQofXxKrMOT4fDeD9nVKae6n
 bMVyu4nZysGiJ5WbYHxUoLCOwLtQY1TPnpR1tBN1FrhYAA04XL4A6D+dzctgzUDZ6UwNPdgLH
 rtTm/r8IroJNApJn8s7euctoG6LKClJa9gfM+cOU92VY3TCUpjc7L93J1fI=
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
