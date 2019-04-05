Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03E8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC94218D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfDEMLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:11:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfDEMLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:11:52 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3DAB3F82422FF6169E0B;
        Fri,  5 Apr 2019 20:11:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Fri, 5 Apr 2019
 20:11:43 +0800
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
 <271a33ae-b4fc-0528-cf59-5053dc46cce0@huawei.com>
 <20190405100703.GX9224@smile.fi.intel.com>
CC:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <rjw@rjwysocki.net>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8651647d-a606-1c1a-dce2-00a6b2dadbf9@huawei.com>
Date:   Fri, 5 Apr 2019 20:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190405100703.GX9224@smile.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/5 18:07, Andy Shevchenko wrote:
> On Thu, Apr 04, 2019 at 10:04:04PM +0800, YueHaibing wrote:
>> +cc Rafael and linux-acpi
> 
> Yeah, but please, address my comments and send v2.

Oh, sorry, I just forgot to send v2.

> 

