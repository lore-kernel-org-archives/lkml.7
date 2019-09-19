Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52895C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291FB218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbfISAyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:54:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730468AbfISAyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:54:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A79855AE3D9879AC3D2;
        Thu, 19 Sep 2019 08:54:42 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 19 Sep
 2019 08:54:36 +0800
Subject: Re: [PATCH -next] erofs: fix return value check in
 erofs_read_superblock()
To:     Wei Yongjun <weiyongjun1@huawei.com>, Gao Xiang <xiang@kernel.org>,
        "Chao Yu" <chao@kernel.org>, Gao Xiang <gaoxiang25@huawei.com>
CC:     <linux-erofs@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190918083033.47780-1-weiyongjun1@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <9c607274-7897-14c6-5211-a992ea25a992@huawei.com>
Date:   Thu, 19 Sep 2019 08:54:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190918083033.47780-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/18 16:30, Wei Yongjun wrote:
> In case of error, the function read_mapping_page() returns
> ERR_PTR() not NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Fixes: fe7c2423570d ("erofs: use read_mapping_page instead of sb_bread")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
