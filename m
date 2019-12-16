Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7A920717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 06:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfLPGCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 01:02:38 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:50249 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 01:02:38 -0500
Received: from [10.28.19.135] (10.28.19.135) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 16 Dec
 2019 14:03:07 +0800
Subject: Re: [PATCH v5 2/4] dt-bindings: watchdog: add new binding for meson
 secure watchdog
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        <devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-kernel@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1576153187-28378-1-git-send-email-xingyu.chen@amlogic.com>
 <1576153187-28378-3-git-send-email-xingyu.chen@amlogic.com>
 <CAFBinCBHLqgPExPsVaSWdSOr0Oj-jeYa4Z82U-pJ=fS+D1wGnA@mail.gmail.com>
From:   Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <f7b0afe7-e317-2422-de7e-878837f9f238@amlogic.com>
Date:   Mon, 16 Dec 2019 14:03:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBHLqgPExPsVaSWdSOr0Oj-jeYa4Z82U-pJ=fS+D1wGnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.28.19.135]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Martin

Sorry for the late reply.

On 2019/12/13 4:05, Martin Blumenstingl wrote:
> Hi Xingyu and Rob,
>
> On Thu, Dec 12, 2019 at 1:20 PM Xingyu Chen <xingyu.chen@amlogic.com> wrote:
> [...]
>> +examples:
>> +  - |
>> +    watchdog {
>> +          compatible = "amlogic,meson-sec-wdt";
>> +          timeout-sec = <60>;
>> +    };
> in v3 of this patch Rob commented that there shouldn't be an OF node
> if there are no additional properties
> with timeout-sec there's now an additional property so my
> understanding is that it's fine to have an OF node
Your understanding is correct.
>
> what I don't understand yet is where this node should be placed.
> is it supposed to be a child node of the secure monitor node (for
> which we already have a binding here:
> Documentation/devicetree/bindings/firmware/meson/meson_sm.txt) or
> where else would we place it inside the .dts?
IMO,  Although the watchdog node need to reference the meson_sm node, 
there is no
bus-like dependencies between the devices which the two nodes 
corresponding to.
so i think that the watchdog node as child node of meson_sm maybe not 
appropriate.
>
>
> Martin
>
>
> [0] https://patchwork.kernel.org/patch/11211399/
>
> .
>
