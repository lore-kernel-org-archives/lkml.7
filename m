Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B4C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9814121D81
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407000AbfIYNsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:48:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2485 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405963AbfIYNsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:48:24 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 953ADF9E6B6000EE6D6D;
        Wed, 25 Sep 2019 21:48:22 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 25 Sep 2019 21:48:22 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 25 Sep 2019 21:48:21 +0800
Date:   Wed, 25 Sep 2019 21:47:06 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix comment of f2fs_evict_inode
Message-ID: <20190925134706.GA157912@architecture4>
References: <20190925093050.118921-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190925093050.118921-1-yuchao0@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Wed, Sep 25, 2019 at 05:30:50PM +0800, Chao Yu wrote:
> evict() should be called once i_count is zero, rather than i_nlinke
> is zero.
> 
> Reported-by: Gao Xiang <gaoxiang25@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index db4fec30c30d..8262f4a483d3 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -632,7 +632,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>  }
>  
>  /*
> - * Called at the last iput() if i_nlink is zero
> + * Called at the last iput() if i_count is zero

Yeah, I'd suggest taking some time to look at other
inconsistent comments, it makes other folks confused
and ask me with such-"strong" reason...

Thanks,
Gao Xiang

>   */
>  void f2fs_evict_inode(struct inode *inode)
>  {
> -- 
> 2.18.0.rc1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
