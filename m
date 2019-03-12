Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E439BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC146214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfCLJeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:34:08 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfCLJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:34:07 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsI4Q-1gnklV3SlG-00tooP; Tue, 12 Mar 2019 10:33:47 +0100
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
To:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
 <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
Date:   Tue, 12 Mar 2019 10:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0SrY8q+Yz4chDSJzpBhN2boV3LJ1UlZAmHVRyM99spCvye5OLkk
 Zds8FtZ69RIvK3HlXYCyP4G+r5qL+hFPB8hI2OhM5SaADJPrgAWEM0Cc8Xh2igD58Xpl5YF
 22lL9syOjmsohWU/gFSiWYTIccc6Gbc8qsehHRrLajNdqJPnxPSKDeMHXZWuhOWDpJVMs0W
 EoMh6TNkXDUlKhJ2jpG/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hk2OouH5jz4=:9Ykb5WhMUxlKnMQEy9QfOf
 Il/mMzRaXz+ura8Dpca4OIGfDt72rdJwsX7RK82NLEw+qPdYLJl/axniO96C45Resip9cb88x
 Iqn++6Oc5CrXBmnJ7QVWUpstQb7FwNWaQOxTGlPxBktUsqytYmLcp1ygoZSUjdh6UL3K5rtZD
 i9pIApnmkqGpEGe9SyOn4xVMiUlch/WgCS9lDSBpLQnZGROaYF9rixKuHSonPzbzql+c3HhZs
 JaU+i+HZ5x5QxnobVIkT4FTx11v1PltlsYP7KE1Rj19UvNky1nACebUQS21Kk7fSnVZaVPtVq
 WOIp6ZYxD514IERwDNc7hI6q2SMvusE74SMkdVaVeHqlXNR5/gX657YH1ntWVi6yeIdsL+o3Q
 LUj0P4v4Qx3UA5h5EmY92BNrJ9X014TmO8R9KaR7hax3T4uDBX7D6VDLtE2m9iQpC92k8zVuL
 mdWy7m3muG9BhYOgyXMoNB2wuLrK/pZ/a0fR3i1ZD6fHkPKPNEAonJbbsZ9ehZFOHRqy2ZA1I
 KSHLaUL+83nhEegdDUmNGLQoGFezOkfuA07rjj+QmO4HFPR1ZngWQAA8w+swxGbT6gXfb1p14
 4Pmv2v0aHJ16XB/t12WuDfN3Npn34PTrOaktsh1vpKMVI8VU3HzdJeRazH4SiTa4qQ6RJNp0g
 XjRAnrt5zAAbBa16qXyC7KhV/yDUGyejekx+LpLCqn9cfXSEdEJiPLLoKkPuU2hn1e6ct9nyF
 CVnZoMkGjxc9zkBbkd+0pZew5n6GlsWXF31FnX2e3GfQwUnGTrTatEuwo2M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 10:17, Ben Dooks wrote:
> On 11/03/2019 18:54, Enrico Weigelt, metux IT consult wrote:
>> don't need the temporary variable "dev", directly use &pdev->dev
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> This is quite usual to do, and I like it as it saves typing.
> Personally I would say don't bother with this change.

hmm, both approaches have their valid arguments.

I'm not particularily biased to one or another ay, but I'd prefer
having it consistent  everywhere.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
