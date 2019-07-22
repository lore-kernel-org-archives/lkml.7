Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F03C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9801422296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 06:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfGVG5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 02:57:53 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:40891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfGVG5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 02:57:52 -0400
Received: from [192.168.1.110] ([77.2.59.209]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYtoe-1htnpS2hzE-00UqxV; Mon, 22 Jul 2019 08:57:38 +0200
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
Message-ID: <e40f7695-488e-12b2-685e-831b23072815@metux.net>
Date:   Mon, 22 Jul 2019 08:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190721170824.3412-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kLD45ADuhfL0FMOt26oA1wDSraM+e67+Mv8pwpi/0ivRetWSlLu
 Mhah2HZOMNxUuVDuhUodpjif1FEPP8MfH2j4dWnwv6PujS+ilsx1CxmlvalSYTuVXqCNjhz
 hx0qMD0eob7xREgNvBrPyAgrKEe5LVM/YtZ8XfKpoOg+iGlJykrlRm+N/HRmqeEZIyOt0gY
 mHRBRAR4Hw8SNuDntmbZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgCvDxH5lsA=:mC8Z9pgFPysMBtiVi5lDai
 GXV3RBQUxbh1KmAqJ5Jo5olrRVjoK2eEU7i+VR8O8mOPrUhrnGWeflr74x6HLpp1Yf04ufD5K
 piCEvw1H3EKwYsH9XqB4mZyQUUYsvy/YLp0OkUD2VgZMfht+kA5pu/tZ1GcwI3gj76ViqziyH
 H7M8mWwvmfl4vdz15EMmSNEeDUVd8GwSVeSdaMO0/HQsPQ1UeAIgOviAs67LUYtQ7TOw8KGI8
 JJhlrkl14mky9BiyKvXojX8EIurndlJbFZ7LP+DvDOipyOaQxXWvLnd9Sxp90esxSvyPv2d2m
 scR/VhjBRj52j9elJE6R1MchiOX4EtoqTOW13M/QqqENkM+Ih1fvoG1mKDCud8y3E+o3jI7NB
 YnoDoLuldNGY3f9TsHBP0cODpUmX7Ms4uLWpGpdk4HJ0vI43Y7olYFvbhVb0eZQsk8qSVndfy
 AWsi+013yZgPOVYlvvI908spZHVgPn7fH8zDe/qMGttimP1OIPkTdkKSSU05b7Izye1d25cZx
 ozecrwYFVxhdwsN9u4G47Ig/W9Liu0ggxSnoIOwnFrtWLY3EQIlzOnkOTfvG9Y1INbqDeTCgm
 ewxzDT81n1628vOR2XCFlMTs3DUvjTu887GzDIForIwrecdwK5wU3otoOjO6rfaVSXojh4QTl
 V0FF9oZyFP0mgLfDOYl5fvwdbF00xU0sibcnaX9UR0Kw/6wF/EnCRUA9Y2LC3Kl2yTeVIAjy4
 kgfC0vxCBA/jGmKah/L4Nqr7FzZcwkDeuyc5jGpee3MLVer2RwQW7SKt7M8=
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
