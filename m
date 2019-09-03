Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1225AC3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82A52168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfICHrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbfICHrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:47:39 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 344A3C075BD2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 07:47:38 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f18so9197166wro.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnmnWhc2qfmsJ3pZ+ytXKy1jqPtAf/8RAcu/rZxBpOA=;
        b=qqHzp5OdWxC9khc/abd6s+QtHpnhW3MM679/zvPB5j/oWYAwi85QPlWa98UEAr8x61
         EibxWVKkPAYgYre+dpu26rTKUFzA8Rd2yGAsUT8rVQQ5IZlKRxOsDWexkJdCEdynAtXI
         a6rXeAnt1GaLMP+1m+TdUwSyYtWrB5DjlM3R3WGfs+cX7tLN8sLJ62Q6bzu2liOlLUdC
         KJDAsv2g+hoBWl+y11MzGoh73bevjTdGccHD4yNQx0b3kwicxwMeLtLhkK/dC3ay+PTY
         jpvm5WDmCOaJXQ9SZtBx8Soq+vcXhmcUv1ZY/YI/I9Q62SIBnY1b/Ws2VtTe8d1Io/hn
         rkWA==
X-Gm-Message-State: APjAAAVM9BMwya+OeRXV5KU+ZvTniBYfAgmV37MHcCCestXVkzRdLAyK
        oNmE+pAfSXmL95hfQstLV+y7AgVV0rnTHIIv5oPh0UoV6UpN4+pGdqRMDfszvwQitR4LUtlWwiN
        TZFTfa8pdnhOdeP7zhg+FYNTA
X-Received: by 2002:adf:8444:: with SMTP id 62mr40065114wrf.202.1567496856833;
        Tue, 03 Sep 2019 00:47:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtF6KOYuQGW6Yd+ADmoPQoTuiB5O/upqyGyY9YWt/HZCmo1caE/75ccLGalCenEsB8+yq/Dg==
X-Received: by 2002:adf:8444:: with SMTP id 62mr40065094wrf.202.1567496856630;
        Tue, 03 Sep 2019 00:47:36 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it. [79.36.61.170])
        by smtp.gmail.com with ESMTPSA id x15sm11040612wmc.16.2019.09.03.00.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:47:36 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:47:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: a better comment on credit update
Message-ID: <20190903074733.dg55ucs7jh5zvfbh@steredhat>
References: <20190903073748.25214-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903073748.25214-1-mst@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:38:16AM -0400, Michael S. Tsirkin wrote:
> The comment we have is just repeating what the code does.
> Include the *reason* for the condition instead.
> 
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 94cc0fa3e848..5bb70c692b1e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -307,8 +307,13 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>  
>  	spin_unlock_bh(&vvs->rx_lock);
>  
> -	/* We send a credit update only when the space available seen
> -	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
> +	/* To reduce the number of credit update messages,
> +	 * don't update credits as long as lots of space is available.
> +	 * Note: the limit chosen here is arbitrary. Setting the limit
> +	 * too high causes extra messages. Too low causes transmitter
> +	 * stalls. As stalls are in theory more expensive than extra
> +	 * messages, we set the limit to a high value. TODO: experiment
> +	 * with different values.
>  	 */
>  	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
>  		virtio_transport_send_credit_update(vsk,

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


