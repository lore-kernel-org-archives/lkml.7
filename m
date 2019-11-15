Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E4C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62172071B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKOBIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:08:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:43692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbfKOBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:08:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDE13AEAB;
        Fri, 15 Nov 2019 01:08:33 +0000 (UTC)
Subject: Re: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
To:     James Tai <james.tai@realtek.com>
Cc:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
 <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
Date:   Fri, 15 Nov 2019 02:08:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Am 11.11.19 um 03:58 schrieb James Tai:
>> How much? More than 0x98000000? The RTD1395 datasheet says up to 4 GB -
>> does that mean it continues in a second region beyond 0xffffffff? Those
>> locations should be excluded in the soc node ranges (which you sadly appear to
>> have dropped in v2).
> 
> Sorry for my misunderstanding. The RAM region don't require 
> two cells for memory nodes, so I'll fix it in v3 patch.

Should I then also change RTD1395 to use only one cell, or does it
support more RAM than RTD1619?

By my calculation 0x98000000 is less than 2.4 GiB! So, does RAM continue
between r-bus and GIC, similar to how it does on RTD1195? Then we need
to exclude those RAM ranges from the SoC node (adjusting 0x68000000).

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
