Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE2CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250FD2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="JsFt4YeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfJWJQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:16:57 -0400
Received: from smtp121.ord1d.emailsrvr.com ([184.106.54.121]:47860 "EHLO
        smtp121.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390604AbfJWJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1571821643;
        bh=evRO7seMrvDvO+KFOLaqik2PBghLNKezlXn4gdXjNCs=;
        h=Subject:To:From:Date:From;
        b=JsFt4YeAz1Pyo4qGFDuIL6sqJLAfaMxuUIa1O88PmBo0mCtlatJsF03eyzPE3WGcy
         ffvxsEOeMJ6MZtHkhOG8iJX8aYbbRG5axGvWnJOtquMh/Nn+8NElgnc2lKHsxVI41e
         S0V1FsabmGukHnB1G5bULgQ4slx1TWP9kI0ahY4g=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C1E39400A9;
        Wed, 23 Oct 2019 05:07:22 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 23 Oct 2019 05:07:23 -0400
Subject: Re: [PATCH -next] staging: comedi: remove unused variable
 'route_table_size'
To:     YueHaibing <yuehaibing@huawei.com>, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20191023075206.33088-1-yuehaibing@huawei.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <516d7146-fe16-6d8e-9812-038280c256df@mev.co.uk>
Date:   Wed, 23 Oct 2019 10:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023075206.33088-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2019 08:52, YueHaibing wrote:
> drivers/staging/comedi/drivers/ni_routes.c:52:21: warning:
>   route_table_size defined but not used [-Wunused-const-variable=]
> 
> It is never used since introduction.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/staging/comedi/drivers/ni_routes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers/ni_routes.c b/drivers/staging/comedi/drivers/ni_routes.c
> index eb61494..673d732 100644
> --- a/drivers/staging/comedi/drivers/ni_routes.c
> +++ b/drivers/staging/comedi/drivers/ni_routes.c
> @@ -49,8 +49,6 @@
>   /* Helper for accessing data. */
>   #define RVi(table, src, dest)	((table)[(dest) * NI_NUM_NAMES + (src)])
>   
> -static const size_t route_table_size = NI_NUM_NAMES * NI_NUM_NAMES;
> -
>   /*
>    * Find the proper route_values and ni_device_routes tables for this particular
>    * device.
> 

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
