Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF61FC04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C298205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEEBHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 21:07:37 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:45242 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbfEEBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 21:07:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TQtyQw-_1557018451;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TQtyQw-_1557018451)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 05 May 2019 09:07:31 +0800
Subject: Re: [PATCH v2] fs: ocfs: fix spelling mistake "hearbeating" ->
 "heartbeat"
To:     ChenGang <cg.chen@huawei.com>, mark@fasheh.com, jlbec@evilplan.org,
        jiangqi903@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <1556855636-121101-1-git-send-email-cg.chen@huawei.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <071ee914-17a8-5e3e-ab49-ac4bdad5eaed@linux.alibaba.com>
Date:   Sun, 5 May 2019 09:07:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556855636-121101-1-git-send-email-cg.chen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/5/3 11:53, ChenGang wrote:
> There are some spelling mistakes in ocfs, fix it.

s/ocfs/ocfs2

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> Signed-off-by: ChenGang <cg.chen@huawei.com>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 2 +-
>  fs/ocfs2/cluster/quorum.c    | 2 +-
>  fs/ocfs2/cluster/tcp.c       | 2 +-
>  fs/ocfs2/dlm/dlmmaster.c     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index f3c20b2..e4e7df1 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1198,7 +1198,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
>  	if (atomic_read(&reg->hr_steady_iterations) != 0) {
>  		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
>  			printk(KERN_NOTICE "o2hb: Unable to stabilize "
> -			       "heartbeart on region %s (%s)\n",
> +			       "heartbeat on region %s (%s)\n",
>  			       config_item_name(&reg->hr_item),
>  			       reg->hr_dev_name);
>  			atomic_set(&reg->hr_steady_iterations, 0);
> diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
> index af2e747..792132f 100644
> --- a/fs/ocfs2/cluster/quorum.c
> +++ b/fs/ocfs2/cluster/quorum.c
> @@ -89,7 +89,7 @@ static void o2quo_fence_self(void)
>  	};
>  }
>  
> -/* Indicate that a timeout occurred on a hearbeat region write. The
> +/* Indicate that a timeout occurred on a heartbeat region write. The
>   * other nodes in the cluster may consider us dead at that time so we
>   * want to "fence" ourselves so that we don't scribble on the disk
>   * after they think they've recovered us. This can't solve all
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index e9f236a..7a43c04 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1776,7 +1776,7 @@ static void 	(struct o2nm_node *node, int node_num,
>  		(msecs_to_jiffies(o2net_reconnect_delay()) + 1);
>  
>  	if (node_num != o2nm_this_node()) {
> -		/* believe it or not, accept and node hearbeating testing
> +		/* believe it or not, accept and node heartbeating testing
>  		 * can succeed for this node before we got here.. so
>  		 * only use set_nn_state to clear the persistent error
>  		 * if that hasn't already happened */
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 826f056..41b80d5 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2176,7 +2176,7 @@ static void dlm_assert_master_worker(struct dlm_work_item *item, void *data)
>   * think that $RECOVERY is currently mastered by a dead node.  If so,
>   * we wait a short time to allow that node to get notified by its own
>   * heartbeat stack, then check again.  All $RECOVERY lock resources
> - * mastered by dead nodes are purged when the hearbeat callback is
> + * mastered by dead nodes are purged when the heartbeat callback is
>   * fired, so we can know for sure that it is safe to continue once
>   * the node returns a live node or no node.  */
>  static int dlm_pre_master_reco_lockres(struct dlm_ctxt *dlm,
> 
