Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D25C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903C32467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSJg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:36:26 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:49736 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfLSJg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:36:26 -0500
Received: from localhost (unknown [192.168.167.172])
        by regular1.263xmail.com (Postfix) with ESMTP id D8A67BC9;
        Thu, 19 Dec 2019 17:36:01 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.30.14] (42.17.110.36.static.bjtelecom.net [36.110.17.42])
        by smtp.263.net (postfix) whith ESMTP id P31486T140079980852992S1576748159913946_;
        Thu, 19 Dec 2019 17:36:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8333cc4fcc79c2999bf3f5f41739d6d9>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: lvlisong@emindsoft.com.cn
X-SENDER-IP: 36.110.17.42
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
Subject: Re: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or disable
 irq sharing based on isa or pci bus
From:   Chen Gang <chengang@emindsoft.com.cn>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lv Li-song <lvlisong@emindsoft.com.cn>
References: <20191213051717.2058-1-chengang@emindsoft.com.cn>
 <20191213105033.GT32742@smile.fi.intel.com>
 <758a0ca9-8f81-1a10-d9e1-11f86fac3de1@emindsoft.com.cn>
 <20191216095120.GN32742@smile.fi.intel.com>
 <2c4cba36-5833-ca08-4153-2061edf33186@emindsoft.com.cn>
Message-ID: <1d0dae5a-cf47-1682-de62-468f60fc621a@emindsoft.com.cn>
Date:   Thu, 19 Dec 2019 17:35:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2c4cba36-5833-ca08-4153-2061edf33186@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After check the linux-next tree, the core content is already fixed by
the patch "4da22f1418cb serial: 8250_fintek: fix the mismatched IRQ
mode" (it was applied on 2016-05-27).

And it looks my original modification for 8250_pnp.c is unnecessary, I
guess originally I only wanted to make sure it should work well, but did
not cleanup the code.

So this patch is useless, sorry to bother you. And again, thank you for
reviewing the code.


