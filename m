Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255921872
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbfIAPan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:30:43 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:55078 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfIAPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:30:43 -0400
Received: from [192.168.1.41] ([90.126.97.183])
        by mwinf5d18 with ME
        id wFWd2000F3xPcdm03FWeCQ; Sun, 01 Sep 2019 17:30:40 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Sep 2019 17:30:40 +0200
X-ME-IP: 90.126.97.183
Subject: Re: [PATCH] autofs: remove redundant assignment to variable err
To:     Colin King <colin.king@canonical.com>, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190901152251.11374-1-colin.king@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <01ec26e2-6fd9-5ea0-4ef7-6a47e00bb2c5@wanadoo.fr>
Date:   Sun, 1 Sep 2019 17:30:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901152251.11374-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2019 à 17:22, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable err is being assigned a value that is never read and
> is being re-assigned a little later on. The assignment is redundant
> and hence can be removed.
>
> Addresses-Coverity: ("Ununsed value")

Ununsed?


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   fs/autofs/dev-ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index a3cdb0036c5d..65d84b4d4464 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -422,7 +422,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
>   	struct autofs_info *ino;
>   	struct path path;
>   	dev_t devid;
> -	int err = -ENOENT;
> +	int err;
>   
>   	/* param->path has been checked in validate_dev_ioctl() */
>   


