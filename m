Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F00C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D192084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDZPgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:36:55 -0400
Received: from david.siemens.de ([192.35.17.14]:57017 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfDZPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:36:54 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x3QFakpR004038
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Apr 2019 17:36:46 +0200
Received: from [167.87.22.130] ([167.87.22.130])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3QFajH0019960;
        Fri, 26 Apr 2019 17:36:45 +0200
Subject: Re: [PATCH] stmmac: pci: Adjust IOT2000 matching
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Miller <davem@davemloft.net>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>
References: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
 <CAHp75VddTO890=DMa8pQANBGMMaDtCGgVb_cxCHc_Y1hxNTHwg@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <28d2856b-7fe5-1b42-e1bc-1c3601265dd2@siemens.com>
Date:   Fri, 26 Apr 2019 17:36:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAHp75VddTO890=DMa8pQANBGMMaDtCGgVb_cxCHc_Y1hxNTHwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.19 16:34, Andy Shevchenko wrote:
> On Thu, Apr 18, 2019 at 12:15 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Su Bao Cheng <baocheng.su@siemens.com>
>>
>> Since there are more IOT2040 variants with identical hardware but
>> different asset tags, the asset tag matching should be adjusted to
>> support them.
>>
>> For the board name "SIMATIC IOT2000", currently there are 2 types of
>> hardware, IOT2020 and IOT2040. The IOT2020 is identified by its unique
>> asset tag. Match on it first. If we then match on the board name only,
>> we will catch all IOT2040 variants. In the future there will be no other
>> devices with the "SIMATIC IOT2000" DMI board name but different
>> hardware.
>>
>> Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
>> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
>> +       /*
> 
>> +        * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
> 
> 20202 ?

2020...

I can send a fix-up or v2, whatever is preferred.

Thanks,
Jan

> 
>> +        * The asset tag "6ES7647-0AA00-0YA2" is only for IOT2020 which
>> +        * has only one pci network device while other asset tags are
>> +        * for IOT2040 which has two.
>> +        */
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
