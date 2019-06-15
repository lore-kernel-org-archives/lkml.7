Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A4C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F302173C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfFODCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 23:02:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbfFODCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 23:02:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3A3B0EC38FB9B4569D4A;
        Sat, 15 Jun 2019 11:02:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Sat, 15 Jun 2019
 11:02:26 +0800
Subject: Re: [PATCH -next] x86/amd_nb: Make hygon_nb_misc_ids static
To:     Borislav Petkov <bp@alien8.de>
References: <20190614155441.22076-1-yuehaibing@huawei.com>
 <20190614175159.GO2586@zn.tnic>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <puwen@hygon.cn>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <a8ce777e-a45d-2525-5527-8eb3eb083883@huawei.com>
Date:   Sat, 15 Jun 2019 11:02:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190614175159.GO2586@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/6/15 1:51, Borislav Petkov wrote:
> On Fri, Jun 14, 2019 at 11:54:41PM +0800, YueHaibing wrote:
>> Fix sparse warning:
>>
>> arch/x86/kernel/amd_nb.c:74:28: warning:
>>  symbol 'hygon_nb_misc_ids' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
> 	       ^^^^^^^^^^^^^^^^^
> 
> Ha, what is that? :)
> 
> A new test bot?

Yes, our internal CI robot.

> 

