Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F519C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139B20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577487451;
	bh=I+l1SrhE5xdnfriFVKQh+/U9c+XMHk7eHYDAQjQszmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZr6FmsTYFzyr8+tAf38Pvli2mPxCsFL7YD6LuOdcyem9pzB16mvKmQSN8inQJvLG
	 VYz0g38qH8n11W3fHkDQF6S6ywEAQNh2T+fL6+xhbsqOkO6hC221g3KCWhUv6PJYA0
	 2JIOVpthWT1BZaiiiZLHMRfE7QNf4ZzgKjH7Pz+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfL0W5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:57:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33240 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0W53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:57:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so15099822pgk.0;
        Fri, 27 Dec 2019 14:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E+kLuWzj80EvnFF/oib9ssslkvZ228O67/W2bXxQ/pc=;
        b=alIASRwC9MAeNWDMqXGCUuildoUx3gjtn4xv1mPE9069xvZVCb7jYDc2Mzk7YX+7ae
         57oXsu8YuVgdU+G9uxwuzcjcGR3q9Nt/gk4ftWUNcajRjz43dDylB0YMhlCwsK4eiU3E
         vWHPLHKma+ofpR9IHrtgk8GPTAFPavKftdZH8RlYGBdLYPaD0GgHXS/K/nu6hc4/v9ps
         ywUgbZobGZJwPCti6Dbw1UkrPGRrAsvqeZnqUBRGVPQ9VxL8nvkNftJQT+IxujaH8seB
         OMHu8seoFCtAevz9ss6G7EFHvdscWSDt6hH89IhYo6vkmNcUhBPFkepVMrOY3AZ2Q9ow
         ni3Q==
X-Gm-Message-State: APjAAAX0/paoeAVqSL/d/eOv9TH5G3Q9odZg9W+ksJHSw8XkoEmBMZnS
        M/dbVHdg6lcvBvrKR0K1gS4=
X-Google-Smtp-Source: APXvYqyzIU5OQ9L7H0wtyUKGd7HslFtp+RRQaTfZ6Ud99txdNoPzFd0/2xHVM2OIIlpp6H79R59Nnw==
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr57958004pgi.159.1577487449227;
        Fri, 27 Dec 2019 14:57:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:1443:739:e13:41a5])
        by smtp.gmail.com with ESMTPSA id gc1sm15437871pjb.20.2019.12.27.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 14:57:28 -0800 (PST)
Date:   Fri, 27 Dec 2019 14:57:26 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     yu kuai <yukuai3@huawei.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawe.com,
        zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Message-ID: <20191227225726.GA1643@archbook>
References: <20191226121638.10507-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191226121638.10507-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 08:16:38PM +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
> drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
> used [-Wunused-but-set-variable]
> 
> It is never used and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  drivers/fpga/dfl-fme-main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 7c930e6b314d..1d4690c99268 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
>  static void fme_dev_destroy(struct platform_device *pdev)
>  {
>  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> -	struct dfl_fme *fme;
>  
>  	mutex_lock(&pdata->lock);
> -	fme = dfl_fpga_pdata_get_private(pdata);
>  	dfl_fpga_pdata_set_private(pdata, NULL);
>  	mutex_unlock(&pdata->lock);
>  }
> -- 
> 2.17.2
> 
Acked-by: Moritz Fischer <mdf@kernel.org>

Thanks,
Moritz
