Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DBDC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A75208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHKSKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfHKSKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:10:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1856C015C30;
        Sun, 11 Aug 2019 18:10:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4894928D1C;
        Sun, 11 Aug 2019 18:10:26 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x7BIAPHN014772;
        Sun, 11 Aug 2019 14:10:25 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x7BIAOrP014768;
        Sun, 11 Aug 2019 14:10:25 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 11 Aug 2019 14:10:24 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     snitzer@redhat.com, agk@redhat.com, prarit@redhat.com,
        tyu1@lenovo.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: dm writecache: remove unused member pointer in
 writeback_struct
In-Reply-To: <20190811161233.7616-1-yehs2007@zoho.com>
Message-ID: <alpine.LRH.2.02.1908111410040.13454@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190811161233.7616-1-yehs2007@zoho.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 11 Aug 2019 18:10:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Aug 2019, Huaisheng Ye wrote:

> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> The stucture member pointer page in writeback_struct never has been
> used actually. Remove it.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  drivers/md/dm-writecache.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 1cb137f..5c7009d 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -190,7 +190,6 @@ struct writeback_struct {
>  	struct dm_writecache *wc;
>  	struct wc_entry **wc_list;
>  	unsigned wc_list_n;
> -	struct page *page;
>  	struct wc_entry *wc_list_inline[WB_LIST_INLINE];
>  	struct bio bio;
>  };
> -- 
> 1.8.3.1
> 
> 
