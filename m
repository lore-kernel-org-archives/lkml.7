Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36263C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F80208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfGAKsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:48:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfGAKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:48:50 -0400
Received: from [192.168.1.110] ([95.114.20.47]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxUfn-1iRdpQ2PQv-00xtVK; Mon, 01 Jul 2019 12:48:33 +0200
Subject: Re: [PATCH v2] Coccinelle: Add a SmPL script for the reconsideration
 of redundant dev_err() calls
To:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
Date:   Mon, 1 Jul 2019 12:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Njcq1x3R4ZJkZ7KiN9HYHt+SP0u7e0aLw+qLGdcuybI5MhOotbE
 xj5KUayYBnDJQQM5w2Tmu/igOpNpoXaeujzHP6XWifVuFEaN4/DR6KioB9s5PEMNfHjRLMi
 /e5O0m0AWSrJQ0eNTOLW+fj8+uvFW6i54UdJdHqMHZK+OKIvjmjoMU1w0bMlBAIkOONSabT
 VfyI2YWfj+LRfAgP/Zd2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1rJFC1+hU2s=:BvEI2Da19ZyQR6c3PLw2Hn
 7V1fQho8Lh/gFk48KsiU98+nmqm0UblRwEiKtX/oz0gWF3EjeLauvDhW5vTKozo37F1zmNYrL
 ABO/bd8dtJyOM4q/lIhaOdEixq1tFOWiXA25gzxWKXVlK3Az/6Cb5hHIvubwhEi8oU9bj70Zt
 HvA2nxSDxueWdOVxoxSlKy0t7w2oOQkGaAp7OLvpo1ZcPRwgYntCV5QYbWCH6w5TSda9fDPl4
 2q+eJkdVxfwHpkexd6JG1GSNJoeHThyzndYsjR/OIcEnvALfimPHTLVMqGrRTWbcPfaaQ7gqK
 9PkdEMUj1frbncvdMTQEYL3EpJfDE+eAvscDUrBgWwYNP1qJwnpkUFRMvhW91Pp3TPcaSjZNi
 jeAyN1QDYzczOGHmkUUr3blspXS8TZBOwBQVPJcKlfvA2MrHWb7NT/8XY7K9aAxj6JXoG4LcF
 yoJ2hRKFmTKHL4YTM6pte6WbUY+LD3uB9LCZcwNy7Ri9ebLxVg6DyQHONYy2Sa+jKxRWPlxnn
 npFw8TTY0KkqCxY3VLbakHgt1mDLbpTSwDyaMgO/AyaGa8uwWy3SuuVIKIMPFx/q2mmZhungk
 Kb7qWGkUkWckcuDEJvonDjm3jA2qvf8WaQcMmPEfzGhEipx5IGYtfq89gqZ7KMqnlWAvx8Kbg
 p+HZTyXftm2ZRQ3IUKxil28DCskzok/NnCTUN06RjRsOrHq+c+gBxyYg8DDK6cUk3B+7fkARS
 F9XY7dCT1iipjOJ97dijSHg3wnXuTfevHRQl5AX19MkC7jnJWEa4DOvYFxw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.07.19 10:10, Markus Elfring wrote:

Hi folks,

> +@script:python to_do depends on org@
> +p << or.p;
> +@@
> +coccilib.org.print_todo(p[0],
> +                        "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> +
> +@script:python reporting depends on report@
> +p << or.p;
> +@@
> +coccilib.report.print_report(p[0],
> +                             "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> --

By the way: do we have any mechanism for explicitly suppressing
individual warnings (some kind of annotation), when the maintainer is
sure that some particular case is a false-positive ?
(I'm thinking of something similar to certain #praga directives for
explicitly ignoring invididual warnings in specific lines of code)

I believe such a feature, so we don't get spammed with the same false
positives again and again.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
