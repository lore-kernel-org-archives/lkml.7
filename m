Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F312C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64446206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfHMXfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:35:01 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:45164 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMXfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:35:00 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Aug 2019 19:35:00 EDT
Received: from localhost.localdomain (unknown [5.148.42.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 77AC9CB70F;
        Wed, 14 Aug 2019 01:28:03 +0200 (CEST)
Subject: Re: [PATCH] net: ieee802154: remove redundant assignment to rc
To:     Colin King <colin.king@canonical.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190813142818.15022-1-colin.king@canonical.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <a3262e25-209d-209d-59fc-a09511fb9280@datenfreihafen.org>
Date:   Wed, 14 Aug 2019 01:28:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190813142818.15022-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 13.08.19 16:28, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable rc is initialized to a value that is never read and it is
> re-assigned later. The initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/ieee802154/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index dacbd58e1799..badc5cfe4dc6 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -1092,7 +1092,7 @@ static struct packet_type ieee802154_packet_type = {
>  
>  static int __init af_ieee802154_init(void)
>  {
> -	int rc = -EINVAL;
> +	int rc;
>  
>  	rc = proto_register(&ieee802154_raw_prot, 1);
>  	if (rc)
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
