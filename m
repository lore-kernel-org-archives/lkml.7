Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDDDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5470F21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570444059;
	bh=o/3HX+sqnNh7vr3SYYCutqGAasG1AMtER1h8gM4+CBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ulq34X7fJTWWQYLLpPTSsMoh1cn3rI1r8+3BfOaZ1YFv1/vlop/cd6z5IYjdxkN8g
	 g+YX/cEl4nfQyr8UcJU4OOGkOL+4xhOIKsAXliOrSgYgUIZMChcfyI71ZwPnf9xIoy
	 1zaJMsx+OZHa9TdflBhHmYkhBr6XnMyIc5PY2nhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJGK1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGK1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:27:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026F7206BB;
        Mon,  7 Oct 2019 10:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570444057;
        bh=o/3HX+sqnNh7vr3SYYCutqGAasG1AMtER1h8gM4+CBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVyox7Ty4EgYsSneZb3KoxWcLIsY8yooYV1lyMOfV5nrrDlBzcueVtqupZbxCNCoB
         iisw6VDNuCnOHbvJg6o76eKW+Q9obYfeXL7yMqsyt0RFDHSewKV8iK+mhdQ+Zy5fOl
         LtLtslBBAFup2HpSDXzURN8U6U4Zc7S962nKSHMc=
Date:   Mon, 7 Oct 2019 12:27:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Subject: Re: [PATCH] staging: rtl8712: align block comments
Message-ID: <20191007102735.GA345628@kroah.com>
References: <20191006203420.11202-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006203420.11202-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 05:34:20PM -0300, Gabriela Bittencourt wrote:
> Cleans up warnings of "Block comments should align the * on each line"
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/rtl8712/recv_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
> index 84c4c8580f9a..70a4dcd4a1e5 100644
> --- a/drivers/staging/rtl8712/recv_linux.c
> +++ b/drivers/staging/rtl8712/recv_linux.c
> @@ -115,8 +115,8 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
>  	skb->protocol = eth_type_trans(skb, adapter->pnetdev);
>  	netif_rx(skb);
>  	recvframe->u.hdr.pkt = NULL; /* pointers to NULL before
> -					* r8712_free_recvframe()
> -					*/
> +				      * r8712_free_recvframe()
> +				      */
>  	r8712_free_recvframe(recvframe, free_recv_queue);
>  	return;
>  _recv_indicatepkt_drop:

This patch did not apply to my tree at all.  Be sure you are working
against the staging-next branch of the staging.git tree, or off of
linux-next which includes this branch as well.

thanks,

greg k-h
