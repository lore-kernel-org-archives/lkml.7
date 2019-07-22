Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F3C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D9522296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfGVG52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:57:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:57:27 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MirX2-1iJGlp2wBI-00euWx; Mon, 22 Jul 2019 08:57:13 +0200
Subject: Re: [PATCH] staging: unisys: visornic: Update the description of
 'poll_for_irq()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        david.kershner@unisys.com, gregkh@linuxfoundation.org,
        hariprasad.kelam@gmail.com, petrm@mellanox.com,
        davem@davemloft.net, jannh@google.com
Cc:     sparmaintainer@unisys.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190721170824.3412-1-christophe.jaillet@wanadoo.fr>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <9c65c094-ba60-cc07-e7eb-01741b91e04e@metux.net>
Date:   Mon, 22 Jul 2019 08:57:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721170824.3412-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JScHAmko/jR3RmQqKpq6XSnvVMIv55H856GaLZrnGxO++8seAuE
 1fkvweWFkXtqPnY8sFf8Ols5OTt74idCBjoz3tPw2cOsz/4s9G+Zl3x++3PB4yWuTWWKjd5
 XgQl6LxhSBh/7HZdRROnRhq0P28V2dsRmIW1yJVXJigQCe1s0JGuxVE5/p+1gC9/jyZXUTY
 851F4FVJAVEI0pG8JS4Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w7AfOcVe/+I=:B62PmOMa2anmPCxoyD1ff7
 eqqS72HTANJOrGw8YfLTgzNbXkhfTr0O31GIOUVqjSTn5WbqHBb1ZV1avD3dkCWILEhVCd3U1
 JyPrXDdlR77fViInOym2RUt3MprHCVOCnpW5/474wg31vR1ZDzN2VMsOCeLCQ8p2I5BVeDKYG
 KStQi2W7ayK8PG8WI2eB5/5CJ2boX7Lv+iSZkEYyk2p30RVTh9nCNF3pCA7VKTGOlW5QdRorG
 MnRspVZgNKle6Thy+AEO2LGd4c+7tKSqByqsPJ+3+OKDu1yY/GwQhmWkuS4ckX4kb5UFqkyVW
 vIEGrSwJhcDHvb9F5CxfYdC8tzgaOZy5e3WVlwoq8RGx0LOj0hYSV/Y/teWfd17fgsYr+uASl
 +KgizmpFy5q8NgQC83+8Y7JJTszSBYfB0QGPKjbFOKxTnQRUQjBUTXuWIx4G+EYRWBTmVwjSH
 QsNzP6xxFD1hikc6BuVu15+vzF1lflD1fI6UoiF4J+XxBJ3LgP/hkY2MNdwiZpOzDnVI5joRq
 Ia0YMMYvAVHl9Dw+5AGV6C3lAo8UhpzhOWMXtrhyN7eqT9JuGS5Y/BGL+94Xt6OYoelHp9jB0
 dEiLfA0Rrp98vzZmI47N1zBrGsHUb7i22mme4dgAuf5y7x2EnzVk13hwJX+pbekrKImLtffHn
 vU2QOnYTOhRb6nyjkXDULmoEUvVsa2FwOv3Z2A5qwiaF7hMIYiTXusJtEjdMYC2/XxJILQjhQ
 FLxjQFm998CTNSZ4O+DRHdqeYeb72mClP2ixcU8H5mVDlClpyiUZUjjU+go=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.19 19:08, Christophe JAILLET wrote:
> Commit e99e88a9d2b06 ("treewide: setup_timer() -> timer_setup()") has
> updated the parameters of 'poll_for_irq()' but not the comment above the
> function.
> 
> Update the comment and fix a typo.
> s/visronic/visornic/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/staging/unisys/visornic/visornic_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/unisys/visornic/visornic_main.c b/drivers/staging/unisys/visornic/visornic_main.c
> index 9d4f1dab0968..40dd573e73c3 100644
> --- a/drivers/staging/unisys/visornic/visornic_main.c
> +++ b/drivers/staging/unisys/visornic/visornic_main.c
> @@ -1750,7 +1750,8 @@ static int visornic_poll(struct napi_struct *napi, int budget)
>   }
>   
>   /* poll_for_irq	- checks the status of the response queue
> - * @v: Void pointer to the visronic devdata struct.
> + * @t: pointer to the 'struct timer_list' from which we can retrieve the
> + *     the visornic devdata struct.
>    *
>    * Main function of the vnic_incoming thread. Periodically check the response
>    * queue and drain it if needed.
> 
Reviewed-By: Enrico Weigelt <info@metux.net>

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
