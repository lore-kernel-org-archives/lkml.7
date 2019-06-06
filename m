Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DCFC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE620652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edOUZg3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfFFRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:08:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729905AbfFFRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:08:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so1873326pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DfWGqMsNhu0Wn9UXa5rpUQbIrk9rtIgPo7mJo0K3Iy0=;
        b=edOUZg3GANEHsuow5KsriAJk8/6SQssHjNCT4tBBHkNEMs7cc7BSBL3Y5TX+twtruP
         6TSMfZEm92SNNInMq87/gyoNQ336XCRS8pIlKvho5y7eSZB2ZIoGpjkMaChwJVN6lykR
         N+iefC9iJuKoXcUKxrzKy8O/cExO4RJci97F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DfWGqMsNhu0Wn9UXa5rpUQbIrk9rtIgPo7mJo0K3Iy0=;
        b=MoHP86kWLYdP3Vq/1+0yFpqt2Vw1OxJlG5ve9M8kgkhwNa8ZBL5uL8Vd/Of6jH8UcX
         KRUiQdjz6RlzpkHaNleV9M/ND3SzLR+6fUAiWj+jGyUV450qjb67x/n9Z2x9PexInt73
         G13KQp6n3edfqOz+xw44+juk5B0h+X7CLn/B58AQkoBtgquOZgMCVKH8RwtjwuylaE/I
         qgWnPlLQ4lN8sxV4s/YGcy+Vf0RbJ0TtRNmrCjnwCOxT0UV/Lyjty/Bqe/VPr1fgLCSp
         KnExfdRC3OyM1lUvpStdDJWYU5LlC9zCAhKW7qonbep95/UC15pUkV9sWKKSVLwJqOoi
         NFHA==
X-Gm-Message-State: APjAAAVdmUloaUFCdPdEvpMsybJ9mRkoJwIYLYMNcoqiGmt5q1wire58
        mwc5HcHXJMbKFF6eV3sufDr+rA==
X-Google-Smtp-Source: APXvYqx1MzvkxzqJ8jjRho8uRYT9sXVTCtAk6vNSNa5xM12hkcJ+i72lyJF9dDCi4kO+O6iXQnbySw==
X-Received: by 2002:aa7:942f:: with SMTP id y15mr55190799pfo.121.1559840887916;
        Thu, 06 Jun 2019 10:08:07 -0700 (PDT)
Received: from [10.69.37.149] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x25sm2648197pfm.48.2019.06.06.10.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 10:08:07 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Avoid unused function warnings
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
References: <20190606052421.103469-1-natechancellor@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <27ccc327-3a4b-f489-2b21-b68479e45519@broadcom.com>
Date:   Thu, 6 Jun 2019 10:08:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606052421.103469-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2019 10:24 PM, Nathan Chancellor wrote:
> When building powerpc pseries_defconfig or powernv_defconfig:
>
> drivers/scsi/lpfc/lpfc_nvmet.c:224:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_xri' [-Werror,-Wunused-function]
> drivers/scsi/lpfc/lpfc_nvmet.c:246:1: error: unused function
> 'lpfc_nvmet_get_ctx_for_oxid' [-Werror,-Wunused-function]
>
> These functions are only compiled when CONFIG_NVME_TARGET_FC is enabled.
> Use that same condition so there is no more warning. While the fixes
> commit did not introduce these functions, it caused these warnings.
>
> Fixes: 4064b27417a7 ("scsi: lpfc: Make some symbols static")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/scsi/lpfc/lpfc_nvmet.c | 2 ++
>   1 file changed, 2 insertions(+)
>
>

Looks fine.

Reviewed-by:  James Smart  <james.smart@broadcom.com>


