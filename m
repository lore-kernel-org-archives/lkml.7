Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48950C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24399206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfCEAE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:04:59 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCEAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:04:58 -0500
Received: from [192.168.1.110] ([77.2.115.28]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MiaHf-1hUm9e106h-00fhib; Tue, 05 Mar 2019 01:04:49 +0100
Subject: Re: [PATCH 1/3] x86: apuv2: remove unused variable
To:     Arnd Bergmann <arnd@arndb.de>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <25276a71-2d50-0039-226c-3066a3767c0d@metux.net>
Date:   Tue, 5 Mar 2019 01:04:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190304201930.1622839-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Uo4FtpIIbUhZz+OyP3KWRgKtWnbSdowDlWmiNrcgxptJMAiyoFd
 6BuxuV1Jbn+Ogi+lmhguMTeEd76eAKfmn3bo0R/L9kzEBb/cmZha/5gL7KajiY4y7DeO+/p
 nocE+uhsHQI9NuZ3icLTPlalt4vSRIeLs2OJAmSucRKdPdzXo/Cis7SdNo7kFrt44NDxGrA
 AFPpmNXH9B3krLA0XYKAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DUjr4YUfLg=:mXMQqD5RXR01yQvIqcAvX8
 Y2++GE2JdZ2ESHGPV3qWDy0+I0yN4rdfcN9uF5wxV+bWbBq6pp2fEZO6QWLq9gme8SqiAMkCZ
 qTMc5TmyzwYZVjlpBquYFnySrahtPfHRh8RMVkIQVzQU24mjsvbYwjUJ18jtCt3jJSG8vsbRG
 Js0Uaj58b4t0yX3/wdldau5MGexJ0pT8a2l9eeJvrn8I1oPyB7KNH1Oe7pxvCcev8A2Nil0Mf
 3nb9kMmTDZXaAiyTHhLo9kwUVjHYsRcbsVa8nW1bQMVjWxQ3x/bAbsVT9zkV63pZfEdgX5+nx
 pObRm9DUjIPH62FLazNn8feFLK8aw4ZkQH9sQPOTxaiDwR5kYErXmF45b+7TN1DP6vk00dy/b
 0+IyYPle4eRplia5/aBIAbymwLMsQ3V3/YZ4KcXr2RU6krDPqtsBnlPmyDk/YjJWBKGvSWvft
 5+ZTUV5/8O7aNy0Vam8/fwLwT93XRcs6rVr2tdLcz0OU6rBC0J3OkUiO+JW4xb8iiMpJ6nlld
 F5LqsB2bXWBwfDtItyuI6BgHQ11Yr4f0crRqpScHzgjlcUr7FJPVtcYGWOzMDPHbKGmO+Dt+6
 6mjQDU84ajcbnjMxJNsRg8mU7VmcasoMITuXM271E00WfqOALQ9ELUZq+2YI1xjVMmKc6k2Sg
 cZIDAI5SUpYZ2b7CrEUsJ68vg52iBOtdejV+WYlCTAdMm+0Y7OSMYFhVQ+ZV/ihNJ48Mwv6xg
 dMEz6SIJiJF+GHrEgXJJ2hkOm6vpNonl6wVEpK3n4DQPKSLx2MhL+boFWWw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.19 21:19, Arnd Bergmann wrote:

> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index dcb084f6b892..c1ca931e1fab 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -208,7 +208,6 @@ static struct platform_device * __init apu_create_pdev(
>  
>  static int __init apu_board_init(void)
>  {
> -	int rc;
>  	const struct dmi_system_id *id;
>  
>  	id = dmi_first_match(apu_gpio_dmi_table);
> 

ACK.

Reviewed-By: Enrico Weigelt, metux IT consult <info@metux.net>


thx
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
