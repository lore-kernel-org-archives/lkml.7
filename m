Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B1C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BB32082E
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKOJ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:29:03 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:27098 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:29:03 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAF9Sgqx014034;
        Fri, 15 Nov 2019 18:28:42 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Fri, 15 Nov 2019 18:28:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAF9Sf3j014028
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 15 Nov 2019 18:28:41 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] arm64: dts: rockchip: add analog audio nodes on
 rk3399-rockpro64
To:     Hugh Cole-Baker <sigmaris@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190907174833.19957-1-katsuhiro@katsuster.net>
 <CA+E=qVdvKxzFcU-09Ucn1Fr0FdkwSsPcLr8vPn2wsu6-DD1gqg@mail.gmail.com>
 <abc648cc-0b5d-b407-b74b-639833ba196b@katsuster.net>
 <CA+E=qVdy-wqmR+XOms5S2zMp+B0vM7Dj_fk9N=08-1WjfKDm0Q@mail.gmail.com>
 <CA+E=qVdLzHbNTemMSmhA=-0dsNumQZJhjE-EnXBDu+j7sXTnVw@mail.gmail.com>
 <81666aeb-f3d0-e653-6597-0711a05f9b8d@katsuster.net>
 <CA+E=qVcgs=2T_9axUCJwTKgmKhjsJJ9mUfvYJbyjg59rGGjcTg@mail.gmail.com>
 <CA+E=qVe5QmJ8-zSbKj23mb-GksjD+qN=aFaCT7OGUYPYc9Y_ow@mail.gmail.com>
 <1ecd115a-1d33-020d-4a09-6fc451588920@katsuster.net>
 <CA+E=qVcXcUJCa86ru+0=wwY7_3GFLJaGQtLeZ1wVZZqqG4-KrA@mail.gmail.com>
 <FEA6221E-A09B-46F2-A3F3-3771CE2368B3@gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <40193a79-6c64-19d8-6c55-b227bdb55e8f@katsuster.net>
Date:   Fri, 15 Nov 2019 18:28:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <FEA6221E-A09B-46F2-A3F3-3771CE2368B3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2019/11/14 0:02, Hugh Cole-Baker wrote:
> 
>> On 12 Nov 2019, at 14:46, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>
>> On Tue, Nov 12, 2019 at 10:34 AM Katsuhiro Suzuki
>> <katsuhiro@katsuster.net> wrote:
>>>
>>> On 2019/11/12 14:49, Vasily Khoruzhick wrote:
>>>> On Mon, Nov 11, 2019 at 9:43 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>>>
>>>>> On Mon, Nov 11, 2019 at 9:34 PM Katsuhiro Suzuki
>>>>> <katsuhiro@katsuster.net> wrote:
>>>>>>
>>>>>> Hello Vasily,
>>>>>>
>>>>>> Thank you for valuable information.
>>>>>>
>>>>>> On 2019/11/12 4:25, Vasily Khoruzhick wrote:
>>>>>>> On Sun, Nov 10, 2019 at 9:40 PM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Sun, Nov 10, 2019 at 7:30 PM Katsuhiro Suzuki
>>>>>>>> <katsuhiro@katsuster.net> wrote:
>>>>>>>>>
>>>>>>>>> Hello Vasily,
>>>>>>>>
>>>>>>>> Hi Katsuhiro,
>>>>>>>>
>>>>>>>> Thanks for response!
>>>>>>>
>>>>>>> Looks like on my board codec sits at address 0x10, and according to
>>>>>>> schematics that's what its address is supposed to be.
>>>>>>>
>>>>>>> See http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
>>>>>>>
>>>>>>> Codec address is selected by pin CE of ES8316, and on rockpro64 it
>>>>>>> goes to GND through R226. So address should be 0x10.
>>>>>>>
>>>>>>
>>>>>> Yes, I agree. The schematics both v2.0 and v2.1 say that ES8316
>>>>>> address is 0x10. Thank you for pointing.
>>>>>>
>>>>>> But I wonder that my RockPro64 behavior is strange, he is in address
>>>>>> 0x11. (R226 on my board is broken...??)
>>>>>>
>>>>>> root@rockpro64:~# i2cdetect 1
>>>>>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>>>>>> I will probe file /dev/i2c-1.
>>>>>> I will probe address range 0x03-0x77.
>>>>>> Continue? [Y/n] y
>>>>>>        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>>>>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>>>>>> 70: -- -- -- -- -- -- -- --
>>>>>>
>>>>>> I plan to check R226 resistance value to judge R226 is broken or not
>>>>>> after return to home. And share the result with you.
>>>>>> Please give me a time.
>>>>>
>>>>> Thanks for confirming that on your board it's on address 0x11. I
>>>>> checked with some other rockpro64 owners and they have it on 0x10, but
>>>>> looks like we have boards with codec on different address in the wild.
>>>>
>>>> Another datapoint is that my board is 2.0. If yours is 2.1 it can be a
>>>> difference between 2.0 and 2.1.
>>>>
>>>
>>> I'm using v2.1 board.
>>>
>>>
>>> I'll share the checking result. It's a little strange.
>>>
>>> 1) Voltage of CE pin of ES8316
>>>
>>> It is 1.8V when booting linux-next kernel.
>>>
>>>
>>> 2) My board
>>>
>>> I can't find no crack nor broken parts on my board.
>>>
>>>
>>> 2) R225, R226
>>>
>>> As you know, RockPro64 board has no silk print so we cannot know
>>> perfectly which resistance is R226. So this is my assumption.
>>>
>>>         PCIe, SD card slot
>>>            (top)
>>> LAN (left)ES8316(right) USB, reset button
>>>
>>> On the left space of ES8316 there is no resistance, only a pattern.
>>> This is maybe R225. And 10K resistance on the right side of a
>>> pattern. I assume this is R226.
>>>
>>> If my assumption is correctly, board implementation and schematics
>>> are different.
>>>
>>> schematics of v2.1 gets something wrong...??
>>
>> Guess we need few more RockPro64 v2.1 owners to confirm that it's
>> indeed the case.
> 
> I also have a RockPro64 board v2.1, and my ES8316 codec is at address 0x11.
> I'm using a kernel with Katsuhiro's patch and I can use alsamixer and play
> sounds out of the analog jack. My i2cdetect output:
> 
> root@kodi64:~# i2cdetect 1
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-1.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> 10: -- UU -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- —

Thank you for great report. Hmm, it seems v2.0 and v2.1 are different,
so we need to split device-tree for es8316 support...

Best Regards,
Katsuhiro Suzuki


> 
> Regards,
> Hugh
> 
>>
>>>
>>>>>> Best Regards,
>>>>>> Katsuhiro Suzuki
>>>>>>
>>>>>>
>>>>>>>>> Thank you for reporting.
>>>>>>>>>
>>>>>>>>> On 2019/11/11 9:17, Vasily Khoruzhick wrote:
>>>>>>>>>> On Sat, Sep 7, 2019 at 10:48 AM Katsuhiro Suzuki
>>>>>>>>>> <katsuhiro@katsuster.net> wrote:
>>>>>>>>>>>
>>>>>>>>>>> This patch adds audio codec (Everest ES8316) and I2S audio nodes for
>>>>>>>>>>> RK3399 RockPro64.
>>>>>>>>>>
>>>>>>>>>> Hi Katsuhiro,
>>>>>>>>>>
>>>>>>>>>> I tested your patch with my rockpro64 on 5.4-rc6 which has your other
>>>>>>>>>> patches to es8316 driver, but apparently it doesn't work.
>>>>>>>>>>
>>>>>>>>>> 'alsamixer' complains 'cannot load mixer controls: No such device or
>>>>>>>>>> address' and if I try to play audio with mpg123 it pretends that it
>>>>>>>>>> plays something but there's no sound.
>>>>>>>>>>
>>>>>>>>>> Any idea what can be wrong?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Do you use defconfig? If so I guess we need turn on more configs:
>>>>>>>>>
>>>>>>>>> - simple-graph-card driver (CONFIG_SND_AUDIO_GRAPH_CARD)
>>>>>>>>> - ES8316 (SND_SOC_ES8316)
>>>>>>>>
>>>>>>>> I have these enabled, card is present in /proc/asound/cards, but
>>>>>>>> alsamixer doesn't work with it.
>>>>>>>>
>>>>>>>>> FYI) ASoC related status or logs in my environment as follows:
>>>>>>>>>
>>>>>>>>> root@rockpro64:~# uname -a
>>>>>>>>> Linux rockpro64 5.4.0-rc6-next-20191108 #169 SMP PREEMPT Mon Nov 11 12:21:44 JST 2019 aarch64 GNU/Linux
>>>>>>>>
>>>>>>>> I'm running 5.4.0-rc6  (commit
>>>>>>>> 00aff6836241ae5654895dcea10e6d4fc5878ca6) with your patch "arm64: dts:
>>>>>>>> rockchip: add analog audio nodes on rk3399-rockpro64" on top of it.
>>>>>>>>
>>>>>>>>> root@rockpro64:~# dmesg | grep -i asoc
>>>>>>>>> [   21.509903] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
>>>>>>>>> [   21.510550] asoc-simple-card hdmi-sound: ASoC: no DMI vendor name!
>>>>>>>>> [   21.567906] asoc-audio-graph-card sound: ES8316 HiFi <-> ff890000.i2s mapping ok
>>>>>>>>> [   21.568565] asoc-audio-graph-card sound: ASoC: no DMI vendor name!
>>>>>>>>
>>>>>>>> Similar here:
>>>>>>>>
>>>>>>>> [vasilykh@rockpro64 ~]$ dmesg | grep -i asoc
>>>>>>>> [   15.627685] asoc-audio-graph-card sound: ES8316 HiFi <->
>>>>>>>> ff890000.i2s mapping ok
>>>>>>>> [   16.250196] asoc-simple-card hdmi-sound: i2s-hifi <-> ff8a0000.i2s mapping ok
>>>>>>>>
>>>>>>>>> root@rockpro64:~# cat /proc/asound/pcm
>>>>>>>>> 00-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi i2s-hifi-0 : playback 1
>>>>>>>>> 01-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : playback 1 : capture 1
>>>>>>>>
>>>>>>>> Same here:
>>>>>>>>
>>>>>>>> [vasilykh@rockpro64 ~]$ cat /proc/asound/pcm
>>>>>>>> 00-00: ff890000.i2s-ES8316 HiFi ES8316 HiFi-0 : ff890000.i2s-ES8316
>>>>>>>> HiFi ES8316 HiFi-0 : playback 1 : capture 1
>>>>>>>> 01-00: ff8a0000.i2s-i2s-hifi i2s-hifi-0 : ff8a0000.i2s-i2s-hifi
>>>>>>>> i2s-hifi-0 : playback
>>>>>>>>
>>>>>>>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/components
>>>>>>>>> hdmi-audio-codec.3.auto
>>>>>>>>> ff8a0000.i2s
>>>>>>>>> ff8a0000.i2s
>>>>>>>>> ff890000.i2s
>>>>>>>>> ff890000.i2s
>>>>>>>>> ff880000.i2s
>>>>>>>>> ff880000.i2s
>>>>>>>>> es8316.1-0011
>>>>>>>>> snd-soc-dummy
>>>>>>>>> snd-soc-dummy
>>>>>>>>
>>>>>>>> Same here.
>>>>>>>>
>>>>>>>>> root@rockpro64:~# cat /sys/kernel/debug/asoc/dais
>>>>>>>>> i2s-hifi
>>>>>>>>> ff8a0000.i2s
>>>>>>>>> ff890000.i2s
>>>>>>>>> ff880000.i2s
>>>>>>>>> ES8316 HiFi
>>>>>>>>> snd-soc-dummy-dai
>>>>>>>>
>>>>>>>> Same here.
>>>>>>>>
>>>>>>>> Yet alsamixer doesn't work for me. It terminates with 'cannot load
>>>>>>>> mixer controls: No such device or address'. Strace shows that fails
>>>>>>>> here:
>>>>>>>>
>>>>>>>> openat(AT_FDCWD, "/dev/snd/controlC0", O_RDWR|O_CLOEXEC) = 3
>>>>>>>> fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
>>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_PVERSION, 0xfffffd3ad04c) = 0
>>>>>>>> fcntl(3, F_GETFL)                       = 0x20002 (flags O_RDWR|O_LARGEFILE)
>>>>>>>> fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
>>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
>>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_LIST, 0xfffffd3ad228) = 0
>>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_INFO, 0xfffffd3ace38) = 0
>>>>>>>> ioctl(3, SNDRV_CTL_IOCTL_ELEM_READ, 0xfffffd3ac160) = -1 ENXIO (No
>>>>>>>> such device or address)
>>>>>>>>
>>>>>>>> Looks like it fails to talk to the codec?
>>>>>>>>
>>>>>>>> mpg123 thinks that it's playing audio, but my headphones connected to
>>>>>>>> 3.5mm output are silent.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Vasily
>>>>>>>>
>>>>>>>>
>>>>>>>>> Best Regards,
>>>>>>>>> Katsuhiro Suzuki
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Vasily
>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>>>>>>>>>>> ---
>>>>>>>>>>>     .../boot/dts/rockchip/rk3399-rockpro64.dts    | 28 +++++++++++++++++++
>>>>>>>>>>>     1 file changed, 28 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>>> index 0401d4ec1f45..8b1e6382b140 100644
>>>>>>>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>>>>>>>>>> @@ -81,6 +81,12 @@
>>>>>>>>>>>                    reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
>>>>>>>>>>>            };
>>>>>>>>>>>
>>>>>>>>>>> +       sound {
>>>>>>>>>>> +               compatible = "audio-graph-card";
>>>>>>>>>>> +               label = "rockchip,rk3399";
>>>>>>>>>>> +               dais = <&i2s1_p0>;
>>>>>>>>>>> +       };
>>>>>>>>>>> +
>>>>>>>>>>>            vcc12v_dcin: vcc12v-dcin {
>>>>>>>>>>>                    compatible = "regulator-fixed";
>>>>>>>>>>>                    regulator-name = "vcc12v_dcin";
>>>>>>>>>>> @@ -470,6 +476,20 @@
>>>>>>>>>>>            i2c-scl-rising-time-ns = <300>;
>>>>>>>>>>>            i2c-scl-falling-time-ns = <15>;
>>>>>>>>>>>            status = "okay";
>>>>>>>>>>> +
>>>>>>>>>>> +       es8316: codec@11 {
>>>>>>>>>>> +               compatible = "everest,es8316";
>>>>>>>>>>> +               reg = <0x11>;
>>>>>>>>>>> +               clocks = <&cru SCLK_I2S_8CH_OUT>;
>>>>>>>>>>> +               clock-names = "mclk";
>>>>>>>>>>> +               #sound-dai-cells = <0>;
>>>>>>>>>>> +
>>>>>>>>>>> +               port {
>>>>>>>>>>> +                       es8316_p0_0: endpoint {
>>>>>>>>>>> +                               remote-endpoint = <&i2s1_p0_0>;
>>>>>>>>>>> +                       };
>>>>>>>>>>> +               };
>>>>>>>>>>> +       };
>>>>>>>>>>>     };
>>>>>>>>>>>
>>>>>>>>>>>     &i2c3 {
>>>>>>>>>>> @@ -505,6 +525,14 @@
>>>>>>>>>>>            rockchip,playback-channels = <2>;
>>>>>>>>>>>            rockchip,capture-channels = <2>;
>>>>>>>>>>>            status = "okay";
>>>>>>>>>>> +
>>>>>>>>>>> +       i2s1_p0: port {
>>>>>>>>>>> +               i2s1_p0_0: endpoint {
>>>>>>>>>>> +                       dai-format = "i2s";
>>>>>>>>>>> +                       mclk-fs = <256>;
>>>>>>>>>>> +                       remote-endpoint = <&es8316_p0_0>;
>>>>>>>>>>> +               };
>>>>>>>>>>> +       };
>>>>>>>>>>>     };
>>>>>>>>>>>
>>>>>>>>>>>     &i2s2 {
>>>>>>>>>>> --
>>>>>>>>>>> 2.23.0.rc1
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> _______________________________________________
>>>>>>>>>>> linux-arm-kernel mailing list
>>>>>>>>>>> linux-arm-kernel@lists.infradead.org
>>>>>>>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 

