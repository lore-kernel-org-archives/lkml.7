Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD402C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A591C20869
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDUHSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 03:18:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfDUHSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 03:18:36 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE4376A0F92534780976;
        Sun, 21 Apr 2019 15:17:16 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Sun, 21 Apr 2019
 15:17:09 +0800
Subject: Re: [PATCH] net: vrf: Fix operation not supported when set vrf mac
To:     David Ahern <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
References: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
 <e758e1a7-c086-1200-d24b-349f79c2ccfe@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <0ec3b7b7-61f4-be9b-ab52-3f046d44c440@huawei.com>
Date:   Sun, 21 Apr 2019 15:17:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e758e1a7-c086-1200-d24b-349f79c2ccfe@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/20 22:42, David Ahern wrote:
> On 4/19/19 10:09 PM, linmiaohe wrote:
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Vrf device is not able to change mac address now because lack of
>> ndo_set_mac_address. Complete this in case some apps need to do
>> this.
>>
> 
> mac on a VRF device is irrelevant so what is the point of allowing apps
> to change it?
> 
> 
Sure, mac on a VRF device is irrelevant. There is no point of allowing
apps to change it, but someone around complains about it. So let's just
ignore the voice of the complaining.

