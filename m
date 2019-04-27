Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED4C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32549206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 02:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfD0CjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 22:39:17 -0400
Received: from [110.188.70.11] ([110.188.70.11]:61527 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbfD0CjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 22:39:16 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id x3R2bnl2019982;
        Sat, 27 Apr 2019 10:37:49 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x3R2bQkC002778;
        Sat, 27 Apr 2019 10:37:26 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [192.168.1.193] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sat, 27 Apr
 2019 10:37:46 +0800
Subject: Re: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
To:     Jean Delvare <jdelvare@suse.de>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
 <20190426113751.77befab1@endymion>
 <0c895129-23af-2fc6-0c99-61348a69f961@hygon.cn>
 <1556297285.22365.4.camel@suse.de>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <8ec649c6-5282-6fb1-a1ee-a88dc897d644@hygon.cn>
Date:   Sat, 27 Apr 2019 10:37:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556297285.22365.4.camel@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x3R2bnl2019982
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/27 0:48, Jean Delvare wrote:
> On Fri, 2019-04-26 at 22:23 +0800, Pu Wen wrote:
>> On 2019/4/26 17:38, Jean Delvare wrote:
>>> I would like you to also document the new supported chipset in
>>> drivers/i2c/busses/Kconfig and Documentation/i2c/busses/i2c-piix4 as
>>> well as in the header comment of i2c-piix4.c itself. I know it seems
>>> redundant but it helps the user know which driver they need.
>>
>> Because Hygon uses the same PCI device ID of AMD's, so is it appropriate
>> to document with the name "Hygon CZ" or just "Hygon"?
> 
> "Hygon CZ" please, as Hygon is the vendor not the device, and I can

Okay.

> imagine you may create more devices in the future.

Surely.

-- 
Regards,
Pu Wen
