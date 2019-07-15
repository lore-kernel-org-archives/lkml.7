Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A681C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24154216C4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392235AbfGOOjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:39:03 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:42280
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731051AbfGOOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:38:53 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 6F67D2197C;
        Mon, 15 Jul 2019 14:38:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Jul 2019 16:38:51 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
In-Reply-To: <3e98bbd8-c051-4996-fc5a-88a58a2fa2d4@metux.net>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
 <3e98bbd8-c051-4996-fc5a-88a58a2fa2d4@metux.net>
Message-ID: <10c574cd0dfb1c607536c68fc1c60c06@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to 
>> reset
>> the ports from the userspace, add the definition to this platform
>> device. The gpio can then be exported by the legancy gpio subsystem to
>> toggle the mpcie reset pin.
>> 
> 
> Just tested your patch on an apu3. The driver itself seems to work,
> but the pins don't seem to actually do anything.
> 
> How exactly did you test it ? Do you have some test case ?

I plugged in a mpcie  usb modem.
In my test case it was a EC25 from Quectel in mpcie2 port.
After that I did a reboot and exported the gpio via "/sys/class/gpio"
Then I executed the command "echo 0 > /sys/class/gpio/<name>/value" and 
"echo 1 > /sys/class/gpio/<name>/value".
Then I have seen the log message in the kernel that the device did an 
unregistration/registration
.
-- Florian

