Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA7920708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVJnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:43:21 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:36687 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbfKVJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:43:21 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@misterjones.org>)
        id 1iY5T7-0006Qm-I2; Fri, 22 Nov 2019 10:43:13 +0100
To:     James Tai <james.tai@realtek.com>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 22 Nov 2019 09:43:13 +0000
From:   Marc Zyngier <maz@misterjones.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>
Organization: Metropolis
In-Reply-To: <7c94c59649c04442886a98c057c07654@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
 <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
 <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
 <7c94c59649c04442886a98c057c07654@realtek.com>
Message-ID: <23f44f6f4aec90b412d5d7ff6f4d95f1@www.loen.fr>
X-Sender: maz@misterjones.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: james.tai@realtek.com, afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-realtek-soc@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-17 15:39, James Tai wrote:
> Hi Andreas,
>
>> > Sorry for my misunderstanding. The RAM region don't require two 
>> cells
>> > for memory nodes, so I'll fix it in v3 patch.
>>
>> Should I then also change RTD1395 to use only one cell, or does it 
>> support
>> more RAM than RTD1619?
>
> Yes, you can. The memory capacity of RTD1395 and RTD1619 are the 
> same.
>
>> By my calculation 0x98000000 is less than 2.4 GiB! So, does RAM 
>> continue
>> between r-bus and GIC, similar to how it does on RTD1195? Then we 
>> need to
>> exclude those RAM ranges from the SoC node (adjusting 0x68000000).
>
> We need to reserve memory address for r-bus and GIC and exclude those
> RAM range from the SoC node.

Memory for the GIC? For what purpose?

         M.
-- 
Who you jivin' with that Cosmik Debris?
