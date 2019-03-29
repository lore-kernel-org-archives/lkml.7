Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776A8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E552173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfC2HnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:43:24 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:44432 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbfC2HnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:43:23 -0400
Received: from [10.28.18.125] (10.28.18.125) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 29 Mar
 2019 15:44:30 +0800
Subject: Re: 32-bit Amlogic (ARM) SoC: kernel BUG in kfree()
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Matthew Wilcox <willy@infradead.org>, <mhocko@suse.com>,
        <linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
        <rppt@linux.ibm.com>, <linux-mm@kvack.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <CAFBinCBOX8HyY-UocsVQvsnTr4XWXyE9oU+f2xhO1=JU0i_9ow@mail.gmail.com>
 <20190321214401.GC19508@bombadil.infradead.org>
 <CAFBinCA6oK5UhDAt9kva5qRisxr2gxMF26AMK8vC4b1DN5RXrw@mail.gmail.com>
 <5cad2529-8776-687e-58d0-4fb9e2ec59b1@amlogic.com>
 <CAFBinCA=0XSSVmzfTgb4eSiVFr=XRHqLOVFGyK0++XRty6VjnQ@mail.gmail.com>
 <32799846-b8f0-758f-32eb-a9ce435e0b79@amlogic.com>
 <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <79b81748-8508-414f-c08a-c99cb4ae4b2a@amlogic.com>
Date:   Fri, 29 Mar 2019 15:44:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCDHmuNZxuDf3pe2ij6m8aX2fho7L+B9ZMaMOo28tPZ62Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.125]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2019/3/29 2:03, Martin Blumenstingl wrote:
> Hi Liang, 
[......]
>> I don't think it is caused by a different NAND type, but i have followed
>> the some test on my GXL platform. we can see the result from the
>> attachment. By the way, i don't find any information about this on meson
>> NFC datasheet, so i will ask our VLSI.
>> Martin, May you reproduce it with the new patch on meson8b platform ? I
>> need a more clear and easier compared log like gxl.txt. Thanks.
> your gxl.txt is great, finally I can also compare my own results with
> something that works for you!
> in my results (see attachment) the "DATA_IN  [256 B, force 8-bit]"
> instructions result in a different info buffer output.
> does this make any sense to you?
> 
I have asked our VLSI designer for explanation or simulation result by 
an e-mail. Thanks.
