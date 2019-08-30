Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B458DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2892087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfH3GRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:17:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfH3GRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:17:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 17F0D92207381C1165EC;
        Fri, 30 Aug 2019 14:17:34 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 30 Aug
 2019 14:17:28 +0800
Subject: Re: [PATCH v3 5/7] erofs: kill erofs_{init,exit}_inode_cache
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Joe Perches" <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
References: <20190830032006.GA20217@architecture4>
 <20190830033643.51019-1-gaoxiang25@huawei.com>
 <20190830033643.51019-5-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1188f42d-af41-1104-a7a9-37c237463869@huawei.com>
Date:   Fri, 30 Aug 2019 14:17:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190830033643.51019-5-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/30 11:36, Gao Xiang wrote:
> As Christoph said [1] "having this function
> seems entirely pointless", I have to kill those.
> 
> filesystem                              function name
> ext2,f2fs,ext4,isofs,squashfs,cifs,...  init_inodecache
> 
> In addition, add a "rcu_barrier()" when exit_fs();
> 
> [1] https://lore.kernel.org/r/20190829101545.GC20598@infradead.org/
> Reported-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
