Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26732C73C64
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE60920838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGJMDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:03:42 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:39186
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbfGJMDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:03:42 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 5F57D216E4;
        Wed, 10 Jul 2019 12:03:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jul 2019 14:03:40 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] platform/x86/pcengines-apuv2: add legacy leds gpio
 definitions
In-Reply-To: <bf9c82c3-bc6e-b701-afd4-b4e657cb09be@metux.net>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-3-fe@dev.tdt.de>
 <bf9c82c3-bc6e-b701-afd4-b4e657cb09be@metux.net>
Message-ID: <e4583be44ddaa1453c0caea37d73d57d@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-08 21:42, Enrico Weigelt, metux IT consult wrote:
> On 04.07.19 11:02, Florian Eckert wrote:
>> Extend the apu2_leds definition to make the leds exportable via the
>> legacy gpio subsystem.
> 
> What for ? The gpios are bound to LED devices as that's exactly what
> they are: LEDs.

I have back ported your pcengines-apuv2 device and gpio-amd-fch GPIO 
driver to the kernel version 4.19 on OpenWrt.
If I compile and load this without the change no LEDs are visible in 
"/sys/class/leds"!

 From my point of view the connection between the GPIO and the LEDs 
subsystem is missing.
How should the LED subsystem know which GPIO to use?
If I add the change to the pcengines-apuv2 device then the LEDs will be 
visilbe under "/sys/class/leds"
and could be used, by OpenWrt userland.

Mybe I miss something.
