Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C76D2148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 02:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCXCgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 22:36:45 -0400
Received: from [110.188.70.11] ([110.188.70.11]:47370 "EHLO spam1.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbfCXCgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 22:36:44 -0400
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
        by spam1.hygon.cn with ESMTP id x2O2OMvn050096
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 10:24:22 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id x2O2MFOk049970;
        Sun, 24 Mar 2019 10:22:15 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x2O2M8aa080870;
        Sun, 24 Mar 2019 10:22:08 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from [172.20.20.131] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Sun, 24 Mar
 2019 10:22:09 +0800
Subject: Re: [RFC PATCH v2] x86/cpu/hygon: Fix phys_proc_id calculation logic
 for multi-die processor
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1553355740-19999-1-git-send-email-puwen@hygon.cn>
 <20190323164006.GG23698@zn.tnic>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <ead21920-1186-8457-c68f-245e95cab591@hygon.cn>
Date:   Sun, 24 Mar 2019 10:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323164006.GG23698@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x2O2MFOk049970
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/24 0:40, Borislav Petkov wrote:
> On Sat, Mar 23, 2019 at 11:42:20PM +0800, Pu Wen wrote:
>>
>> v1->v2:
>>    - Define bit 6 of ApicId with a descriptive name.
>>    - Add description about why Hygon need to do something different than
>>      what AMD does.
> 
> In the future, such patch changelogs belong right...
> 
> ...
> 
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> ---
> 
> <--- here.

Okay, thanks for the suggestion.

-- 
Regards,
Pu Wen
