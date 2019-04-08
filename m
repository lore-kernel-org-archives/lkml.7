Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86283C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6040320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDHQvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:51:51 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDHQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:51:50 -0400
Received: from [192.168.1.110] ([95.118.113.209]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4Ja3-1hDGVq3yHB-000Lr5; Mon, 08 Apr 2019 18:51:44 +0200
Subject: Re: [PATCH4/4] Add support for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190408111653.4260-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <50b65d2a-eec0-b152-14d1-4912ab6ef69a@metux.net>
Date:   Mon, 8 Apr 2019 18:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190408111653.4260-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xsu6JkYrmof9wx8YIlKqqmOQl/1P+olAF2KtY/+hmwl/JR341ZV
 fYyT2sL5SMisOy2iCCqki02butwMWcgwxXvguXLedarGcKXGByEVz4iipQg7eeTtjH2QFSx
 IXYhkmqPMJgTnBtqncCfpmc6w6DqKG70tgVc3TF1WGf94McQrlE7miLEhNFyflmjRFnfY6f
 rwNuKSWetrLNBLjzVlAUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BzL4v74y9ts=:maW7Hn18m5s9iyTqQpgA3o
 7QHdbQWpdpWswyu9QpwGSVFSSHdWj1GVmRGJlybpr9bmAakwxm+AHhFoQ80p91/9Xg00b9E/G
 F6RIfI6334c25nNvLpghWxmq1U777ExxrQzjukJLTnwhzR1hURmubV+UdcC+jum7+mbz3xYSf
 N2lRhZ6SDtXoR5cVaURLOPmaTWez0U9Yh248umqlaBCQPNzA2ZVayzHoSWNYGneK30F8LIBhh
 ZbMwFA4/mO4nirRJ7NPYjOxyKMRMc/Z9DHKItGGaauHzTMQG6GlBFDeCXVgGJrDrclXmQNhid
 wR9ybtgcgWyxERSndrzRdquhd7IoLCnezxwRBYL2DtycR77fZ3rfPsl2b0UuO/v9S36nWainA
 RuJrZxUHbWPp1qvS3mq13NGx8WtFP9zCUkYjIdq1My4vDJKAbtxLTxisN/9kI9la4aYjchqmL
 F5F2BaHL0KHwECZGkbr7vBGo7BJaCyKbBP8M4CSsoD2Fpw6wzDsfyLGIRk5tRgfoCfRdd7F+9
 JzS4Za/dySTuIIfY4Q+CzfhoeqUbr5DjeFrnhkdYCKbOnhTjAm1SbZjz+PkgN/i+Ap7EPuYCe
 5xObF8YmxMEAMHEnx0kH6B9RSoNrb5vVN7Ap49EmUqd2NT2uwhmD6HVr/m2wFFk+g3q0fnxcY
 TXKtxF/AxaiHWbcPnWDW3saDrmBwojYuIjhwNbABn5y8bAJK25fyHcmN19PDeG8NtfzsAUlTB
 tSiANWOBUkEbEgbZOmNvLh02g3ayDeZ+ByFbEIiyenVdWKfWzgIs2szTAdQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.19 13:16, Morris Ku wrote:

> +> There are 10's of examples available.  Please take a look around some
> +> of the existing drivers to see how their functionality is split.
> +
> 
> Could you please clearly tell me the name of driver for reference.

drivers/platform/x86/pcengines-apuv2.c

vs.

drivers/gpio/gpio-amd-fch.c


--mtx
-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
