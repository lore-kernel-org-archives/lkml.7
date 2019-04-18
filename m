Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379A22083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aqOOVk/u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aqOOVk/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfDRKkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:40:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbfDRKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:40:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEFD96074F; Thu, 18 Apr 2019 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584020;
        bh=lidZ7OKPmqM5NevlNHhoh0GT6XnvCpxGyssmWrRe86s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aqOOVk/uFcwLtDna6zlyVmPBGmmvCTqV4kD2IZ2mZqepEkYwWKFveZzvWOpY4K26C
         LWyLRsuYlvN0M/XMVpQiABqfchSJFakb086qgrg31kZsnRcV1OcRVc2jF4UWN6fL/4
         7iIl+GH9LOKkrqq+YYCkpkElVKMHNrGwSonIZtJQ=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC54660274;
        Thu, 18 Apr 2019 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555584020;
        bh=lidZ7OKPmqM5NevlNHhoh0GT6XnvCpxGyssmWrRe86s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aqOOVk/uFcwLtDna6zlyVmPBGmmvCTqV4kD2IZ2mZqepEkYwWKFveZzvWOpY4K26C
         LWyLRsuYlvN0M/XMVpQiABqfchSJFakb086qgrg31kZsnRcV1OcRVc2jF4UWN6fL/4
         7iIl+GH9LOKkrqq+YYCkpkElVKMHNrGwSonIZtJQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC54660274
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/amd/amdgpu: fix spelling mistake "recieve" ->
 "receive"
To:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418102510.10253-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <541d2a2a-bcdf-5c4f-b075-7ca128757a45@codeaurora.org>
Date:   Thu, 18 Apr 2019 16:10:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418102510.10253-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 3:55 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 6a0fcd67662a..aef9d059ae52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -515,7 +515,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   
>   	/* wait until RCV_MSG become 3 */
>   	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
> -		pr_err("failed to recieve FLR_CMPL\n");
> +		pr_err("failed to receive FLR_CMPL\n");
>   		return;
>   	}
>   
