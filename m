Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2261C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9802075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCLPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:00:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfCLPA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:00:27 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MKsaz-1hM4YE0Jzx-00LDhJ; Tue, 12 Mar 2019 16:00:07 +0100
Subject: Re: [PATCH 16/42] drivers: gpio: janz-ttl: drop unneccessary temp
 variable dev
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        hoan@os.amperecomputing.com, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-16-git-send-email-info@metux.net>
 <539b3cd4-8af3-d6d8-f5a9-2c426a1f0faa@codethink.co.uk>
 <93ae13c0-da78-0e6a-358f-97e358c11f16@metux.net>
 <20190312112607.GD31026@ulmo>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a3a56d82-ef94-9c71-2395-ed1a78dc9c26@metux.net>
Date:   Tue, 12 Mar 2019 16:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190312112607.GD31026@ulmo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ou+KFzSnuy7P5D4TczGQrE6uPpcZ/1V/Yh28iy/G6Icp1OwENlZ
 WDgNIgAO9W9bRcGGsfnF05YYCk2sYyQP/Qq3VLbN6kKhCzbNpyFbe0mrJ5bz+6Y0QMhJEgb
 RMPRkArcynlC/O58VrWDseI0MI1ZhpKFhaxVu9XzBssADElk7WDYm9wPd5qpK3XxBfjZi3i
 trlaoAPM374Dp9npsAaHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTTqjEIsuyA=:lcxl3NTsZLdqIm2cA6wMYG
 RRXKuevs6wzSxETR9Xp3zXuKkK5EDKe5ZTSm25f3GnPyPGF6cMoozq1Y9o8waa/j1UcErKvxA
 JXGkek44Ch5OOmOPIPwfdNWEKdMigFgYZcQC7kL/3u1lTwHC84fFPOlu1246wTpNe6kcX9Gkj
 8TjmhMkBz5F8smEwMywymJZDJw+B51yorEKRyB/s5+Z8wJAoykR7ZjtZzAW/x0KNSJEAfnwGB
 rMcSo8B4ArMIAk1wLY88hHPPFxS+tsAjuro5ONOYsvCvSaJ76m51rcFizNYUUDKCRkRVtoueY
 T3iuWjlab51YNk4pYVHFQpOIbS0hO8JVJlGIkoyLldF7U5wMgFhK+GRiUXxdHANzbvj9J0zMe
 TuPLvMXMvy4t7USHPwqDF4v8nMmbsdy6kS0sl6YhtMLcMkIVoxxH7M3j0n/Rh0Rr3dVPi88hA
 fw+tTKMz4OoTVhyrqdJ+CXDYPuhJz/f6RSMLnOFeTC/pBHt02QYJQmmXOmj0PSwv6IJJSyl3o
 l83GP79E9W0zUsoL8EtI3I85rBmpNadxfuU9JrGuhNZpKgwywYx7+3wmqLLurFHbDoCeXCEIH
 w1jf/1wAQopYAVhCu3t+MDs8zXl0SAFsdFZYDa5FBJQID3u/aKgFXzEnXVzfUGymB/q7Lj3ks
 Y8lzF6lE1MzymfJBf7mT/ruiEAznpMivDFioPtVrcjrb+RrjJANsNtA01WDCZcZGyB+6jpDSh
 yKq6O45ohgr0tk+OHrMySRSVPDEbQHHyZ6iO7CrDKKOjHmISH1ZrLDkJBoU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 12:26, Thierry Reding wrote:
> You're not consistent within the series itself. In patch 3 you went the
> other way and dropped usage of pdev->dev in favour of the local dev
> variable.

ups, you got me :O


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
