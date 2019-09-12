Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA67C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C6E2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 00:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfILAys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 20:54:48 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33453 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbfILAyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 20:54:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tc6G1lV_1568249681;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tc6G1lV_1568249681)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Sep 2019 08:54:42 +0800
Subject: Re: [PATCH] ocfs2: fix spelling mistake "ambigous" -> "ambiguous"
To:     Colin King <colin.king@canonical.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190911160728.24322-1-colin.king@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <831bdff4-064e-038b-f45d-c4d265cbff1e@linux.alibaba.com>
Date:   Thu, 12 Sep 2019 08:54:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190911160728.24322-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/9/12 00:07, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a mlog_bug_on_msg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 7ad9d6590818..7c9dfd50c1c1 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -534,7 +534,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
>  	 */
>  	mlog_bug_on_msg(!!(fe->i_flags & cpu_to_le32(OCFS2_SYSTEM_FL)) !=
>  			!!(args->fi_flags & OCFS2_FI_FLAG_SYSFILE),
> -			"Inode %llu: system file state is ambigous\n",
> +			"Inode %llu: system file state is ambiguous\n",
>  			(unsigned long long)args->fi_blkno);
>  
>  	if (S_ISCHR(le16_to_cpu(fe->i_mode)) ||
> 
