Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B894DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A54620896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfCQPvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 11:51:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45718 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCQPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 11:51:03 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 44MkLR6WhPz1rJD4;
        Sun, 17 Mar 2019 16:50:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 44MkLR3jvzz1qql8;
        Sun, 17 Mar 2019 16:50:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wMWx7SLMMlHI; Sun, 17 Mar 2019 16:50:52 +0100 (CET)
X-Auth-Info: Zh4TjbphzOCe6LC7WCHkygX8ZVCsYSAb5xxIjoO3yWI=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 17 Mar 2019 16:50:52 +0100 (CET)
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Heiko Stuebner <heiko@sntech.de>,
        devicetree-spec@vger.kernel.org, shawn.lin@rock-chips.com,
        Douglas Anderson <dianders@chromium.org>,
        vbyravarasu@nvidia.com, Jisheng Zhang <jszhang@marvell.com>,
        Lars-Peter Clausen <lars@metafoo.de>, jonathanh@nvidia.com,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-rockchip@lists.infradead.org, chaotian.jing@mediatek.com,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        grundler@chromium.org, Tim Harvey <tharvey@gateworks.com>,
        sudeep.holla@arm.com, lporzio@micron.com,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>,
        zhonghui.fu@linux.intel.com, kirill.shutemov@linux.intel.com
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com>
 <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de> <yw1xftrn2em9.fsf@mansr.com>
 <1fcd4dad-1e00-67cc-ac5d-24640ae34340@denx.de>
 <20190316153900.xqi55awrockovmsi@shell.armlinux.org.uk>
 <c23d6c4edf92d58aec86da811eaa97a5@agner.ch>
 <20190317154350.esbhdx4huzqe2jxy@shell.armlinux.org.uk>
From:   Marek Vasut <marex@denx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=marex@denx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6962d659-5308-1f06-7329-1595e41aaeac@denx.de>
Date:   Sun, 17 Mar 2019 16:50:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190317154350.esbhdx4huzqe2jxy@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/19 4:43 PM, Russell King - ARM Linux admin wrote:
> On Sun, Mar 17, 2019 at 04:05:14PM +0100, Stefan Agner wrote:
>> On 16.03.2019 16:39, Russell King - ARM Linux admin wrote:
>>> On Sat, Mar 16, 2019 at 01:33:58PM +0100, Marek Vasut wrote:
>>>> If you have a FS or partition table there, it does.
>>>> If you don't, I agree ... that's a problem.
>>>
>>> eMMC boot partitions are called mmcblkXbootY, and unless you have more
>>> than one eMMC device on the system, they can be found either by looking
>>> for /dev/mmcblk*boot* or by querying udev.  The advantage of using udev
>>> is you can discover the physical device behind it by looking at DEVPATH,
>>> ID_PATH, etc, but you may not have that installed on an embedded device.
>>>
>>> However, as I say, just looking for /dev/mmcblk*boot* is sufficient to
>>> find the eMMC boot partitions where there is just one eMMC device
>>> present (which seems to be the standard setup.)
>>>
>>>>> I don't care the slightest what the numbering is, as long as it is
>>>>> stable.  On some hardware, with an unpatched kernel, the mmc device
>>>>> numbering changes depending on whether or not an SD card is inserted on
>>>>> boot.  Getting rid of that behaviour is really all I want.
>>>>
>>>> Agreed, that would be an improvement.
>>>
>>> The mmc device numbering was tied to the mmc host numbering a while back
>>> and the order that the hosts are probed should be completely independent
>>> of whether a card is inserted or not:
>>>
>>>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>>>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
>>>
>>>         snprintf(rpmb_name, sizeof(rpmb_name),
>>>                  "mmcblk%u%s", card->host->index, subname ? subname : "");
>>>
>>> I suspect that Mans is quoting something from the dim and distant past
>>> to confuse the issue - as shown above, it is now dependent on the host
>>> numbering order not the order in which cards are inserted.
>>
>> Commit 9aaf3437aa72 ("mmc: block: Use the mmc host device index as the
>> mmcblk device index") which came in with v4.6 enables constant mmc block
>> device numbering. I can confirm that it works nicely, and it improved
>> the situation a lot.
>>
>> That being said, we still use a patch downstream which allows
>> renumbering using an alias. We deal with a bunch of different boards
>> with different SoC's. I have a couple of SD cards with various rootfs
>> and use internal eMMC boot quite often as well. Remembering which board
>> uses which numbering is a pain. Maintaining a patch is just easier...
>> Furthermore, U-Boot allows reordering and all boards I deal with use mmc
>> 0 for the internal eMMC. The aliases allow consistency.
> 
> Maybe eMMC should've been given a different block device name?

I presume that's because they have hardware and software partitioning
and that's why you want to discern those two.

-- 
Best regards,
Marek Vasut
