Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CAC282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759A02183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 00:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RIxiIXLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfDRAV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 20:21:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:21378 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387497AbfDRAV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 20:21:29 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190418002125epoutp04e4a6a09a5a2a41b24e2f00a491cfa42d~WaaaBy8KF1195311953epoutp04g
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:21:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190418002125epoutp04e4a6a09a5a2a41b24e2f00a491cfa42d~WaaaBy8KF1195311953epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555546885;
        bh=fAaL6u2Aby6gbkT8BBHQT7ABo1NBSCmkREI+utJJ/5U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RIxiIXLKg/w0UHQFs8GKPQn0aha06az4EizLnFjxIIHjf6x/1h5Pr1m/qbsJ20bMF
         +qFVtPTWzvkwjYGAxsR0Q5nVgjc63bUODEmnbNMLYL7VZPGygWsu8RWAtjQMhwDORF
         ZNUGsxkI2CVNRwE8qm8b+RC6IyhZgh6lzInGxACU=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418002122epcas1p20067ed0b6a945c9e16f7a8eb0031dc22~WaaXuE5Az1274112741epcas1p27;
        Thu, 18 Apr 2019 00:21:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.E8.04257.103C7BC5; Thu, 18 Apr 2019 09:21:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190418002121epcas1p31452518cb6613a4059dc64eff6e47d1a~WaaWwaJu20632406324epcas1p3-;
        Thu, 18 Apr 2019 00:21:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190418002121epsmtrp13e7764cd7590abe3d9b291d5c28e4e93~WaaWvkxoy2086320863epsmtrp1X;
        Thu, 18 Apr 2019 00:21:21 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-71-5cb7c30192b5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.C0.03662.103C7BC5; Thu, 18 Apr 2019 09:21:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418002121epsmtip2f03c8bfbdb80362895e45d6f19dda3f7~WaaWl6Pie0762007620epsmtip2D;
        Thu, 18 Apr 2019 00:21:21 +0000 (GMT)
Subject: Re: [PATCH v3 15/16] PM / devfreq: tegra: Rename tegra-devfreq.c to
 tegra30-devfreq.c
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <82a9bb0d-b001-96e1-dcf0-ae1d6e8308be@samsung.com>
Date:   Thu, 18 Apr 2019 09:22:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-16-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmvi7T4e0xBl1HlS1Wf3zMaNEyaxGL
        xdmmN+wWl3fNYbP43HuE0aLzyyw2i9uNK9gsfu6ax2LRt/YSmwOnx467Sxg9ds66y+7R2/yO
        zaNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4AOUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ7zceZe14CN3xccZWg2Mnzm7GDk5JARMJP6fu8raxcjFISSwg1Hi056p
        zBDOJ0aJb/OnQmW+MUp8b3/FBNPy691CqKq9jBLdF3qgqt4zSmxp/8QOUiUskCCxZf8cFpCE
        iMA/oMG7ZrCCJJgFIiW+HlzKDGKzCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfRNmcLC4jNIqAq
        cfTYZrAaUYEIifvHNrBC1AhKnJz5BKyGU8BM4k7XATaI+eISt57MZ4Kw5SWat84GO1VC4D+b
        xPPVz5khfnCRmPX3JNQ/whKvjm9hh7ClJF72t0HZ1RIrTx5hg2juAHpt/wVWiISxxP6lk4Ga
        OYA2aEqs36UPsYxP4t1XUFBwAJXwSnS0CUFUK0tcfnAXapWkxOL2TjYI20Piw+5mlgmMirOQ
        vDMLyQuzkLwwC2HZAkaWVYxiqQXFuempxYYFJsjRvYkRnFq1LHYw7jnnc4hRgINRiYd3her2
        GCHWxLLiytxDjBIczEoivI4pW2KEeFMSK6tSi/Lji0pzUosPMZoCQ3sis5Rocj4w7eeVxBua
        GhkbG1uYGJqZGhoqifOud3COERJITyxJzU5NLUgtgulj4uCUamAMDNeykb12WHDLniTX3Um3
        HCw/ZJm+mbONdXVYhnneQp0SjcmhMccCS3nYJZp3iaQYBnPtksk1cxbS+uvzzWctk9e8QuYy
        vwqvpu0cE1tu8G5RLa2+Esq0rqvNuo+ZhbPGIy0nkDvu+6GtmVJ2yufUPuu+OuywfPrFOLNt
        X9+WzeytKD/Kr8RSnJFoqMVcVJwIADIMtezDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSvC7j4e0xBn9OKlus/viY0aJl1iIW
        i7NNb9gtLu+aw2bxufcIo0Xnl1lsFrcbV7BZ/Nw1j8Wib+0lNgdOjx13lzB67Jx1l92jt/kd
        m0ffllWMHp83yQWwRnHZpKTmZJalFunbJXBlvNx5l7XgI3fFxxlaDYyfObsYOTkkBEwkfr1b
        yNzFyMUhJLCbUWLev+ksEAlJiWkXjwIlOIBsYYnDh4tBwkICbxkljp6RBrGFBRIktuyfwwLS
        KyLQxCTx+WELE0iCWSBSov9RNyvE0C2MEvub/jGCJNgEtCT2v7jBBmLzCyhKXP3xGCzOK2An
        0TZnC9hiFgFViaPHNoPViApESJx5v4IFokZQ4uTMJ2A2p4CZxJ2uA2wQy9Ql/sy7xAxhi0vc
        ejIf6gh5ieats5knMArPQtI+C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqX
        rpecn7uJERxhWlo7GE+ciD/EKMDBqMTDu0J1e4wQa2JZcWXuIUYJDmYlEV7HlC0xQrwpiZVV
        qUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhhtdA4Hz9zeKDft3qWw
        labLt5dOty5t+92hLjHdM+fDC7ktLi/fbIo6eFK/Iu3acaG5/Y5z6zIPTS1INQ99cmTb41NG
        L9zmLE35phV0cxLbrAtVnUY/7F9/ZpbWkTU9+UKwjtlbjnF5XujBTZzbkp7y7guNO7htY+Hi
        xP+fruov6XO+22c44csDJZbijERDLeai4kQAxVHol6wCAAA=
X-CMS-MailID: 20190418002121epcas1p31452518cb6613a4059dc64eff6e47d1a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224144epcas5p272058945679161eee7f9a3e0bcdd7de5
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224144epcas5p272058945679161eee7f9a3e0bcdd7de5@epcas5p2.samsung.com>
        <20190417222925.5815-16-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> In order to reflect that driver serves NVIDIA Tegra30 and later SoC
> generations, let's rename the driver's source file to "tegra30-devfreq.c".
> This will make driver files to look more consistent after addition of a
> driver for Tegra20.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/Makefile                               | 2 +-
>  drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/devfreq/{tegra-devfreq.c => tegra30-devfreq.c} (100%)
> 
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d3f12c..47e5aeeebfd1 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> -obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
> similarity index 100%
> rename from drivers/devfreq/tegra-devfreq.c
> rename to drivers/devfreq/tegra30-devfreq.c
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
