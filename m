Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0E7C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B58E20673
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfFOC5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:57:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfFOC5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:57:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EBD726116911769F74C7;
        Sat, 15 Jun 2019 10:57:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 10:57:29 +0800
Subject: Re: [PATCH next] of/fdt: Fix defined but not used compiler warning
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
 <0702fa2d-1952-e9fc-8e17-a93f3b90a958@gmail.com>
 <CAL_JsqKsjK237W+-Yz4McxSZG=Gd3Pfp2JtgMnfAqiNRUcCg1g@mail.gmail.com>
 <41acc800-1ab8-c715-2674-c1204d546b4f@gmail.com>
 <CAL_Jsq+EVO9OiEK5bidywgKsfOCK+BgWvKehCNonqogegRfikA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <87eb8114-0b52-6324-43b2-aa8193808637@huawei.com>
Date:   Sat, 15 Jun 2019 10:57:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+EVO9OiEK5bidywgKsfOCK+BgWvKehCNonqogegRfikA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/14 21:53, Rob Herring wrote:
> On Wed, Jun 12, 2019 at 12:29 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 6/12/19 10:00 AM, Rob Herring wrote:
>>> On Wed, Jun 12, 2019 at 10:45 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> Hi Kefeng,
>>>>
>>>> If Rob agrees, I'd like to see one more change in this patch.
>>>>
>>>> Since the only caller of of_fdt_match() is of_flat_dt_match(),
>>>> can you move the body of of_fdt_match() into  of_flat_dt_match()
>>>> and eliminate of_fdt_match()?
>>>
>>> That's fine as long as we think there's never any use for of_fdt_match
>>> after init? Fixup of nodes in an overlay for example.
>>
>> We can always re-expose the functionality as of_fdt_match() in the future
>> if the need arises.  But Stephen's recent patch was moving in the opposite
>> direction, removing of_fdt_match() from the header file and making it
>> static.
> 
> Yes, we can, but it is just churn if we think it is likely needed.
> 
> OTOH, we probably want users to just use libfdt API directly and
> should add this to libfdt if needed.
> 
> So yes, please implement Frank's suggestion.

OK，done in patch v2.

> 
> Rob
> 
> .
> 

