Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EADBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D099216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfK2Ltl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:49:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:47884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2Ltl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:49:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0A5FB35C;
        Fri, 29 Nov 2019 11:49:38 +0000 (UTC)
Date:   Fri, 29 Nov 2019 12:49:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, tj@kernel.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] staging: isdn: gigaset: Use pr_warn instead of
 pr_warning
Message-ID: <20191129114936.x53gaief2vz3o7vn@pathway.suse.cz>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
 <20191128004752.35268-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128004752.35268-3-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-11-28 08:47:50, Kefeng Wang wrote:
> Use pr_warn() instead of the remaining pr_warning() calls.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/staging/isdn/gigaset/interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/isdn/gigaset/interface.c b/drivers/staging/isdn/gigaset/interface.c
> index 17fa615a8c68..9ddadd07e707 100644
> --- a/drivers/staging/isdn/gigaset/interface.c
> +++ b/drivers/staging/isdn/gigaset/interface.c
> @@ -518,7 +518,7 @@ void gigaset_if_init(struct cardstate *cs)
>  	if (!IS_ERR(cs->tty_dev))
>  		dev_set_drvdata(cs->tty_dev, cs);
>  	else {
> -		pr_warning("could not register device to the tty subsystem\n");
> +		pr_warn("could not register device to the tty subsystem\n");

This patch has reached mainline via the staging tree in the meantime.

Best Regards,
Petr

