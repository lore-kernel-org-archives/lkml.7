Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD4220879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfCYDnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:43:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:48578 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729361AbfCYDni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:43:38 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B0A4D7F7BD6BF582DA58;
        Mon, 25 Mar 2019 11:43:36 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 25 Mar 2019 11:43:36 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 25 Mar 2019 11:43:35 +0800
Subject: Re: [PATCH v2 3/3] staging: erofs: support IO read error injection
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190325034009.38611-1-gaoxiang25@huawei.com>
 <20190325034009.38611-3-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2719c5f6-b6db-65bf-6c7e-3fa25dbcbf6f@huawei.com>
Date:   Mon, 25 Mar 2019 11:43:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190325034009.38611-3-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/25 11:40, Gao Xiang wrote:
> Used to simulate disk IO read error for testing fatal
> error tolerance.
> 
> Here are the details,
> 1) use bio->bi_private to indicate super_block
>    for non-compressed bios since some (mainly meta)
>    pages can be of the corresponding bdev inode;
> 2) get super_block dynamically for compressed bios,
>    therefore it could not inject bios full of staging
>    pages, yet it doesn't affect the normal usage.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
