Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F30C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9476421655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLLJfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:35:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7677 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728349AbfLLJfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:35:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D1E4A3178B2DD147BB01;
        Thu, 12 Dec 2019 17:35:35 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 12 Dec 2019
 17:35:32 +0800
Message-ID: <5DF209E3.2080808@huawei.com>
Date:   Thu, 12 Dec 2019 17:35:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux@roeck-us.net>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: fusb302: Fix an undefined reference to 'extcon_get_state'
References: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com> <20191212090132.GC31345@kuha.fi.intel.com> <5DF20530.2040509@huawei.com> <20191212092805.GA1375559@kroah.com>
In-Reply-To: <20191212092805.GA1375559@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/12 17:28, Greg KH wrote:
> On Thu, Dec 12, 2019 at 05:15:28PM +0800, zhong jiang wrote:
>> On 2019/12/12 17:01, Heikki Krogerus wrote:
>>> On Thu, Dec 12, 2019 at 03:34:23PM +0800, zhong jiang wrote:
>>>> Fixes the following compile error:
>>>>
>>>> drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
>>>> fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
>>>> fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
>>>> fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
>>>> fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
>>>> drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
>>>> fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
>>>> make: *** [vmlinux] Error 1
>>> There are stubs for those functions so that really should not be
>>> happening. I can not reproduce that.
>> It can be reproduced in next branch. you can try it in the latest next branch.
> Can it be reproduced in 5.5-rc1?
Yes
> .
>


