Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3591C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3502183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DPE9pK2o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m3pNlkpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbfDRLIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:08:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:08:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 993E660721; Thu, 18 Apr 2019 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555585729;
        bh=YBsJULlA80zIYHgmJ4RMOhaZw0W3VjqokfkpTpWQbkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DPE9pK2oGLyXKDb+p2L5UGDU3p1mTxRKRmYoYTbb3Zwi5jiYVl/SM2+SV4vSTqorH
         QLnwAX4QkVZED3d1Pk+oHmSikof9qDf3eQxprOPGitCReLh34+XD/OSPEVCugFRpc1
         ZLfr/CWJGHEfvtBVjMF+E6lja/0hayGBoHMzMQp8=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F69D601B4;
        Thu, 18 Apr 2019 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555585728;
        bh=YBsJULlA80zIYHgmJ4RMOhaZw0W3VjqokfkpTpWQbkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=m3pNlkpkUQ35U2V9Orf6C8b4qMDW/8/k2B/wY57vOrPX79Dbjmvv0NBnwHg3GWlc6
         a902UcnMgKxo1Km0GVu1wofGhTZeVcLKXfC7qHWWXcYysNLr85u40zu5aqxrRaTjW0
         3G8+HF2Jx1O0JyVN6fjSDUn+GumfvAn/8Vz+r6RA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F69D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/i915: fix spelling mistake "resseting" -> "resetting"
To:     Colin King <colin.king@canonical.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418110622.11452-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <0cf4de0f-c58e-d3e0-a134-b7aa73c3dfeb@codeaurora.org>
Date:   Thu, 18 Apr 2019 16:38:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418110622.11452-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 4:36 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a gvt_dbg_core debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/gpu/drm/i915/gvt/vgpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
> index 44ce3c2b9ac1..d1e818f2b521 100644
> --- a/drivers/gpu/drm/i915/gvt/vgpu.c
> +++ b/drivers/gpu/drm/i915/gvt/vgpu.c
> @@ -533,7 +533,7 @@ void intel_gvt_reset_vgpu_locked(struct intel_vgpu *vgpu, bool dmlr,
>   	intel_engine_mask_t resetting_eng = dmlr ? ALL_ENGINES : engine_mask;
>   
>   	gvt_dbg_core("------------------------------------------\n");
> -	gvt_dbg_core("resseting vgpu%d, dmlr %d, engine_mask %08x\n",
> +	gvt_dbg_core("resetting vgpu%d, dmlr %d, engine_mask %08x\n",
>   		     vgpu->id, dmlr, engine_mask);
>   
>   	vgpu->resetting_eng = resetting_eng;
