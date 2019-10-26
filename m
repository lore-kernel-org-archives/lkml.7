Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712302084C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 20:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfJZUc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 16:32:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:47062 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726409AbfJZUc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 16:32:58 -0400
X-IronPort-AV: E=Sophos;i="5.68,233,1569276000"; 
   d="scan'208";a="408480597"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 22:32:55 +0200
Date:   Sat, 26 Oct 2019 22:32:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 1/3] staging: rtl8712: Fix Alignment
 of open parenthesis
In-Reply-To: <c9987f6ee311c7356a9f963439d37e4a9696f8eb.1572121059.git.cristianenavescardoso09@gmail.com>
Message-ID: <alpine.DEB.2.21.1910262231270.5545@hadrien>
References: <cover.1572121059.git.cristianenavescardoso09@gmail.com> <c9987f6ee311c7356a9f963439d37e4a9696f8eb.1572121059.git.cristianenavescardoso09@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Oct 2019, Cristiane Naves wrote:

> Fix alignment should match open parenthesis. Issue found by checkpatch.
>
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index af12c16..12a3c64 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
>  		precvbuf->ref_cnt = 0;
>  		precvbuf->adapter = padapter;
>  		list_add_tail(&precvbuf->list,
> -				 &(precvpriv->free_recv_buf_queue.queue));
> +			      &(precvpriv->free_recv_buf_queue.queue));
>  		precvbuf++;
>  	}
>  	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
>  	tasklet_init(&precvpriv->recv_tasklet,
> -	     (void(*)(unsigned long))recv_tasklet,
> -	     (unsigned long)padapter);
> +		     (void(*)(unsigned long))recv_tasklet,
> +		     (unsigned long)padapter);
>  	skb_queue_head_init(&precvpriv->rx_skb_queue);
>
>  	skb_queue_head_init(&precvpriv->free_recv_skb_queue);
> @@ -140,7 +140,7 @@ void r8712_free_recvframe(union recv_frame *precvframe,
>  }
>
>  static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *pattrib,
> -					   struct recv_stat *prxstat)
> +						  struct recv_stat *prxstat)
>  {
>  	u16 drvinfo_sz;
>
> @@ -177,7 +177,7 @@ static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *pattrib,
>
>  /*perform defrag*/
>  static union recv_frame *recvframe_defrag(struct _adapter *adapter,
> -				   struct  __queue *defrag_q)
> +					  struct  __queue *defrag_q)
>  {
>  	struct list_head *plist, *phead;
>  	u8 wlanhdr_offset;
> @@ -379,7 +379,7 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
>  		/* convert hdr + possible LLC headers into Ethernet header */
>  		eth_type = (sub_skb->data[6] << 8) | sub_skb->data[7];
>  		if (sub_skb->len >= 8 &&
> -		   ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
> +		    ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
>  		   eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
>  		   !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {

I have the impression that the alignment is not really optimal for reading
here.  It is hard to see what is the argument of which operator. It looks
like at least there are some parentheses that eth_type should be aligned
with the right side of as well.

julia

>  			/* remove RFC1042 or Bridge-Tunnel encapsulation and
> @@ -387,18 +387,18 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
>  			 */
>  			skb_pull(sub_skb, SNAP_SIZE);
>  			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
> -				ETH_ALEN);
> +			       ETH_ALEN);
>  			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
> -				ETH_ALEN);
> +			       ETH_ALEN);
>  		} else {
>  			__be16 len;
>  			/* Leave Ethernet header part of hdr and full payload */
>  			len = htons(sub_skb->len);
>  			memcpy(skb_push(sub_skb, 2), &len, 2);
>  			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
> -				ETH_ALEN);
> +			       ETH_ALEN);
>  			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
> -				ETH_ALEN);
> +			       ETH_ALEN);
>  		}
>  		/* Indicate the packets to upper layer */
>  		if (sub_skb) {
> @@ -472,7 +472,7 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl,
>  }
>
>  static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
> -			      union recv_frame *prframe)
> +				     union recv_frame *prframe)
>  {
>  	struct list_head *phead, *plist;
>  	union recv_frame *pnextrframe;
> @@ -499,8 +499,8 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
>  }
>
>  int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
> -			       struct recv_reorder_ctrl *preorder_ctrl,
> -			       int bforced)
> +				     struct recv_reorder_ctrl *preorder_ctrl,
> +				     int bforced)
>  {
>  	struct list_head *phead, *plist;
>  	union recv_frame *prframe;
> @@ -555,7 +555,7 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
>  }
>
>  static int recv_indicatepkt_reorder(struct _adapter *padapter,
> -			     union recv_frame *prframe)
> +				    union recv_frame *prframe)
>  {
>  	unsigned long irql;
>  	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
> @@ -624,7 +624,7 @@ void r8712_reordering_ctrl_timeout_handler(void *pcontext)
>  }
>
>  static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
> -			      union recv_frame *prframe)
> +					   union recv_frame *prframe)
>  {
>  	int retval = _SUCCESS;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/c9987f6ee311c7356a9f963439d37e4a9696f8eb.1572121059.git.cristianenavescardoso09%40gmail.com.
>
