Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B1C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8329721922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JxxIXdPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfHGGqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:46:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18881 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfHGGqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:46:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4a73cc0001>; Tue, 06 Aug 2019 23:46:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 06 Aug 2019 23:46:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 06 Aug 2019 23:46:35 -0700
Received: from [10.2.165.207] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 7 Aug
 2019 06:46:35 +0000
Subject: Re: Warnings whilst building 5.2.0+
To:     Chris Clayton <chris2553@googlemail.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        LKML <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <df7c7cfc-25cf-5b92-91ab-ac355b660233@googlemail.com>
 <d5f09396-a562-7989-8e5b-8337c9c9a036@metux.net>
 <5276d608-e781-6190-e7df-bc22152b71c1@googlemail.com>
 <e576372c-fda0-ef9f-346c-3e5c0e5fd4a3@googlemail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
CC:     Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Message-ID: <d1413ca8-23e2-3f77-cd57-87b4229627aa@nvidia.com>
Date:   Tue, 6 Aug 2019 23:45:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e576372c-fda0-ef9f-346c-3e5c0e5fd4a3@googlemail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565160396; bh=RhlErAqo+BVMBo5ITbGPb45NDG3gmpKBZuREQLQhGmg=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:CC:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JxxIXdPELYMziTTuxXTHLD5F+6WI1zeQjVJmZty7kHmo3H6ewlJsx5rtw4sQht2pS
         S88kVcUdC9CKTH8c6932ythvJW/WWgjYE6TxcjGMcEOuRA+MMVX3Mi0Fl7iuqKEpTs
         +uFLDm2DUdsEPpTieyd5ItURMhi9KXpJa/MZZRLnUiddkjm0GQQZlmK+Fx7z2CAvh6
         wu1b8gaTAaLLlI+WzfI3ui9ZhcZST+yZf9AacSZJCkSkkmPsEX1p/mIDXAcebtB/UU
         f2Q1thhUpX6UWHwxx5JraHFZoaxmw5bzg/H1JLB8daOY+T89a3FHWxY7xQL/pTYPWO
         2BDBaHrsQ2wZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 11:30 PM, Chris Clayton wrote:
> On 09/07/2019 12:39, Chris Clayton wrote:
>> On 09/07/2019 11:37, Enrico Weigelt, metux IT consult wrote:
>>> On 09.07.19 08:06, Chris Clayton wrote:
...
>>> Can you check older versions, too ? Maybe also trying older gcc ?
>>>
>>
>> I see the same warnings building linux-5.2.0 with gcc9. However, I don't see the warnings building linux-5.2.0 with the
>> the 20190705 of gcc8. So the warnings could result from an improvement (i.e. the problem was in the kernel, but
>> undiscovered by gcc8) or from a regression in gcc9.
>>
> 
>  From the discussion starting at https://marc.info/?l=linux-kernel&m=156401014023908, it would appear that the problem is
> undiscovered by gcc8. Building a fresh pull of Linus' tree this morning (v5.3-rc3-282-g33920f1ec5bf), I see that the
> warnings are still being emitted. Adding the participants in the other discussion to this one.
> 

The warnings are still there because the fix has not been committed to any
tree yet.

If you could try out my proposed fix [1], and reply to that thread with perhaps a
Tested-by tag, that would help encourage the maintainers to accept it.

So far it hasn't made it to the top of their inboxes, but I'm hoping... :)


[1] https://lore.kernel.org/r/20190731054627.5627-2-jhubbard@nvidia.com
     ("x86/boot: save fields explicitly, zero out everything else")

thanks,
-- 
John Hubbard
NVIDIA
