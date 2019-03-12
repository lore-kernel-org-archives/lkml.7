Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF39C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929C420693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfCLPpS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:45:18 -0400
Received: from hermes.aosc.io ([199.195.250.187]:40685 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLPpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:45:17 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id B176D15FCBA;
        Tue, 12 Mar 2019 15:45:11 +0000 (UTC)
Date:   Tue, 12 Mar 2019 23:45:06 +0800
In-Reply-To: <20190312153654.25r5orlw7qjtlhbt@flea>
References: <20190312152256.35574-1-icenowy@aosc.io> <20190312152256.35574-5-icenowy@aosc.io> <20190312153654.25r5orlw7qjtlhbt@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 04/14] pinctrl: sunxi: v3: really introduce support for V3
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <7B6C1341-BAB5-48C5-9E60-11BCEAC3D0CD@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年3月12日 GMT+08:00 下午11:36:54, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Tue, Mar 12, 2019 at 11:22:46PM +0800, Icenowy Zheng wrote:
>> Introduce the GPIO pins that is only available on V3 (not on V3s) to
>the
>> V3 pinctrl driver.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c | 291
>+++++++++++++++++++++--
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h    |   2 +
>>  2 files changed, 275 insertions(+), 18 deletions(-)
>> 
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
>b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
>> index 6704ce8e5e3d..54c210871a95 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-v3.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Allwinner V3s SoCs pinctrl driver.
>> + * Allwinner V3/V3s SoCs pinctrl driver.
>>   *
>>   * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
>>   *
>> @@ -23,7 +23,7 @@
>>  
>>  #include "pinctrl-sunxi.h"
>>  
>> -static const struct sunxi_desc_pin sun8i_v3s_pins[] = {
>> +static const struct sunxi_desc_pin sun8i_v3_v3s_pins[] = {
>
>I'm not sure all that remaining is worth it to be honest. It adds a
>lot of noise for no particular reason (and the same goes for renaming
>the file itself)

Maybe keeping names is okay "for historial reasons".

In fact I want to keep them.

>
>Maxime

-- 
使用 K-9 Mail 发送自我的Android设备。
