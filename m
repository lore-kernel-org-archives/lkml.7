Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DEECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F4B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404855AbfJWMR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:17:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36675 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388674AbfJWMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:17:28 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MA7X0-1iHFJE2lQo-00BcOV for <linux-kernel@vger.kernel.org>; Wed, 23 Oct
 2019 14:17:26 +0200
Received: by mail-qk1-f176.google.com with SMTP id q70so11953354qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:17:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWJ3Rhk6wlMKTHIRQ+UIz/CVQPFpktoKzgbuNs5s94sIc3fivW5
        619Gn+hYP73k+qiW2uYwaSlsaqomTqYFWL1fj20=
X-Google-Smtp-Source: APXvYqxlCRi94U4/07FvY9YopQfFLDcIB13QnbWMJwiRBOiqaePRpaNEEEoWQka/AGy7Trnj8CD2OnYa9IPlBMthAYQ=
X-Received: by 2002:a37:a50f:: with SMTP id o15mr6738929qke.3.1571833045564;
 Wed, 23 Oct 2019 05:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
In-Reply-To: <2e3d8287d05ce2d642c0445fbef6f1960124c557.1571828539.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:17:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
Message-ID: <CAK8P3a0i_xvSzeRxfT-5LLpaAfGx3USsuXX1dv1x6Bg87jeopg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update the Spreadtrum SoC maintainer
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>, baolin.wang7@gmail.com,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:pyss5pBBcEqxk0hSsa7vYy7/7ZMSd5xjCXz82Jr1oWmn3NUvlFe
 wkY9GCbDcnTRi/0wDb/L+mis2RsJPCfZ7KtauGBI08mK4MFKEszODO3Tsoqt1IoCEDyPVUR
 VjlAELAbqgIg/K5m39xE9t8XBdikzHkFM79/aodRO9w+sgGXwYE/9+/XmZl54oPk2J9hiCh
 9zj/3sEIL38sJL826sKBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hcVl4LEoD8Y=:66DZuZTRfbyC90wmFmXL2E
 VdA5efbhTf/I2MHtcO7c5Sjd052rhn6EVRQv5xjnB0tYT4e1yf+iuE16K/7yj5Qri3pdcP8oi
 3eFjdw2mnOfEs327YQRyW+MQYVLzwGSpb1d63OOfuS1jCtNhCU9jGyStzWq4v5jdRyW+74JEm
 L1ryJr4VtKkfHEDlw8DVb18r/U8AKp+fDTHL5/Ul3y5rIsNUIYkYsj0JLkjTvMjl3NCoj7C1+
 5UKUpy479YGFZrsRlmXqMO5dff4hjMCYaT3eHxg3Q6Zk8SQmtjSptCdu+Z4JmHVsUmzSrPdZ1
 rh2Ac1iSdSvnY9+KkHsClsJP5HigFzatpKZnXy+6Z8biZL3bgHLyzVKwfCgxeKHjyiQp6r6+q
 4Z3KoJhKgDVh23c8yJrdiM9q4qgW8+8eJyoL1s29bbeQJCCP2ko/Gy8xvRe9kj2TPOLekdJad
 Uwh5zeKJdhahADC9fiB6Pzl2LyIT32AfdoL7ixFeEIaA7G7yye+ag8JLnH6QLZqOlhOJv5qB9
 +t9kAQI8bADda351ka6gm28PDhAQqPDGBfKCIrFwfVztzivF1JGghUslMAZvFF73A297b37fP
 83SHoYX+BVCJOMFDx2sKGWx3BZXeFfYY8ojwQI5iYFJZ8x51DO2T67MQbYBSmRONs71L0rvSZ
 pEZTpaSscg/ay8m5IauKi4p+917agP2FPo1VuzKPyPDldiJ38kolXMOl/1Ib9ZNi+vTIK1wik
 PiqSMD5EoWkm3vircYBHMCpO5i8AMr2IVcvdpK4TTqvG2V7x5A7s1siLTJ5EXECHr7JDKNhcw
 Cyo0fNHFXWmJaUfYYpm0e8/LL1gAS1nZnudlQK5FWSAhrhBCBf/p0qYirvsl9WBUz+HfCrgK3
 REf5hk8h07/qCS5UOuKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 1:06 PM Baolin Wang <baolin.wang@linaro.org> wrote:
> +F:     drivers/power/reset/sc27xx-poweroff.c
> +F:     drivers/leds/leds-sc27xx-bltc.c
> +F:     drivers/input/misc/sc27xx-vibra.c
> +F:     drivers/power/supply/sc27xx_fuel_gauge.c
> +F:     drivers/power/supply/sc2731_charger.c
> +F:     drivers/rtc/rtc-sc27xx.c
> +F:     drivers/regulator/sc2731-regulator.c
> +F:     drivers/nvmem/sc27xx-efuse.c
> +F:     drivers/iio/adc/sc27xx_adc.c
>  N:     sprd

Maybe add a regex pattern for "sc27xx" instead of listing each file
individually?
That would simplify it when files move around or you add more drivers that
follow the same naming.

     Arnd
