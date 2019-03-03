Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB61C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C9220842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfCCTvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 14:51:00 -0500
Received: from foss.arm.com ([217.140.101.70]:54650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfCCTvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 14:51:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D5BEBD;
        Sun,  3 Mar 2019 11:50:59 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42EC23F706;
        Sun,  3 Mar 2019 11:50:52 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: decrease rising edge time of UART2
To:     Tony McKahan <tonymckahan@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Brian Norris <briannorris@chromium.org>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Levin Du <djw@t-chip.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190303122705.27094-1-katsuhiro@katsuster.net>
 <1623469.Hy6pdcMFRX@phil>
 <e722acb4-167f-8333-5c8a-b693815273f4@katsuster.net>
 <CAERgoknAV1sACSPjM_u4WyWzLvmUntXMoEx=ccpFsqYZVeu__Q@mail.gmail.com>
 <26c3aea3-959f-bfb3-177f-3e5314494361@katsuster.net>
 <CAERgoknMO6xMzuhCn2kSHZm8Pt+6YH3jDvJckJq28u9OW08u2Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7ac5038b-ce5d-89d1-4eee-6864837272c6@arm.com>
Date:   Sun, 3 Mar 2019 19:50:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAERgoknMO6xMzuhCn2kSHZm8Pt+6YH3jDvJckJq28u9OW08u2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-03 6:45 pm, Tony McKahan wrote:
> Hello Katsushiro,
> 
> On Sun, Mar 3, 2019 at 12:31 PM Katsuhiro Suzuki
> <katsuhiro@katsuster.net> wrote:
>>
>> Hello Tony,
>>
>> On 2019/03/04 0:13, Tony McKahan wrote:
>>> On Sun, Mar 3, 2019 at 9:04 AM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>>>>
>>>> Hello Heiko,
>>>>
>>>> Thank you for comments.
>>>>
>>>> On 2019/03/03 22:19, Heiko Stuebner wrote:
>>>>> Hi,
>>>>>
>>>>> Am Sonntag, 3. März 2019, 13:27:05 CET schrieb Katsuhiro Suzuki:
>>>>>> This patch increases drive strength of UART2 from 3mA to 12mA for
>>>>>> getting more faster rising edge.
>>>>>>
>>>>>> RockPro64 is using a very high speed rate (1.5Mbps) for UART2. In
>>>>>> this setting, a bit width of UART is about 667ns.
>>>>>>
>>>>>> In my environment (RockPro64 UART2 with FTDI FT232RL UART-USB
>>>>>> converter), falling time of RockPro64 UART2 is 40ns, but riging time
>>>>>> is over 650ns. So UART receiver will get wrong data, because receiver
>>>>>> read intermediate data of rising edge.
>>>>>>
>>>>>> Rising time becomes 300ns from 650ns if apply this patch. This is not
>>>>>> perfect solution but better than now.
>>>>>>
>>>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>>> ---
>>>>>>     arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++--
>>>>>>     1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> your changing a core rk3399 property here, so I'd really like to get
>>>>> input from other board stakeholders on this before applying a core
>>>>> change.
>>>>>
>>>>> Could you either include the submitters of other rk3399-boards in the
>>>>> recipient list so that they're aware or limit the change to rockpro64 for
>>>>> the time being (aka overriding the property in the board-dts) please?
>>>>>
>>>>
>>>> OK, I'm adding other boards members.
>>>> by ./scripts/get_maintainer.pl arch/arm64/boot/dts/rockchip/rk3399-*.dts
>>>>
>>>>
>>>> RockPro64 directly connect UART2 pins of RK3399 to external connector.
>>>> I think maybe other RK3399 boards are facing same problem, but I cannot
>>>> check it because I have RockPro64 only...
>>>>
>>>> I'm happy if someone tell me other boards situation.
>>>
>>> I'm pulling out other rockchip boards momentarily to see what kind of
>>> population we have.
>>>
>>> Note these are not all running 5.x kernels, however none of them have
>>> the UART2 drive levels modified to my knowledge, and regardless, none
>>> show over 100 ns.
>>>
>>> board:    rise/fall
>>>
>>> rk3399-roc-pc: 90ns/90ns
>>> rk3399-rockpro64 V2.0:  90ns/45ns
>>> rk3399-rockpro64 V2.1:  40ns/41ns

I'm having to eyeball off a 20MHz analog scope (thank goodness for "yes" 
being able to generate a nice periodic signal), but for my NanoPC-T4 
with a cheap eBay FT232R adapter both rise and fall times are certainly 
<100ns. FWIW I've not noticed any issues with letting the Bluetooth 
interface on UART0 run flat-out at 4Mbaud either.

>>>
>>> Please make sure there's not a large amount of flux or something
>>> around the terminals on your board, that seems excessively high.
>>>
>>
>> Thank you for valuable information. For more deeply discussion,
>> I tried other conditions and watch the rise/fall times.
>>
>> 1) Not connect
>> The rise/fall times are 40ns/5ns when nothing connect (impedance is
>> very high) to external pin of RockPro64.
>>
>> What UART device are you using with RockPro64? If you use some device
>> with RockPro64 and board shows rise/fall times = 90ns/45ns, my device
>> is not suitable for RockPro64 by some reason. So it's better to drop
>> my patch.
> 
> The adapter is an FTDI FT232RL breakout board, attached with some
> generic Dupont connector jumpers.
> Interesting your RockPro is showing this symptom, perhaps there is a
> cold solder joint somewhere introducing resistance?
> 
>>
>> 2) Other SoC
>> I have other SoC board rk3328-rock64, Rock64 shows rise/fall times =
>> 90ns/80ns when same UART-USB device is connected to UART pin.
> 
> I measured similar on my Rock64 as well.
> 
>>
>> I think it shows rk3399's (or RockPro64's?) drive strength is a little
>> weak. So it's better to increase the drive strength of UART of rk3399.
> 
> I do not think this is a bad idea generally, it simply allows for more
> available current from the interface.  I'll let others be the judge of
> that, however.

There may be RK3399 users who would care about the possible EMI impact, 
so it's probably still best to limit such a change to boards which 
definitely need it.

Robin.

> 
>>
>> Best Regards,
>> Katsuhiro Suzuki
>>
>>>>
>>>> Best Regards,
>>>> Katsuhiro Suzuki
>>>>
>>>>
>>>>> Thanks
>>>>> Heiko
>>>>>
>>>>>
>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> index beaa92744a64..e3c8f91ead50 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>>>>> @@ -2000,6 +2000,11 @@
>>>>>>                        drive-strength = <8>;
>>>>>>                };
>>>>>>
>>>>>> +            pcfg_pull_up_12ma: pcfg-pull-up-12ma {
>>>>>> +                    bias-pull-up;
>>>>>> +                    drive-strength = <12>;
>>>>>> +            };
>>>>>> +
>>>>>>                pcfg_pull_up_18ma: pcfg-pull-up-18ma {
>>>>>>                        bias-pull-up;
>>>>>>                        drive-strength = <18>;
>>>>>> @@ -2521,8 +2526,8 @@
>>>>>>                uart2c {
>>>>>>                        uart2c_xfer: uart2c-xfer {
>>>>>>                                rockchip,pins =
>>>>>> -                                    <4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
>>>>>> -                                    <4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
>>>>>> +                                    <4 RK_PC3 RK_FUNC_1 &pcfg_pull_up_12ma>,
>>>>>> +                                    <4 RK_PC4 RK_FUNC_1 &pcfg_pull_none_12ma>;
>>>>>>                        };
>>>>>>                };
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-rockchip mailing list
>>>> Linux-rockchip@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>
>>>
>>
