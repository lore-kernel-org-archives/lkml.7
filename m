Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A5C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7054620883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nTYZr1Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfDTQW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:22:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDTQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2otoseUa1j4IuHgJJVx4jfhfUlvZlbAJeQAUQ+fLZew=; b=nTYZr1GrNyVAr+K9S2/C08K03G
        QWxwyW6fGQeBpun4KX3xKY3UI0mluvei+ckwPtlVzrUIivIxDPyYOMNxfNyJWiNlzZQsHAd2NAZYR
        8l858clnoNjmqtG2wGZvKPVeOB88UkwP0LhygM/Rl5E1Sdo0FmUsLL+qe1rfb+jyFhcK7c7jiIz4o
        xfEObilFyRWvYgMsdhoYxutHJrC1qgcMRZZkv+Ss4FykfcNX4JgeAFAtNdoBbkliOiy3Fq9W97EWi
        rOaWTLGkaTdCcStISgFQyQWi+U8ng7oTiFdFRNCTpac8KxgtIbNLbRSYdDnCS5tOsF/xvHCuqSYNh
        wjVHze5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHsl0-0000Vf-L3; Sat, 20 Apr 2019 16:22:26 +0000
Subject: Re: [PATCH] Fix some misuses of %x
To:     Fuqian Huang <huangfq.daxian@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190419132158.32420-1-huangfq.daxian@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Message-ID: <6dbabc14-188e-286f-1926-911b500ce0df@infradead.org>
Date:   Sat, 20 Apr 2019 09:22:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190419132158.32420-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/19 6:21 AM, Fuqian Huang wrote:
> The pointers should be printed with %p or %px rather than
> cast to long or unsigned long type and printed with %x.
> Change %x to %p to print pointers.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Hi,

You will need to send this patch (or patch set/patch series) to the
appropriate subsystem maintainers and their respective mailing lists.
Maintainers don't browse the linux-kernel mailing list to search or
pick up patches.

From Documentation/process/submitting-patches.rst:

5) Select the recipients for your patch
---------------------------------------

You should always copy the appropriate subsystem maintainer(s) on any patch
to code that they maintain; look through the MAINTAINERS file and the
source code revision history to see who those maintainers are.  The
script scripts/get_maintainer.pl can be very useful at this step.  If you
cannot find a maintainer for the subsystem you are working on, Andrew
Morton (akpm@linux-foundation.org) serves as a maintainer of last resort.

You should also normally choose at least one mailing list to receive a copy
of your patch set.  linux-kernel@vger.kernel.org functions as a list of
last resort, but the volume on that list has caused a number of developers
to tune it out.  Look in the MAINTAINERS file for a subsystem-specific
list; your patch will probably get more attention there.  Please do not
spam unrelated lists, though.

Many kernel-related lists are hosted on vger.kernel.org; you can find a
list of them at http://vger.kernel.org/vger-lists.html.  There are
kernel-related lists hosted elsewhere as well, though.


Thanks.

> ---
>  drivers/atm/iphase.c               | 4 ++--
>  drivers/misc/genwqe/card_debugfs.c | 4 ++--
>  drivers/net/hippi/rrunner.c        | 4 ++--
>  kernel/cgroup/debug.c              | 8 ++++----
>  net/ax25/af_ax25.c                 | 4 ++--
>  sound/isa/gus/gus_mem.c            | 2 +-
>  6 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
> index 82532c299bb5..5278c57dce73 100644
> --- a/drivers/atm/iphase.c
> +++ b/drivers/atm/iphase.c
> @@ -2826,8 +2826,8 @@ static int ia_ioctl(struct atm_dev *dev, unsigned int cmd, void __user *arg)
>           case 0x6:
>           {  
>               ia_cmds.status = 0; 
> -             printk("skb = 0x%lx\n", (long)skb_peek(&iadev->tx_backlog));
> -             printk("rtn_q: 0x%lx\n",(long)ia_deque_rtn_q(&iadev->tx_return_q));
> +             printk("skb = 0x%p\n", skb_peek(&iadev->tx_backlog));
> +             printk("rtn_q: 0x%p\n",ia_deque_rtn_q(&iadev->tx_return_q));
>           }
>               break;
>           case 0x8:
> diff --git a/drivers/misc/genwqe/card_debugfs.c b/drivers/misc/genwqe/card_debugfs.c
> index 7c713e01d198..6f7e39f07811 100644
> --- a/drivers/misc/genwqe/card_debugfs.c
> +++ b/drivers/misc/genwqe/card_debugfs.c
> @@ -227,7 +227,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
>  	seq_puts(s, "DDCB QUEUE:\n");
>  	seq_printf(s, "  ddcb_max:            %d\n"
>  		   "  ddcb_daddr:          %016llx - %016llx\n"
> -		   "  ddcb_vaddr:          %016llx\n"
> +		   "  ddcb_vaddr:          %p\n"
>  		   "  ddcbs_in_flight:     %u\n"
>  		   "  ddcbs_max_in_flight: %u\n"
>  		   "  ddcbs_completed:     %u\n"
> @@ -237,7 +237,7 @@ static int ddcb_info_show(struct seq_file *s, void *unused)
>  		   queue->ddcb_max, (long long)queue->ddcb_daddr,
>  		   (long long)queue->ddcb_daddr +
>  		   (queue->ddcb_max * DDCB_LENGTH),
> -		   (long long)queue->ddcb_vaddr, queue->ddcbs_in_flight,
> +		   queue->ddcb_vaddr, queue->ddcbs_in_flight,
>  		   queue->ddcbs_max_in_flight, queue->ddcbs_completed,
>  		   queue->return_on_busy, queue->wait_on_busy,
>  		   cd->irqs_processed);
> diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
> index 029206e4da3b..0f7025f3a384 100644
> --- a/drivers/net/hippi/rrunner.c
> +++ b/drivers/net/hippi/rrunner.c
> @@ -1298,11 +1298,11 @@ static void rr_dump(struct net_device *dev)
>  	if (rrpriv->tx_skbuff[cons]){
>  		len = min_t(int, 0x80, rrpriv->tx_skbuff[cons]->len);
>  		printk("skbuff for cons %i is valid - dumping data (0x%x bytes - skbuff len 0x%x)\n", cons, len, rrpriv->tx_skbuff[cons]->len);
> -		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %08lx, truesize 0x%x\n",
> +		printk("mode 0x%x, size 0x%x,\n phys %08Lx, skbuff-addr %p, truesize 0x%x\n",
>  		       rrpriv->tx_ring[cons].mode,
>  		       rrpriv->tx_ring[cons].size,
>  		       (unsigned long long) rrpriv->tx_ring[cons].addr.addrlo,
> -		       (unsigned long)rrpriv->tx_skbuff[cons]->data,
> +		       rrpriv->tx_skbuff[cons]->data,
>  		       (unsigned int)rrpriv->tx_skbuff[cons]->truesize);
>  		for (i = 0; i < len; i++){
>  			if (!(i & 7))
> diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
> index 5f1b87330bee..80aa3f027ac3 100644
> --- a/kernel/cgroup/debug.c
> +++ b/kernel/cgroup/debug.c
> @@ -64,8 +64,8 @@ static int current_css_set_read(struct seq_file *seq, void *v)
>  		css = cset->subsys[ss->id];
>  		if (!css)
>  			continue;
> -		seq_printf(seq, "%2d: %-4s\t- %lx[%d]\n", ss->id, ss->name,
> -			  (unsigned long)css, css->id);
> +		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
> +			  css, css->id);
>  	}
>  	rcu_read_unlock();
>  	spin_unlock_irq(&css_set_lock);
> @@ -224,8 +224,8 @@ static int cgroup_subsys_states_read(struct seq_file *seq, void *v)
>  		if (css->parent)
>  			snprintf(pbuf, sizeof(pbuf) - 1, " P=%d",
>  				 css->parent->id);
> -		seq_printf(seq, "%2d: %-4s\t- %lx[%d] %d%s\n", ss->id, ss->name,
> -			  (unsigned long)css, css->id,
> +		seq_printf(seq, "%2d: %-4s\t- %p[%d] %d%s\n", ss->id, ss->name,
> +			  css, css->id,
>  			  atomic_read(&css->online_cnt), pbuf);
>  	}
>  
> diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
> index 5d01edf8d819..90c2831297dd 100644
> --- a/net/ax25/af_ax25.c
> +++ b/net/ax25/af_ax25.c
> @@ -1888,8 +1888,8 @@ static int ax25_info_show(struct seq_file *seq, void *v)
>  	 * magic dev src_addr dest_addr,digi1,digi2,.. st vs vr va t1 t1 t2 t2 t3 t3 idle idle n2 n2 rtt window paclen Snd-Q Rcv-Q inode
>  	 */
>  
> -	seq_printf(seq, "%8.8lx %s %s%s ",
> -		   (long) ax25,
> +	seq_printf(seq, "%p %s %s%s ",
> +		   ax25,
>  		   ax25->ax25_dev == NULL? "???" : ax25->ax25_dev->dev->name,
>  		   ax2asc(buf, &ax25->source_addr),
>  		   ax25->iamdigi? "*":"");
> diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
> index 4ac76f46dd76..63e790fbf066 100644
> --- a/sound/isa/gus/gus_mem.c
> +++ b/sound/isa/gus/gus_mem.c
> @@ -306,7 +306,7 @@ static void snd_gf1_mem_info_read(struct snd_info_entry *entry,
>  	used = 0;
>  	for (block = alloc->first, i = 0; block; block = block->next, i++) {
>  		used += block->size;
> -		snd_iprintf(buffer, "Block %i at 0x%lx onboard 0x%x size %i (0x%x):\n", i, (long) block, block->ptr, block->size, block->size);
> +		snd_iprintf(buffer, "Block %i at 0x%p onboard 0x%x size %i (0x%x):\n", i, block, block->ptr, block->size, block->size);
>  		if (block->share ||
>  		    block->share_id[0] || block->share_id[1] ||
>  		    block->share_id[2] || block->share_id[3])
> 


-- 
~Randy
