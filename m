Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB9BC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE48720692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574068462;
	bh=6tp4vFg/UFdVPHR2BOJ+U6z4uozb3p1lDAJYSSgUfBE=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=wPwx+dlD88eYppIuj7UOCYu9yuEO4Ib1Livrv89AX8Kcw9LC1p3f9S5YJs0KIl5Pi
	 hEExg/E6Pl8BgRAysUY3jEnFHYqVpXRh6vgFVdVIoioWo8msmG8rkxKQUhegqDbu+v
	 Fn4Zri7FMJR7rO4C7b+lMhvPG0jMSO1VPfMXbTd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfKRJOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:14:21 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:52063 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbfKRJOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:14:20 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iWd6v-0005nP-NO; Mon, 18 Nov 2019 10:14:17 +0100
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 3/8] ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 18 Nov 2019 09:14:17 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        James Tai <james.tai@realtek.com>
In-Reply-To: <25965de3-cc82-7fe6-6b3d-5754c329ac07@suse.de>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-4-afaerber@suse.de> <20191117104726.2b1fccb8@why>
 <61bf74ad-b4a1-f443-bf99-be354b4d942b@suse.de>
 <86a78ujwwd.wl-maz@kernel.org>
 <25965de3-cc82-7fe6-6b3d-5754c329ac07@suse.de>
Message-ID: <e72d61bc883bdab70d81422f5b8acbef@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: afaerber@suse.de, linux-realtek-soc@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, james.tai@realtek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-18 01:24, Andreas Färber wrote:
> Am 17.11.19 um 17:22 schrieb Marc Zyngier:
>> On Sun, 17 Nov 2019 15:40:59 +0000,
>> Andreas Färber <afaerber@suse.de> wrote:
>>> Am 17.11.19 um 11:47 schrieb Marc Zyngier:
>>>> On Sun, 17 Nov 2019 08:21:04 +0100
>>>> Andreas Färber <afaerber@suse.de> wrote:
>>>>> +	timer {
>>>>> +		compatible = "arm,armv7-timer";
>>>>> +		interrupts = <GIC_PPI 13
>>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +			     <GIC_PPI 14
>>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +			     <GIC_PPI 11
>>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
>>>>> +			     <GIC_PPI 10
>>>>> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>>>>> +		clock-frequency = <27000000>;
>>>>
>>>> This is 2019, and yet it feels like 2011. This should be setup in 
>>>> the
>>>> bootloader, not in DT...
>>>
>>> What exactly - the whole node, the GIC CPU mask, the
>>> clock-frequency?
>>
>> The clock frequency. Having to rely on such hacks 8 years down the
>> line makes me feel like we've achieved nothing...
>> </depressed>
>
> Unfortunately I can confirm that without clock-frequency property I 
> get:

[trace showing how bad firmware can be]

I don't dispute that you need this for your broken bootloader.

But instead of adding hacks upon hacks to the kernel to support
subpar implementations, maybe you should consider putting efforts
in a u-boot port that doesn't suck.

         M.
-- 
Jazz is not dead. It just smells funny...
