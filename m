Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7BFC76196
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7392084D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 09:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfGTJpk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 05:45:40 -0400
Received: from hermes.aosc.io ([199.195.250.187]:34877 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbfGTJpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 05:45:40 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id C64236ECDF;
        Sat, 20 Jul 2019 09:45:27 +0000 (UTC)
Date:   Sat, 20 Jul 2019 17:45:33 +0800
In-Reply-To: <20190720094449.dh53rbxz3mc74qls@flea>
References: <20190713034634.44585-1-icenowy@aosc.io> <20190713034634.44585-5-icenowy@aosc.io> <20190720094449.dh53rbxz3mc74qls@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v4 4/8] clk: sunxi-ng: v3s: add missing clock slices for MMC2 module clocks
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <DF2A53EE-E978-440A-98EF-76FF9F3DC84C@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年7月20日 GMT+08:00 下午5:44:49, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Sat, Jul 13, 2019 at 11:46:30AM +0800, Icenowy Zheng wrote:
>> The MMC2 clock slices are currently not defined in V3s CCU driver,
>which
>> makes MMC2 not working.
>>
>> Fix this issue.
>>
>> Fixes: d0f11d14b0bc ("clk: sunxi-ng: add support for V3s CCU")
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> New patch in v4.
>>
>>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> index 4eb68243e310..9c88015d4419 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
>> @@ -513,6 +513,9 @@ static struct clk_hw_onecell_data
>sun8i_v3s_hw_clks = {
>>  		[CLK_MMC1]		= &mmc1_clk.common.hw,
>>  		[CLK_MMC1_SAMPLE]	= &mmc1_sample_clk.common.hw,
>>  		[CLK_MMC1_OUTPUT]	= &mmc1_output_clk.common.hw,
>> +		[CLK_MMC2]		= &mmc1_clk.common.hw,
>> +		[CLK_MMC2_SAMPLE]	= &mmc1_sample_clk.common.hw,
>> +		[CLK_MMC2_OUTPUT]	= &mmc1_output_clk.common.hw,
>
>You're using the same structures than mmc1, I guess it's a copy and
>paste mistake?

Yes.

>
>Maxime
>
>--
>Maxime Ripard, Bootlin
>Embedded Linux and Kernel engineering
>https://bootlin.com

-- 
使用 K-9 Mail 发送自我的Android设备。
