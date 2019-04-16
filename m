Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857D620870
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fz1bD2rC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="i8eA5Uhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfDPNVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:21:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfDPNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:21:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0373161344; Tue, 16 Apr 2019 13:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420882;
        bh=jNLAXR47Hu5oYaC8T3bsu06237rJMDHln39036RO3/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fz1bD2rCWnjBIcD2QNngeLmrr2H3R5WK9eAabyPDrJsTACj3rwVWEs/xUM4Re8Hu2
         LeTwJjmFwUPUGNz6I+OPMSngXsMvmC0m3snnbiEj/7Ia1Tf9i4l3fl+qOPolOBKNZj
         Viiqq5ZmnOz2L/FSURLbriInzmLxmndwJQv6FOpE=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A68660850;
        Tue, 16 Apr 2019 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555420881;
        bh=jNLAXR47Hu5oYaC8T3bsu06237rJMDHln39036RO3/M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i8eA5UhwMYXee/iVoCwNIWvnkzUaphyaDejdL4E+fQbccULjjHpzbJNcLknpTMHw6
         8AINMtneGTzPXYmDlt+YK5vlyAVRVkwnyj32xor7CnKJ7EiZ1fxMRBsMlO/7MDP6aV
         a429XSVRnRuG06PoKrkurad5jqzFjQv/EI3ttZWU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A68660850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/amdgpu: fix spelling mistake "gateing" -> "gating"
To:     Colin King <colin.king@canonical.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416115926.32669-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2849eabb-6f89-08b9-4537-b75971b205bd@codeaurora.org>
Date:   Tue, 16 Apr 2019 18:51:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416115926.32669-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 5:29 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a DRM_INFO message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index bed78a778e3f..40363ca6c5f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -283,7 +283,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
>   	}
>   
>   	if (vce_v2_0_wait_for_idle(adev)) {
> -		DRM_INFO("VCE is busy, Can't set clock gateing");
> +		DRM_INFO("VCE is busy, Can't set clock gating");
>   		return 0;
>   	}
>   
