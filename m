Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5DB23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfH2N47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:56:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33524 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbfH2N44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:56:56 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4149C28D4FB
Subject: Re: [PATCH] arm/arm64: defconfig: Update configs to use the new
 CROS_EC options
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        SoC Team <soc@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Collabora kernel ML <kernel@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan iel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Daniel Mack <daniel@zonque.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yannick Fertr? <yannick.fertre@st.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
References: <20190827154851.10486-1-enric.balletbo@collabora.com>
 <20190827161045.GC26807@tuxbook-pro>
 <CAK8P3a2h2gUhxcVgD5JhR1Uo4qUSuG5yp4RCrAxevNmyD4ZRTA@mail.gmail.com>
 <2db6cde1-9e7f-8b1c-f2e4-80bdd2478d28@collabora.com>
 <CAK8P3a3zYpgouGAibyMjDykZmy+ABnx6AD2cYpHnXq9Zsw2V=w@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1fe8c0df-5e2d-6b6f-2a21-025a00b86f01@collabora.com>
Date:   Thu, 29 Aug 2019 15:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3zYpgouGAibyMjDykZmy+ABnx6AD2cYpHnXq9Zsw2V=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/8/19 14:09, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 12:10 PM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> On 27/8/19 18:12, Arnd Bergmann wrote:
>>> On Tue, Aug 27, 2019 at 6:08 PM Bjorn Andersson
>>> <bjorn.andersson@linaro.org> wrote:
>>>>
>>>> On Tue 27 Aug 08:48 PDT 2019, Enric Balletbo i Serra wrote:
>>>>
>>>>> Recently we refactored the CrOS EC drivers moving part of the code from
>>>>> the MFD subsystem to the platform chrome subsystem. During this change
>>>>> we needed to rename some config options, so, update the defconfigs
>>>>> accordingly.
>>>>>
>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
>>>>> Tested-by: Gwendal Grignou <gwendal@chromium.org>
>>>>
>>>> Can we make the entries in the generic arm64 defconfig modules?
>>>
>>> Good idea.
>>>
>>> Actually I would prefer to have all of them as modules for consistency,
>>> if at all possible.
>>>
>>
>> It is very common boot Chromebooks from an USB device, the EC needs to be
>> built-in in order to boot from these devices, otherwise you should use an
>> initramfs. I'd like to avoid forcing people to build an initramfs just to boot
>> from these devices if possible, in fact, my usual workflow is without initramfs,
>> and knowing that with the default defconfig just should boot helps a lot sometimes.
>>
>> Note that, it's not the case for EC subdevices, these are already build as modules.
> 
> Ok, fair enough, let's leave it built-in then.
> 
>> BTW, Lee asked if this patch should be squashed with the patches that really
>> renames the config options to help bisect ability, I don't have a hard opinion
>> as I don't usually run the config option between bisection steps, so please let
>> me know what do you prefer and I'll respin the patches ASAP if that's the case.
> 
> I'm not usually worried about bisection in defconfig changes, since like you
> say most commonly one would not run 'make defconfig' betweens the
> bisection steps.
> 
> If we really care about it, we could keep a symbol like this
> in drivers/platform/chrome/Kconfig for one release:
> 
> config CONFIG_MFD_CROS_EC
>         tristate "Enable ChromeOS Embedded Controller"
>         select CROS_EC
>         select CHROME_PLATFORMS
>         select CONFIG_MFD_CROS_EC_DEV
>         help
>            This is a transitional Kconfig option and will be removed
>            after everyone enables the parts individually.
> 

Not sure if really makes sense do this and tbh and don't have a hard opinion, so
I'll let the final decision to the soc/mfd maintainers. Just let me know and
I'll respin the patches with that if you really want.

Thanks,
 Enric

>       Arnd
> 
