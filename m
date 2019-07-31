Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31506C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C6C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="evXEg1Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfGaGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:54:39 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:51394 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387622AbfGaGyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:54:38 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 99908A415D;
        Wed, 31 Jul 2019 08:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1564556075;
        bh=ThsOhNRIajeNUym+bp8b02ILLZbpBe61k5u1jccGA4k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=evXEg1ZuUxWP5CJvP5psdM7di4WpQYJivbeMTIixKqBCqE5GLn7H9RwcZR32Y9oyR
         0CL+5q84x8jCK4nU/WyASAM7NFAPO22oFL030wS+cqdlLl2hNMzqijqHnL2zdoe7F+
         JULn9s28Y+22TEIhoV6IwIT/mB9rauMJ3VqlXPhw=
Subject: Re: [PATCH 12/22] ARM: dts: imx6: Add touchscreens used on Toradex
 eval boards
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>
Cc:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
References: <20190730144649.19022-1-dev@pschenker.ch>
 <20190730144649.19022-13-dev@pschenker.ch>
 <CAOMZO5DRi6yawn3RF-Mouiejz0nc7htdsCjOBC_EXZZKUZ3nvA@mail.gmail.com>
 <60760aa2d4710252e13877c409d0c4d2267824a6.camel@toradex.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <e0f508aa-61d1-d555-040b-aa28e3ea8220@ysoft.com>
Date:   Wed, 31 Jul 2019 08:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <60760aa2d4710252e13877c409d0c4d2267824a6.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 07. 19 8:43, Philippe Schenker wrote:
> On Tue, 2019-07-30 at 17:46 -0300, Fabio Estevam wrote:
>> On Tue, Jul 30, 2019 at 11:57 AM Philippe Schenker <dev@pschenker.ch> wrote:
>>
>>> +       /* Atmel maxtouch controller */
>>> +       atmel_mxt_ts: atmel_mxt_ts@4a {
>>
>> Generic node names, please:
>>
>> touchscreen@4a
>>
>>> +               compatible = "atmel,maxtouch";
>>> +               pinctrl-names = "default";
>>> +               pinctrl-0 = <&pinctrl_pcap_1>;
>>> +               reg = <0x4a>;
>>> +               interrupt-parent = <&gpio1>;
>>> +               interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* SODIMM 28 */
>>> +               reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>; /* SODIMM 30 */
>>> +               status = "disabled";
>>> +       };
>>> +
>>> +       /*
>>> +        * the PCAPs use SODIMM 28/30, also used for PWM<B>, PWM<C>, aka
>>> pwm1,
>>> +        * pwm4. So if you enable one of the PCAP controllers disable the
>>> pwms.
>>> +        */
>>> +       pcap: pcap@10 {
>>
>> touchscreen@10
>>
>>> +               /* TouchRevolution Fusion 7 and 10 multi-touch controller */
>>> +               compatible = "touchrevolution,fusion-f0710a";
>>
>> I do not find this binding documented.
> 
> Thanks for your feedback Fabio, and sorry such obvious stuff went through. I
> will go through my whole patchset again more carefully lookup all the bindings.
>
Hi Philippe,
also look at the I2C sub-nodes - they should be sorted by the bus address.
In most of the patches it is not correct.

Michal
