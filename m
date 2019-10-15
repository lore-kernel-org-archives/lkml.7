Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F320854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfJOTxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:53:23 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:33429 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732360AbfJOTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:53:22 -0400
Received: from [192.168.2.10] ([46.9.232.237])
        by smtp-cloud8.xs4all.net with ESMTPA
        id KSseiCgG9PduvKSshioaa5; Tue, 15 Oct 2019 21:53:20 +0200
Subject: Re: [PATCH 30/34] media: cec-gpio: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-31-bigeasy@linutronix.de>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <6897ccdb-e2b7-7739-e6b9-872306895a4f@xs4all.nl>
Date:   Tue, 15 Oct 2019 21:53:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015191821.11479-31-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfE5Eu1EU+oLl0bp2AAs6wxAWLjBsFS+3QqDnxRduIfeBGlKjagcsxLBIU8HY3kTurYtn7gMpP4ec9+LrSDUi64Mi9l6uN/tOlQDswPA2zIrY0AbufzqO
 XX0ZWifGFRI1SxRQO3OaXQII3luLDEtc5u+n+nBDQHj0kYWfGsRiqeqgW9x4WKiLVCz4/DIS/0IVugGifStd7TL1dkyfRglqTWW1Kdm1SLjaaJgtJtagJ3KF
 xxw3YtHMrUupHOTAl2wKeM9BZs5BqmBC0lIG8bH3CM7QMANY8izA2ImwwnMTpw1uaS0Vm0C9nDvHTAo2uMLFlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 9:18 PM, Sebastian Andrzej Siewior wrote:
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to CONFIG_PREEMPTION.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f1f61419fd292..56d4c1e91c276 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -585,7 +585,7 @@ config VIDEO_MESON_G12A_AO_CEC
>  
>  config CEC_GPIO
>  	tristate "Generic GPIO-based CEC driver"
> -	depends on PREEMPT || COMPILE_TEST
> +	depends on PREEMPTION || COMPILE_TEST
>  	select CEC_CORE
>  	select CEC_PIN
>  	select GPIOLIB
> 

