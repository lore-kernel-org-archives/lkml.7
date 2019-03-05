Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09326C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F80206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfCEADd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:03:33 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEADd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:03:33 -0500
Received: from [192.168.1.110] ([77.2.115.28]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MLzWL-1gj9gQ0wt7-00I01S; Tue, 05 Mar 2019 01:03:15 +0100
Subject: Re: [PATCH 3/3] x86: apuv2: select LEDS_CLASS
To:     Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>, Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190304201930.1622839-1-arnd@arndb.de>
 <20190304201930.1622839-3-arnd@arndb.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <24c191e1-f607-1320-2474-3db92383e383@metux.net>
Date:   Tue, 5 Mar 2019 01:03:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190304201930.1622839-3-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UV5mHVxPagaTWcSyiLVuzJhvKSnnqijoZqcj4r1gITnwH5T4PyW
 yNMTpIU90CzFeD2Mvu6yGTGqFdISuPdMNNVLkNVMZ3q7/8mDZdxnuNY4m+N6svkB0l5TBcc
 OufNHatM2bsjLqJ+KyJGIfXEePQss1ORfruFpKqgVI5mAOz3BYqCwwuU/mocR2sAwcgS/6N
 HGMoCinHFwHUit4e3m0sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nfbxny+BIac=:cS4F5el7YhEuOmVLE7Ibzq
 p4Jv+jM8+cxUAmFWBbQ6+mFJVdSoxtZHML61NSSLryTiKYKNib4BBAzNEhHAQtyp+xm0R75n3
 PRK8Hg73ilNq/7CPaY8T9dgaM15+hy8ga2yqXBMblX4V8a8chkovVMC/8mcFRHOk+8OnI9dYM
 oAmGHokeGSdsi4aqHHIwZZD1dNkAYXG/VpNvSm4cvUaUmc86pYmFdjs4CWzlJsxcB/PF/wOP6
 aa2IzT8uhB379IZ07zOpCH34IXPnNJGPZq84rJcTQmARpEp0Em+mOXQ9nPcpIoydUPvgpFV4f
 PWxXP88bTsJjIQz/oGfaSFqbyqqNDhw1KEGnmF6sTTCyWDyLWH4d/CS9/V4Z0iRh/vUGG9Oq6
 6/kswb6wgilQnEUGyCkFbH2UXnHdPhxTEnFag+9t1zM6rkUdcysP06GhhIYeoTj3tVJ6CvXpJ
 DfkAXI0Ue6DrWHp/lLAdtLvb8ZouEUqhqpeAzX6TMwmvxRWmdtR86E+WC8RmxOD8HdLQXbuKV
 7ytdoP1oj8ugfLerDwx28MtFFIZrBFZii6gYzbFGr5lYXGxGmjgulfly1yREaj0H5NRXwxhKV
 crx8yqmKqbuV/d/V3ehtdh9OKPDfzUTJXwgPmN9nmfTULJTsARpbKoXn7hlJNNYV64wdfqw+B
 PjHJpOooNgnl0gMXkcg0MjDgUrXy7dyqHW16R6zxNngRk00yh4YEtSHkQFLVLSwRYzGRDJdFf
 3ETViNe7Wj2w61thhYmTCsYy19bwTzD2o45zmLPPUJLJXMAKZg9W3gs3yi4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.19 21:19, Arnd Bergmann wrote:
> LEDS_GPIO can only be selected when LEDS_CLASS is already enabled:
> 
> WARNING: unmet direct dependencies detected for LEDS_GPIO
>   Depends on [m]: NEW_LEDS [=y] && LEDS_CLASS [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
>   Selected by [y]:
>   - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && INPUT_KEYBOARD [=y]
> 
> Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 4d65d37b0c86..d64529352a9c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1308,6 +1308,7 @@ config PCENGINES_APU2
>  	depends on INPUT && INPUT_KEYBOARD
>  	select GPIO_AMD_FCH
>  	select KEYBOARD_GPIO_POLLED
> +	select LEDS_CLASS
>  	select LEDS_GPIO
>  	help
>  	  This driver provides support for the front button and LEDs on
> 

ACK. Just was about to post the same :)

Reviewed-by: Enrico Weigelt, metux It consult <info@metux.net>


thx.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
