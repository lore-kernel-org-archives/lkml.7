Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE42C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685302084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387648AbfDYUT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:19:58 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30581 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbfDYUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:19:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,394,1549926000"; 
   d="scan'208";a="380285542"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 22:19:55 +0200
Date:   Thu, 25 Apr 2019 22:19:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Vatsala Narang <vatsalanarang@gmail.com>
cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: Remove return in void
 function
In-Reply-To: <20190425195145.25326-1-vatsalanarang@gmail.com>
Message-ID: <alpine.DEB.2.21.1904252219360.2590@hadrien>
References: <20190425195145.25326-1-vatsalanarang@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Apr 2019, Vatsala Narang wrote:

> Remove return in void function to get rid of checkpatch warning.
>
> Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/staging/rtl8723bs/core/rtw_xmit.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> index 094d61bcb469..67b9aeda7f3a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
> @@ -2861,8 +2861,6 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
>
>  	/* spin_unlock_bh(&psta->sleep_q.lock); */
>  	spin_unlock_bh(&pxmitpriv->lock);
> -
> -	return;
>  }
>
>  void enqueue_pending_xmitbuf(
> --
> 2.17.1
>
>
