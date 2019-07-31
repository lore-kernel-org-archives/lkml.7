Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948832064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGaLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:41:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfGaLlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:41:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 052F69A63D0C3EB13A6F;
        Wed, 31 Jul 2019 19:41:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 19:41:16 +0800
Subject: Re: [PATCH] HID: logitech-dj: Fix check of
 logi_dj_recv_query_paired_devices()
To:     Hans de Goede <hdegoede@redhat.com>, Petr Vorel <pvorel@suse.cz>
References: <20190725145719.8344-1-yuehaibing@huawei.com>
 <20190731105927.GA5092@dell5510> <20190731110629.GB5092@dell5510>
 <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
CC:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <917e5209-8e58-076d-bb25-0716d7414e5a@huawei.com>
Date:   Wed, 31 Jul 2019 19:41:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <3e9bda5b-68dc-15b9-ca79-2e73567ea0a5@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/31 19:29, Hans de Goede wrote:
> Hi Petr,
> 
> On 31-07-19 13:06, Petr Vorel wrote:
>> Hi,
>>
>>>> In delayedwork_callback(), logi_dj_recv_query_paired_devices
>>>> may return positive value while success now, so check it
>>>> correctly.
>>
>>>> Fixes: dbcbabf7da92 ("HID: logitech-dj: fix return value of logi_dj_recv_query_hidpp_devices")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> OK, not only it didn't fix problems with logitech mouse (see below),
>> but removing mouses USB dongle effectively crashes kernel, so this one probably
>> shouldn't be applied :).
>>
>> [  330.721629] logitech-djreceiver: probe of 0003:046D:C52F.0013 failed with error 7
>> [  331.462335] hid 0003:046D:C52F.0013: delayedwork_callback: logi_dj_recv_query_paired_devices error: 7
> 
> Please test my patch titled: "HID: logitech-dj: Really fix return value of logi_dj_recv_query_hidpp_devices"
> which should fix this.

Yes, this is better one, thanks!

> 
> Regards,
> 
> Hans
> 
> .
> 

