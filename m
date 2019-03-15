Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E22218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCOXJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:09:38 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:42624 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCOXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:09:37 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44Lgyj64svz1rWGt;
        Sat, 16 Mar 2019 00:00:13 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44Lgyj2VGlz1rVxY;
        Sat, 16 Mar 2019 00:00:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id O9jPxGodituC; Sat, 16 Mar 2019 00:00:09 +0100 (CET)
X-Auth-Info: NPlppvH+VXGZviWeLaNRUWpuBoYKkgvcTJg36N2BeoQ=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sat, 16 Mar 2019 00:00:09 +0100 (CET)
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
To:     Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
        stefan@agner.ch, Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@marvell.com>,
        linux-rockchip@lists.infradead.org,
        devicetree-spec@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        vbyravarasu@nvidia.com, Lars-Peter Clausen <lars@metafoo.de>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        jonathanh@nvidia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        grundler@chromium.org, Kumar Gala <galak@codeaurora.org>,
        lporzio@micron.com, Rob Herring <robh+dt@kernel.org>,
        chaotian.jing@mediatek.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        sudeep.holla@arm.com, zhonghui.fu@linux.intel.com,
        kirill.shutemov@linux.intel.com
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=marex@denx.de; prefer-encrypt=mutual; keydata=
 mQINBFHmnxgBEACuQOC6Kaw/32MTeUJdFuDZ1FrbG76a0Ys/I02Kj9jXDmCCLvqq18Z4A1b0
 xbuMKGDy5WR77fqGV8zADUo6i1ATgCZeg+SRmQROF8r9K6n6digTznBySSLANhN3kXUMNRE1
 WEIBGCZJ5FF+Qq59AkAUTB8CiIzfEW98o7lUjeEume/78wR18+QW+2z6eYli2qNECceRINXT
 zS3oxRMr+ivqEUGKvMBC/WNLuvJoCGsfSQc2I+uGEU7MOdOCC6SsKdnPBGKYth5Ieb16bRS1
 b9M5BoEKTEzDCOWn92OxeHX6M2gLEMQobfM0RdIowMfWaUHdci2cLUTyL0T/P/gIpHMR2LhL
 8sdbNZufgv73s9PDgxTWMzypXimMJ7VZmVh9I2nQd2xm8+uE1rghqb90aEMFCTwUlrz4Qhjh
 vmczd2ScuuOMLzHEaaoOrMGbaWIEFcJvQgyHzJgMPgnG64eDq6uGyBEXRc3bBzv7B765Hcg8
 SSNqoUstjuQQlGp3y3Yj16l+PyZ3Ucy2swFYLVPTc35xFBk/uGEIhGncoFpOX29rxt9M8r5G
 hm7395m0GmDy50H/HN61/S8EPvM3HUjqBvX1EqU+vJXfwozxkKpIwcjx7h3W+PPS9TUb7r5v
 vHCqnrWRd/m6KWbCJsv0rsIU66o2qKYX5cIHV6u6Y7Zm7BtHfwARAQABtBtNYXJlayBWYXN1
 dCA8bWFyZXhAZGVueC5kZT6JAjgEEwECACIFAlHmnxgCGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEOtsLUEh5B0XLk0QAINOYFYB3v4KjXSFHYBQLlDblqhXvVtjyQHMiJsY1BMO
 mMrANUJQtpY3UkYquFspe2GBiFQbfW+mDlwFlSNpzaJ68qGEK+57I/MufsZKV6Ze9j7QeClu
 orYH+zfIBI7sn0HkY/MWN/Z270gRv2xSxDBP/8SPdB53EkImLZUFOo4/5eyuQ4t8HLgol02u
 2ncwXrnT036QC3SiNJDCJhwkpjvamPHghxr8hbIwkdOLZlYWfl0yzYzQohl8zBEwtBxl5cS4
 1TcrgBXsanQUMVNBpl0s8nQLKuHJNPOAhBnKstAe54yY3iWswYayHqqgqIQldcDqttHhdTJW
 mb9hTSf5p6fnZqcsfi3PUFwj5PJSN3aAbF8w42FwRvIOWbksFIWXpxYI3mq2TmX4GtlKdlF8
 xT+Q+Cbk538IBV4OQ5BapuYHs1C1ff9gVC0rfrCEloyteHafHwOv3ZuEGPlH89Rl4EjRvJxX
 8nE0sCiq6yUbpom8xRA5nFwA0bbTDwhH5RD/952bZraLpWcdJ6cWA2gefd2+2fy0268xyHmD
 m87B49BIaAsZ2kvEb/scCZ/CvPHjHLAjr+/GsdzOxwB68P41ZajujMDmbka00CyeAl88pgLX
 tTkPvAzuEDpRoJmg8zrQqrsmEKSdhFJhZ7d2MMKpCcVnInByXjM+1GEfSisTgWnluQINBFHm
 nxgBEAC8MpoO1s1AB0uRQGXlhYzkYvxkDGAe50/18ct2K6ORSv7HjCmZBjJX+2xTPSmML9ju
 3P0KrlnRdT8qCh+ozijffLjm5X9Fk+6mGQ56UQzivuPNlgyC3epF3Z58VPVQcIfE2/pdAxtZ
 zKc4P5t2yo5qk635huo0NvNg5mRhvfZ7mZpZuBahkHguR0Heh/tnGCa2v5P6uFbGX8+6rAA8
 EKxl5Tclf27PFZwbIWL1buS9RwgzsHj2TFnnEFIcWdMHyGy2GT8JMgY0VwxKebzGJg2RqfOL
 PaPjnvnXHAIYEknQp0TUtUiNxm0PBa4IQ30XhrB9D5QYdcw/DVvCzb9qyIlaQKEqHZm1fGU4
 iCsH3jV+5D4Lrn5JfXc/+A1NsLUq/NFIYhphbX4fGjR2QdZJrDnGVcxSlwP7CeRuxGELrASz
 m4G4Q0mYz7HdAlzBJHi8Ej4yC9l7PPlnxdUcAwheLxGwzMCf5vxw1C6Zi8PvKu/sY7Bha9XJ
 plvuLBi7QrkD8mZEzt+xC9nWRt7hL47+UvyduFe4qDMTPrW20ROxCykC36gj53YhqqLblioX
 2//vGLKj8x+LiLSTwjkLkrwOremhdTqr457511vOXyaZyOlWhFjN+4j9xwbbg1IWwMenRAb7
 Qwuipck6fN2o+PK9i6t6pWXrUDNI/VCMbimnuqPwAQARAQABiQIfBBgBAgAJBQJR5p8YAhsM
 AAoJEOtsLUEh5B0XMqAP/1HbrClefDZ/Lvvo89mgC56vWzEstmFo8EihqxVZvpkiCjJoCH53
 VCYeGl41p0y6K5gaLT28s9waVHBw+dhpwABba3neV/vyXv0wUtvkS3T0e4zruYFWw0lQoZi+
 8rtXTsuWN5t3u8avXsrdqD0CteTJdgZ7yBV8bBvK2ekqFMS/cLC+MoYlmUFn6Tcxmv0x8QZY
 ux6ts9YpUvx8QxMJt9vfwt1WIUEFKR3JQdrZmbPGqWJ3s+u/C+v9stC5qf2eYafRjzy05lEn
 B06W5D5Uc+FGEhuzq4G0eRLgivMoC0Eqz7HuwGcRAJYQILQ3Vzd4oHKPoUAtvlKqUwDmHodT
 HPmN73JMsvO3jLrSdl4k6o3CdlS/DI0Eto4fD0Wqh6d5q11u1TOM7+/LehWrOOoGVqRc6FFT
 ofck6h6rN/Urwkr1nWQ3kgO1cd/gevqy8Tevo/qkPYIf71BlypcXhKqn6IPjkq4QLiDPRjHM
 tgPc2T/X/ETe5eCuhxMytIYbt1fK2pDXPoIKbbDK4uEmg9USXZ+pYrac4PFo1d+6D6vmTjRZ
 GRRITOVpKgBndfPyqofxeKNKGdNf9FS/x89RlnDWXsQHm+0pXguSRG9XdB16ZFNgeo8SeZVr
 qc9uLfhyQp/zB6qEnuX1TToug7PuDgcNZdjN3vgTXyno2TFMxp/LKHqg
Message-ID: <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
Date:   Sat, 16 Mar 2019 00:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/19 10:52 PM, Tim Harvey wrote:
> Tim Harvey - Principal Software EngineerGateworks Corporation -
> http://www.gateworks.com/3026 S. Higuera St. San Luis Obispo CA
> 93401805-781-2000
> On Tue, Mar 5, 2019 at 4:39 AM Måns Rullgård <mans@mansr.com> wrote:
>>
>> Douglas Anderson <dianders@chromium.org> writes:
>>
>>> This series picks patches from various different places to produce what
>>> I consider the best solution to getting consistent mmc and mmcblk
>>> ordering.
>>>
>>> Why consistent ordering and why not just use UUIDs?  IMHO consistent
>>> ordering solves a few different problems:
>>>
>>> 1. For poor, feeble-minded humans like me, have sane numbering for
>>>    devices helps a lot.  When grepping through dmesg it's terribly handy
>>>    if a given SDMMC device has a consistent number.  I know that I can
>>>    do "dmesg | grep mmc0" or "dmesg | grep mmcblk0" to find info about
>>>    the eMMC.  I know that I can do "dmesg | grep mmc1" to find info
>>>    about the SD card slot.  I don't want it to matter which one probed
>>>    first, I don't want it to matter if I'm working on a variant of the
>>>    hardware that has the SD card slot disabled, and I don't want to care
>>>    what my boot device was.  Worrying about what device number I got
>>>    increases my cognitive load.
>>>
>>> 2. There are cases where it's not trivially easy during development to
>>>    use the UUID.  Specifically I work a lot with coreboot / depthcharge
>>>    as a BIOS.  When configured properly, that BIOS has a nice feature to
>>>    allow you to fetch the kernel and kernel command line from TFTP by
>>>    pressing Ctrl-N.  In this particular case the BIOS doesn't actually
>>>    know which disk I'd like for my root filesystem, so it's not so easy
>>>    for it to put the right UUID into the command line.  For this
>>>    purpose, knowing that "mmcblk0" will always refer to eMMC is handy.
>>>
>>> Changes in v2:
>>> - Rebased atop mmc-next
>>> - Stat dynamic allocation after fixed allocation; thanks Wolfram!
>>> - rk3288 patch new for v2
>>>
>>> Douglas Anderson (1):
>>>   ARM: dts: rockchip: Add mmc aliases for rk3288 platform
>>>
>>> Jaehoon Chung (1):
>>>   Documentation: mmc: Document mmc aliases
>>>
>>> Stefan Agner (2):
>>>   mmc: read mmc alias from device tree
>>>   mmc: use SD/MMC host ID for block device name ID
>>>
>>>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>>>  arch/arm/boot/dts/rk3288.dtsi                 |  4 ++++
>>>  drivers/mmc/card/block.c                      |  2 +-
>>>  drivers/mmc/core/host.c                       | 17 ++++++++++++++++-
>>>  4 files changed, 32 insertions(+), 2 deletions(-)
>>
>> Did anyone ever come up with an acceptable solution for this?  After
>> three years, I'm getting tired of rebasing these patches onto every new
>> kernel.
>>
>> UUIDs or similar are NOT an option for multiple reasons:
>>
>> - We have two rootfs partitions for ping-pong updates, so simply
>>   referring to "the thing with ID foo" doesn't work.
>>
>> - Installing said updates needs direct access the device/partition,
>>   which may not even have a filesystem.
>>
>> - The u-boot environment is stored in an eMMC "boot" partition, and
>>   userspace needs to know where to find it.
>>
>> I'm sure I'm not the only one in a similar situation.
>>
>> Russel, feel free to shout abuse at me.  I don't care, but it makes you
>> look stupid.
>>
> 
> Completely agree here - we need a dt solution that allows us to
> specify ordering.

Nope, ordering would be a policy and does not describe hardware, thus it
shouldn't be in the DT. Use UUID or PARTUUID, they apply both to raw FS
(fsuuid) and to partitions (part uuid). Linux kernel can mount FS using
PARTUUID, to support UUID you need initramfs.

> I support a variety of IMX6 boards where for PCB routing reasons the
> bootable MMC device is not always the first sdhc (sometimes the first
> one is an SDIO radio for example). It seems ridiculous that I can't
> handle this with:
> 
>         aliases {
>                 mmc0 = &usdhc3; /* MMC boot device */
>                 mmc1 = &usdhc2; /* SDIO radio */
>         };
> 
> I see the imx6q-dhcom-som added in
> 52c7a088badd665a09ca9307ffa91e88d5686a7d re-defines the default
> imx6qdl.dtsi mmc0-mmc3 aiases but I don't see any handling of this in
> code anywhere - am I missing something?
> 
> Marek, why did you change the alias ordering for imx6q-dhcom-som.dtsi?
> (maybe your carrying around a patch to make this useful?)

Nope, likely a cleanup remnant which can be dropped.

> +       aliases {
> +               mmc0 = &usdhc2;
> +               mmc1 = &usdhc3;
> +               mmc2 = &usdhc4;
> +               mmc3 = &usdhc1;
> +       };
> 
> Regards,
> 
> Tim
> 


-- 
Best regards,
Marek Vasut
