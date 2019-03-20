Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16891C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B262184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCTRnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:43:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41228 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCTRnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:43:24 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h6fFB-00011R-Qr; Wed, 20 Mar 2019 11:43:14 -0600
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     robh@kernel.org, dalias@libc.org, ysato@users.sourceforge.jp,
        linux-kernel@vger.kernel.org, sbates@raithlin.com,
        Christoph Hellwig <hch@infradead.org>,
        dan.j.williams@intel.com, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org
References: <mhng-bc5a03c7-1387-43e2-bd72-fb03e344e196@palmer-si-x1c4>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9ac29b0d-4c25-3f5c-3812-44b42332447d@deltatee.com>
Date:   Wed, 20 Mar 2019 11:43:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <mhng-bc5a03c7-1387-43e2-bd72-fb03e344e196@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-riscv@lists.infradead.org, hch@lst.de, dan.j.williams@intel.com, hch@infradead.org, sbates@raithlin.com, linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, robh@kernel.org, palmer@sifive.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] sh: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-19 8:54 p.m., Palmer Dabbelt wrote:
> On Tue, 19 Mar 2019 10:56:52 PDT (-0700), logang@deltatee.com wrote:
>> Hey Palmer,
>>
>> On 2019-01-23 12:56 p.m., Palmer Dabbelt wrote:
>>>> @Palmer: if you can just look at taking the second patch, I'll resubmit
>>>> the first one to the appropriate list.
>>>
>>> Works for me.  I'll queue the second patch into my staging branch, targeted for
>>> the next merge window.
>>
>> It doesn't look like my sparesmem patch made it into v5.1-rc1. Did it
>> fall through the cracks?
> 
> It must have, sorry.  Is this what you're referring to?
> 
>     https://patchwork.kernel.org/patch/10754911/

Yes, though it conflicts with v5.1-rc1 due to some code reorganization.

I've updated it and we will submit it later this week as part of a
larger patch set which helps enable p2p on RISC-V.

Logan
