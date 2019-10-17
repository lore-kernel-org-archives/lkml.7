Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6AFFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D2220659
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405873AbfJQLlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbfJQLlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:41:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08E917FD45;
        Thu, 17 Oct 2019 11:41:40 +0000 (UTC)
Received: from [10.33.36.109] (unknown [10.33.36.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F875C1D8;
        Thu, 17 Oct 2019 11:41:35 +0000 (UTC)
Subject: Re: [Cluster-devel] [PATCH] gfs2: make gfs2_fs_parameters static
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
References: <20191017110225.30841-1-ben.dooks@codethink.co.uk>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <25bb4857-950e-592a-b2ba-7730867742b3@redhat.com>
Date:   Thu, 17 Oct 2019 12:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017110225.30841-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 17 Oct 2019 11:41:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2019 12:02, Ben Dooks (Codethink) wrote:
> The gfs2_fs_parameters is not used outside the unit
> it is declared in, so make it static.
> 
> Fixes the following sparse warning:
> 
> fs/gfs2/ops_fstype.c:1331:39: warning: symbol 'gfs2_fs_parameters' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: cluster-devel@redhat.com
> Cc: linux-kernel@vger.kernel.org
> ---
>   fs/gfs2/ops_fstype.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 681b44682b0d..ebdef1c5f580 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -1328,7 +1328,7 @@ static const struct fs_parameter_enum gfs2_param_enums[] = {
>   	{}
>   };
>   
> -const struct fs_parameter_description gfs2_fs_parameters = {
> +static const struct fs_parameter_description gfs2_fs_parameters = {
>   	.name = "gfs2",
>   	.specs = gfs2_param_specs,
>   	.enums = gfs2_param_enums,
> 

Looks good to me.

Thanks,
Andy
