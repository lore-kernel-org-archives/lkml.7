Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E6C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAF3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfHUSnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:43:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42050 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726903AbfHUSnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:43:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5CF5123C61D29CF5A623;
        Thu, 22 Aug 2019 02:43:47 +0800 (CST)
Received: from [127.0.0.1] (10.184.12.158) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 02:43:40 +0800
Subject: Re: [PATCH v2 05/12] irqchip/gic: Prepare for more than 16 PPIs
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        John Garry <john.garry@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190806100121.240767-1-maz@kernel.org>
 <20190806100121.240767-6-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c1033d74-2f92-49c4-02df-54121f904384@huawei.com>
Date:   Thu, 22 Aug 2019 02:40:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190806100121.240767-6-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/6 18:01, Marc Zyngier wrote:
> GICv3.1 allows up to 80 PPIs (16 legaci PPIs and 64 Extended PPIs),
                                   ^^^^^^
legacy?


Zenghui

> meaning we can't just leave the old 16 hardcoded everywhere.
> 
> We also need to add the infrastructure to discover the number of PPIs
> on a per redistributor basis, although we still pretend there is only
> 16 of them for now.
> 
> No functional change.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

