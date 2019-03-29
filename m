Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD43C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C7621773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfC2G2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:28:36 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2468 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbfC2G2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:28:36 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 8AAFB4DE2BE7F08AE776;
        Fri, 29 Mar 2019 14:28:33 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 29 Mar 2019 14:28:33 +0800
Received: from [10.134.22.195] (10.134.22.195) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 29 Mar 2019 14:28:32 +0800
Subject: Re: [PATCH] staging: erofs: keep corrupted fs from crashing kernel in
 erofs_readdir()
To:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        <weidu.du@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        "# 4 . 19+" <stable@vger.kernel.org>
References: <20190328201458.30629-1-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3f371610-71bb-03c1-ac7d-37832e475e94@huawei.com>
Date:   Fri, 29 Mar 2019 14:28:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190328201458.30629-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/29 4:14, Gao Xiang wrote:
> From: Gao Xiang <gaoxiang25@huawei.com>
> 
> After commit 419d6efc50e9, kernel cannot be crashed in the namei
> path. However, corrupted nameoff can do harm in the process of
> readdir for scenerios without dm-verity as well. Fix it now.
> 
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
