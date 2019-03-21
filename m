Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22329C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D2B2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfCUOyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:54:11 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:29966 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfCUOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:54:10 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2LErrIp085086;
        Thu, 21 Mar 2019 23:53:53 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 21 Mar 2019 23:53:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2LErql3085080
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 21 Mar 2019 23:53:52 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: add HDMI sound node for
 rk3328-rock64
To:     Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
 <20190217173407.29189-2-katsuhiro@katsuster.net>
 <d42dd768-d6c1-098d-759f-e3576d0edcc2@katsuster.net>
 <AM3PR03MB0966F2308C6003C192A68F4DAC770@AM3PR03MB0966.eurprd03.prod.outlook.com>
 <fb36eddb-ef3b-df4a-5e1a-6f8866726ae9@katsuster.net>
 <b855ff66-19e5-4ea5-3337-23d5ada1bf1c@katsuster.net>
 <AM3PR03MB0966C5CA52CE87DFB35D172BAC460@AM3PR03MB0966.eurprd03.prod.outlook.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <77fb7f45-e44a-3cba-f135-6731ac76fb00@katsuster.net>
Date:   Thu, 21 Mar 2019 23:53:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <AM3PR03MB0966C5CA52CE87DFB35D172BAC460@AM3PR03MB0966.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonas,

Thank you for reply.

On 2019/03/17 21:33, Jonas Karlman wrote:
> Hello Katsuhiro,
> 
> Sorry for the delay, I have not been able to fully test this yet but will do more testing later tonight.
> 
> My concern are regarding how to configure a single graph card node to add a hdmi: (and iec958: for spdif) variants using an alsa config file.
> In LibreELEC I expose HDMI and SPDIF as two different card nodes to simplify applying alsa config files, see [1] and [2] for the alsa config files I use.
> Do you know how I can configure the hdmi: and iec958: cards and add a "IEC958 Playback" ctl with the combined graph card node?
> 

Currently I don't know how to and I don't have test environment for
IEC958 sound. Sorry...


> I am also working on NL-PCM/HBR-audio support for dw-hdmi-i2s and it will require "IEC958 Playback" ctl and players such as kodi and mpv only sets AES0-3 for hdmi: and iec958: cards.
> 
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/HDMI.conf
> [2] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
> 

Ah, I don't consider about Non-LPCM sound. I understand your concern.

My patch should be keeping until this problem is solved.


I'm going to find test environment and try KODI or mpv. Thank you for
great information!


Best Regards,
Katsuhiro Suzuki


> Regards,
> Jonas
> 
> On 2019-03-17 10:54, Katsuhiro Suzuki wrote:
>> Hello Jonas,
>>
>> How about this topic?
>>
>> I think this patch does not have bad effect for multi channel
>> sound of HDMI. If you don't think so, please tell me.
>> I wait your sound patch and after re-check this patch.
>>
>> Best Regards,
>> Katsuhiro Suzuki
>>
>> On 2019/03/03 4:26, Katsuhiro Suzuki wrote:
>>> Hello Jonas,
>>>
>>> Thanks for your comments.
>>>
>>> On 2019/03/03 2:20, Jonas Karlman wrote:
>>>> On 2019-03-02 15:19, Katsuhiro Suzuki wrote:
>>>>> Ping...
>>>>>
>>>>> On 2019/02/18 2:34, Katsuhiro Suzuki wrote:
>>>>>> This patch adds HDMI sound (I2S0) node for rock64.
>>>>>>
>>>>>> After apply this patch, UART2 will fail to allocate DMA resources
>>>>>> but UART driver can work fine without DMA.
>>>>>>
>>>>>> This error is related to the DMAC of rk3328 (pl330 or compatible).
>>>>>> DMAC connected to 16 DMA sources. Each sources have ID number that is
>>>>>> called 'Req number' in rk3328 TRM. Currently total 7 sources has been
>>>>>> activated as follows:
>>>>>>
>>>>>> | Req number | Source | Required  |
>>>>>> |            |        | channels  |
>>>>>> |------------+--------+-----------|
>>>>>> | 14, 15     | I2S1   | 2ch       |
>>>>>> |  6,  7     | UART2  | 2ch       |
>>>>>> |     10     | SPDIF  | 1ch       |
>>>>>> |  8,  9     | SPI0   | 2ch       |
>>>>>> |------------+--------+-----------|
>>>>>> |            | Total  | 7ch       |
>>>>>>
>>>>>> HDMI audio needs to activate new source I2S0 (Req number 11 and 12).
>>>>>> I2S0 can work concurrently with other sources, but rk3328 DMAC can
>>>>>> use max 8 channels at same time. If I2S0 is simply activated by this
>>>>>> patch, required DMAC channels will be 9. So last one (UART2) cannot
>>>>>> allocate the DMA resources.
>>>>>>
>>>>>> Virt-dma mechanism for pl0330 DMAC driver is needed to fix this
>>>>>> problem.
>>>>>>
>>>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>>> ---
>>>>>>     .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 21
>>>>>> ++++++++++++++++++-
>>>>>>     1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>>>>> b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>>>>> index 2157a528276b..bfc0930d245c 100644
>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
>>>>>> @@ -68,7 +68,8 @@
>>>>>>         sound {
>>>>>>             compatible = "audio-graph-card";
>>>>>>             label = "rockchip,rk3328";
>>>>>> -        dais = <&i2s1_p0
>>>>>> +        dais = <&i2s0_p0
>>>>>> +            &i2s1_p0
>>>>>>                 &spdif_p0>;
>>>> I am working on multi-channel hdmi audio support for dw-hdmi at [1]
>>>> and are wondering if having multiple dais on one graph card
>>>> instead of a separate hdmi sound card will affect the ability to
>>>> define a proper alsa config for multi channel hdmi sound.
>>>>
>>>> [1]
>>>> https://github.com/Kwiboo/linux-rockchip/compare/8874c206d613dc575f5cb6e385e7a866020138d0...92b20eaa6b6dd2cf3418a428f905d10bbc62724f
>>>>
>>>>
>>> It seems a part of multi channel (5.1 ch) has already been supported
>>> by rockchip-i2s and dw-hdmi. So I applied this patch and tried below
>>> command.
>>>     speaker-test -D hw:0,0 -f 48000 -c 6
>>> It does not return errors.
>>>
>>> Would you tell me more details you worried about if something wrong?
>>>
>>>
>>> FYI: Rock64 PCM devices are as follows after applied this patch.
>>> ~~~~~
>>> $ cat /proc/asound/pcm
>>> 00-00: ff000000.i2s-i2s-hifi i2s-hifi-0 :  : playback 1
>>> 00-01: ff010000.i2s-rk3328-hifi ff410000.codec-1 :  : playback 1 :
>>> capture 1
>>> 00-02: ff030000.spdif-dit-hifi dit-hifi-2 :  : playback 1
>>> ~~~~~
>>>
>>> Best Regards,
>>> Katsuhiro Suzuki
>>>
>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>>         };
>>>>>> @@ -141,6 +142,12 @@
>>>>>>     &hdmi {
>>>>>>         status = "okay";
>>>>>> +
>>>>>> +    port@0 {
>>>>>> +        hdmi_p0_0: endpoint {
>>>>>> +            remote-endpoint = <&i2s0_p0_0>;
>>>>>> +        };
>>>>>> +    };
>>>>>>     };
>>>>>>     &hdmiphy {
>>>>>> @@ -256,6 +263,18 @@
>>>>>>         };
>>>>>>     };
>>>>>> +&i2s0 {
>>>>>> +    status = "okay";
>>>>>> +
>>>>>> +    i2s0_p0: port {
>>>>>> +        i2s0_p0_0: endpoint {
>>>>>> +            dai-format = "i2s";
>>>>>> +            mclk-fs = <256>;
>>>>>> +            remote-endpoint = <&hdmi_p0_0>;
>>>>>> +        };
>>>>>> +    };
>>>>>> +};
>>>>>> +
>>>>>>     &i2s1 {
>>>>>>         status = "okay";
>>>>>>
>>>>> _______________________________________________
>>>>> Linux-rockchip mailing list
>>>>> Linux-rockchip@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>>>>>
>>>>
>>>>
>>>
> 
> 
> 

