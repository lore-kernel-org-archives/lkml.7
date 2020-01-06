Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BBC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E963E208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 12:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFMsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:48:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbgAFMsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:48:47 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30EEE82E7F0F2DF9B2FF;
        Mon,  6 Jan 2020 20:48:44 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 Jan 2020
 20:48:34 +0800
Subject: Re: [PATCH] net: 3com: 3c59x: remove set but not used variable
 'mii_reg1'
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Vladimir Oltean <olteanv@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, <klassert@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        <hslester96@gmail.com>, <mst@redhat.com>, <yang.wei9@zte.com.cn>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhengbin13@huawei.com>
References: <20200103121907.5769-1-yukuai3@huawei.com>
 <20200103144623.GI6788@bombadil.infradead.org>
 <20200103175318.GN1397@lunn.ch>
 <CA+h21hqcz=QF8bq285JjdOn+gsOGvGSnDiWzDOS5-XGAGGGr9w@mail.gmail.com>
 <b4697457-51d2-c987-4138-b4b2b92e391d@gmail.com>
 <20200103193758.GO1397@lunn.ch>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <983f869c-5638-8f77-d404-e1164e34f73f@huawei.com>
Date:   Mon, 6 Jan 2020 20:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200103193758.GO1397@lunn.ch>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/4 3:37, Andrew Lunn wrote:
>> And since more reviewers are on the same boat, the fix should probably
>> look to eliminate the warning by doing something like:
>>
>> (void)mdio_read(dev, vp->phys[0], MII_BMSR);
> 
> Yes, this is the safe option.
> 
>       Andrew
> 
> .
Thank you all for your response!

Yu Kuai


