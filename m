Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809A2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 01:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YeN7hYJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfCMBIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 21:08:48 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:43212 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbfCMBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 21:08:47 -0400
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 5B48D4AC052D;
        Wed, 13 Mar 2019 04:08:43 +0300 (MSK)
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [2a02:6b8:0:1a2d::25])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FoG6rKuSzD-8h1CFxKQ;
        Wed, 13 Mar 2019 04:08:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1552439323;
        bh=s2T/OhBQdWp08r7Sf5SXWAn/LQY86hJ9X4QS/sVzhkY=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=YeN7hYJ1bKUbxVeOhAKlRWbj4GZoxZEEe6Uvs9QLtxHTC504yFbj1pOgRWA7jYDaa
         Gl/H+7qvlQ/9KEjZbcPxSptaPbd4Z3Xsi5bsm/s95LYRxCVD79AQwQPlzomM6st+E/
         9riB2VNw1XUid4syyDHKRecezLC4EldGlLLGeLuc=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id z9eYsMCQjY-8TXSwoW6;
        Wed, 13 Mar 2019 04:08:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH 4/4] MIPS: Loongson32: dts: add ls1b & ls1c
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mips@vger.kernel.org, paul.burton@mips.com,
        keguang.zhang@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190312091520.8863-1-jiaxun.yang@flygoat.com>
 <20190312091520.8863-5-jiaxun.yang@flygoat.com>
 <CABGGiszYh0uE_ybrfhK2byz4XZVAm9wvL5tQg0R85nnLt4c1iw@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <04e55af9-4d2f-bf93-4b8a-a59735fa4cae@flygoat.com>
Date:   Wed, 13 Mar 2019 09:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CABGGiszYh0uE_ybrfhK2byz4XZVAm9wvL5tQg0R85nnLt4c1iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for your reply, I have some questions on that:

在 2019/3/12 下午8:28, Rob Herring 写道:
> On Tue, Mar 12, 2019 at 4:16 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> Add devicetree skeleton for ls1b and ls1c
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>
>> +/ {
>> +       model = "Loongson LS1B";
>> +       compatible = "loongson,ls1b";
> Documented?
Should I document the vendor string or whole

"loongson,ls1b"?

>
>> +
>> +};
>> +
>> +&ehci0 {
>> +       status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +       status = "okay";
>> +};
>> \ No newline at end of file
> Fix this.
>
>> diff --git a/arch/mips/boot/dts/loongson/ls1c.dts b/arch/mips/boot/dts/loongson/ls1c.dts
>> new file mode 100644
>> index 000000000000..778d205a586e
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/loongson/ls1c.dts
>> @@ -0,0 +1,25 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <ls1x.dtsi>
>> +
>> +/ {
>> +       model = "Loongson LS1C300A";
>> +       compatible = "loongson,ls1c300a";
>> +
>> +};
>> +
>> +&platintc4 {
>> +       status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +       status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +       status = "okay";
>> +};
>> \ No newline at end of file
>> diff --git a/arch/mips/boot/dts/loongson/ls1x.dtsi b/arch/mips/boot/dts/loongson/ls1x.dtsi
>> new file mode 100644
>> index 000000000000..f808e4328fd8
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/loongson/ls1x.dtsi
>> @@ -0,0 +1,117 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +
>> +/ {
>> +    #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               cpu@0 {
>> +                       device_type = "cpu";
>> +                       reg = <0>;
> Needs a (documented) compatible string.
>
>
>
>> +               };
>> +
>> +               ehci0: usb@1fe20000 {
>> +                       compatible = "generic-ehci";
> It would be better to add a chip specific compatible here. Most all
> USB controllers have some quirks.
Should it be documented?
>
>> +                       reg = <0x1fe20000 0x100>;
>> +                       interrupt-parent = <&platintc1>;
>> +                       interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +           status = "disabled";
>> +                       };
>> +
>> +               ohci0: usb@1fe28000 {
>> +                       compatible = "generic-ohci";
>> +                       reg = <0x1fe28000 0x100>;
>> +                       interrupt-parent = <&platintc1>;
>> +                       interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +           status = "disabled";
>> +                       };
> Don't you need a serial port or something for a console?

serial port is currently added by legacy pdev code. I'm going to add it 
to devicetree after rework on clk driver being sent out.


Thanks.

--

Jiaxun Yang

