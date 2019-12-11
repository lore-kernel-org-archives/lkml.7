Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E418C2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4683B2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfLKLC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:02:27 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:39977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfLKLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:02:26 -0500
Received: from [192.168.1.155] ([95.118.81.154]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNTy-1i5ew40D9U-00ZRFl; Wed, 11 Dec 2019 12:02:00 +0100
Subject: Re: [PATCH 02/10] tty: serial: samsung_tty: fix build warning
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
 <20191210143706.3928480-2-gregkh@linuxfoundation.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <181db297-2865-5b34-6ef1-e410babaf3bb@metux.net>
Date:   Wed, 11 Dec 2019 12:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210143706.3928480-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UT50J8jS+O2S/9OxMUm9VbwE4Uc5ui9b+5/2mfssfXgX7gstXYh
 v794Od+JFSR+AXZd6xGKhWx5cGrLbHktNqKvg0K0pha1WKf+6v/JE9d7o6RYluYowDYlNtB
 Hv6z2xrK/KnscNoYynkZoDUkv81cvKYgYk9/haP7FzHB8OPiazs93+LZNCDyZtWdxvP/mcV
 3UZRb+Ih7lWNu+dEwK13Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fp1viWlXRto=:J9OyfXmzpxj6Tp3U+1SQo9
 giFGmk6/go7HR5CkCRmfLF3hq7Dra6NGqfbPjbTzLp3UWkyaAZiewbojt73Y9KNRAjs++Gy/1
 swwK5mq0YekiYAn6Sg/H9HVf1ib+cMsnBQhFLg+/kN8PUsE+VRJghOa8kLSIlxj3UhJ/t1c91
 XDZHnMGQf5vpeckKnRxdl+gfE5kDFKwcTZRpoAnLTcCww/c5FyaAO0ModpX+4SDtvsHfgDTGO
 6VqJe4Hf7hWJHMpcDqBY/SWF7o9KQWgs1wTd1YWB9P77YALPWm0YUMgpVsOArfCiwY/CxFRNJ
 1LvIw5fAD9zH5EWsVee1ohe7CQqfA+dSK84EXQHyQxxE5JjHZJu5d7LijQR447s0nqo8n0yKq
 qmD48V1la7iQ0BrXfYJcE7NLcZVtqrR8G7rrx/XrW/30dDyijRE++1FgUAeiaG16LBqx7LPgm
 thTK0utJJA21A9vh1swj8ARNAUY3zf0YaneKSIIdcO9DHgylh197o0/2N9PwWH1vNkR0wLM2T
 fmT7epkEo0HbV1AuwkbjACwHDSFmx6UXwHTxEB6r99c/izTYmRumjMCpJLzY/q6ewan6wmAhs
 SHegSp2U7Et511tr82VzQNscyl6gcAhPQ8AKeLy9jRek7kTzAJDRGRRRm6s6Tl9v9Bmesa7tJ
 7rYVxqB6F60c7HPLZNLeN4fmuBZv1FDT3Z4P89AODQQWZLQNMK8Jj+jR0PubfbOVmcm8xcXX9
 VR6Xzo7HrW4MlYY9kRY0nJVpcllr/jyu0REys86WN4ublVWs+uh1eFXFd9myF0k+wLSsRRMGv
 yW8byDvsJlCyLhFFeIHG8BJFBeZVjLEqAWhdfoEZo7bXMedlPG5MluaymAn5JdiQSjutsiNdE
 cRAEYA8b+i8shCB0SM4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.19 15:36, Greg Kroah-Hartman wrote:

Hi,

> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 83fd51607741..67c5a84d0a26 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -1851,7 +1851,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
>  
>  /* Device driver serial port probe */
>  
> +#ifdef CONFIG_OF
>  static const struct of_device_id s3c24xx_uart_dt_match[];
> +#endif
> +

By the way: I've got some patch for conditionally declaring of match
tables (including MODULE_DEVICE_TABE() call), so such ifdef's aren't
needed anymore.

Would you like to see it ?
(IIRC already posted it quite some time ago, but probably went
unnoticed)


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
