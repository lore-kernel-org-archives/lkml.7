Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E500DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423720828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577487494;
	bh=qSJe1ndaPvG7g16FFQtF/T2el2YDH0WW2tLuH1i4CVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUx+rSUMOAfHL7gJf/SRroV0omVpyMZ3qGZFR9GVHVsxhLF3w+jUvIiovh2qSgFMf
	 cAbDZJ5EPAOs1JciarSb0NqKfxBs6hsqYMq16DZNsZ+dtemga94pw1TNwHBrIASzg5
	 cSoqWFZXX8ysTAJ7g0WMk9Y8q4Ds0exPoXVeHwjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfL0W6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:58:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36867 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0W6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:58:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so15368112pfn.4;
        Fri, 27 Dec 2019 14:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8RTxVfZJ6EIEQO8Ecm2zyDsH5B3TQhp3ssvQ5Vtfb50=;
        b=V/FwLVRXmVZE7R9WVZY/YG6gdgULD2DEn7t1JwU4VvVhbTLMkWG4Xknl56zn3+7mSo
         6Ck+Kg1kzZT7JuqLDmCTb2erjX36+czQzDrtk+18dn8hTPz3nUtOadYQDtyr+BnxJ3ml
         H3BtAINiemDfw+zlIZpxNclCyJCFycOpM3eZhqjVTZxqDz9Gtw4qo1lmSJX11qXxWNxn
         iZRGmb/+r88wCSpRdgYGsU34A0fCC9oo/8NwuGXmGxApiqEJdEbZ6l3TdH5SebfDrZjn
         dTBadzGuu9LnEW/epzlckab8JspjjM+0x1j6DOg45TirE0sivGuLfwxZ4uh/QsdO6e3u
         mScg==
X-Gm-Message-State: APjAAAWqEczvgctMIZ5dKFVbOPbeiSmlsZrpa0Pc+/EFzpPamyHazlU0
        76Wn18BkpbXJnyDAHq/oaeKyLS4MRd4=
X-Google-Smtp-Source: APXvYqxBNGrVUofdeKCZXyZAXfDKi9TdmyXwqUiwg13bmUkQnTi5GKhGDrEh0hIl09l0I4ZsUYRs7Q==
X-Received: by 2002:aa7:9edd:: with SMTP id r29mr56006733pfq.14.1577487492007;
        Fri, 27 Dec 2019 14:58:12 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:1443:739:e13:41a5])
        by smtp.gmail.com with ESMTPSA id 136sm37790607pgg.74.2019.12.27.14.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 14:58:11 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:58:09 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawe.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Message-ID: <20191227225809.GB1643@archbook>
References: <20191226121533.6017-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226121533.6017-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 08:15:33PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
> drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
> set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/fpga/dfl-afu-main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index e4a34dc7947f..65437b6a6842 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
>  static int afu_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct dfl_afu *afu;
>  
>  	mutex_lock(&pdata->lock);
> -	afu = dfl_fpga_pdata_get_private(pdata);
>  	afu_mmio_region_destroy(pdata);
>  	afu_dma_region_destroy(pdata);
>  	dfl_fpga_pdata_set_private(pdata, NULL);
> -- 
> 2.17.2
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

I'll get to the patches in the new year.

Thanks,
Moritz
