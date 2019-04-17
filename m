Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468E3C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19818206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfDQGwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:52:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfDQGwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:52:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A0174D091742475B77FC;
        Wed, 17 Apr 2019 14:52:51 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 14:52:41 +0800
Subject: Re: some trouble when using vrf
To:     David Ahern <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mingfangsen <mingfangsen@huawei.com>
References: <15adf635-a74b-e9e3-5dad-b35890f0a746@huawei.com>
 <e4aa6621-8d9b-8d69-0562-610bae347ad3@cumulusnetworks.com>
 <f106ad99-c0a3-346c-f01f-d6e48ab4b628@huawei.com>
 <f3e65ab8-0677-b2c7-2163-59b6f845a96b@cumulusnetworks.com>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <224d8389-bbca-2240-fe52-dd8030420acd@huawei.com>
Date:   Wed, 17 Apr 2019 14:52:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f3e65ab8-0677-b2c7-2163-59b6f845a96b@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/17 12:56, David Ahern wrote:
> On 4/16/19 8:22 PM, linmiaohe wrote:
>>
>>
>> On 2019/4/16 23:20, David Ahern wrote:
>>> On 4/16/19 5:26 AM, linmiaohe wrote:
>>>>     ...
>>>>     bind(sock_fd, (struct sockaddr *)&addr_serv, sizeof(addr_serv));
>>>>     ...
>>>>     ret = setsockopt(sock_fd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, strlen(bind_dev)+1);
>>>>     ...
>>>>     This code snipet doesn't work if the ip address of addr_serv is not in default vrf. And
>>>> "Cannot assign requested address" will occurs.
>>>
>>> Applications must bind to the device first and then bind to the local
>>> address. As I recall this applies regardless of whether it is a VRF or
>>> other.
>>>
>>>
>> It should be, but unfortunately some applications break this.
>>
> 
> Sure, I have an open item on my to-do list about re-verifying bound
> addresses when the device binding changes (and vice versa). This is not
> a problem VRF introduced, but VRF use case does bring more attention to it.
> 
> 

Cherrs! I can't wait to enjoy the source code of the item. Please let
me know if you work out it. Thanks a lot.

