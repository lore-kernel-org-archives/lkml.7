Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5748C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1BC21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U42Wl4rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgAFIEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:04:06 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:55964 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgAFIEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:04:05 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200106080402epoutp0378b44c085e4962f4fba34eb28989bc91~nPYahzXcS1913619136epoutp03v
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jan 2020 08:04:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200106080402epoutp0378b44c085e4962f4fba34eb28989bc91~nPYahzXcS1913619136epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578297842;
        bh=2N1cMzaelT4GEcMOxrpKGVEc7+Kwyhgvo3E3y24uV9s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U42Wl4rhHcbYpy4AUCDxQDTcKbttsXGxNncKAmRk8mBcGdhxmtWCcGxce/4+rOQyB
         w6RmBvt1oLd/R1Sb0jyu+stdFd1bKi/yz92ORug1CdmLtLEldP11QiBV5u0ubWEzTE
         9Z2QrFo8zKxCRKAUXUw0vDy3CPHFvXDxoT+4XPaA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200106080402epcas1p4883f6c266926418496ffcfab59943b32~nPYaCHavV0252602526epcas1p4L;
        Mon,  6 Jan 2020 08:04:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47rp1X0qGFzMqYkh; Mon,  6 Jan
        2020 08:04:00 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.5F.48019.0F9E21E5; Mon,  6 Jan 2020 17:04:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200106080359epcas1p43784b28c3abd6d52966fade1144c2a28~nPYXdL6wl0529005290epcas1p4e;
        Mon,  6 Jan 2020 08:03:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200106080359epsmtrp2d3fb29d0a153503d12223a8a6ddebefa~nPYXcXAfe2989729897epsmtrp27;
        Mon,  6 Jan 2020 08:03:59 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-09-5e12e9f0aeb9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.26.10238.FE9E21E5; Mon,  6 Jan 2020 17:03:59 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200106080359epsmtip297c553803669d2d65d4e8ffd26b760e2~nPYXQlSzV2123521235epsmtip2Z;
        Mon,  6 Jan 2020 08:03:59 +0000 (GMT)
Subject: Re: [PATCH v2 14/20] drm/exynos: Rename Exynos to lowercase
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <7a3091c2-c9fe-ba60-cc59-3d812a4407f7@samsung.com>
Date:   Mon, 6 Jan 2020 17:07:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200104152107.11407-15-krzk@kernel.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmvu6Hl0JxBvNvMlv0njvJZPF/20Rm
        iytf37NZvLh3kcWi//FrZovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyWLG5JdsDtwee78t
        YPHYtKqTzWP7twesHve7jzN5bF5S79G3ZRWjx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyMxY+3sFW8Fi4YuHtQ6wNjD0CXYyc
        HBICJhIPTjYxdTFycQgJ7GCU+DR3BSNIQkjgE6PE3+0hEIlvjBJPNp9igen4N+sGVMdeRokZ
        r16xQjjvGSW2b3zIBFIlLOAisbbvJjOILSLgLrHg/xo2kCJmgUtMEnvub2QHSbAJqEpMXHGf
        DcTmFbCTOPPzAtgKFgEViT9z5wNN5eAQFYiQOP01EaJEUOLkzCdgJZwCZhLHp7WxgtjMAuIS
        t57MZ4Kw5SWat85mBtklIdDPLvHpdBcrxNkuEmsmLmSGsIUlXh3fwg5hS0l8freXDcKulphw
        8D8LRHMDo0T30U6oImOJ/UsnM4EcxCygKbF+lz5EWFFi5++5jBCL+STefe0Bu1lCgFeio00I
        okRJ4tjFG4wQtoTEhSUToVZ5SGx+uIZpAqPiLCSvzULyziwk78xCWLyAkWUVo1hqQXFuemqx
        YYEJcmxvYgSnXy2LHYx7zvkcYhTgYFTi4WUIFooTYk0sK67MPcQowcGsJMLb6CYYJ8SbklhZ
        lVqUH19UmpNafIjRFBjwE5mlRJPzgbkhryTe0NTI2NjYwsTQzNTQUEmcl+PHxVghgfTEktTs
        1NSC1CKYPiYOTqkGxpa5sSkdUkVT2S5KLO+dWhTWIdXRwrclWbtd71SynOff7jN+QqmHnioe
        nyMfWh126HzG0U2bt9nPmrL37Mt3Jz+W3ebzWlCeGx2eMmvS9ownX0pdPwib7vi78az+jOU6
        K39qO76P/bVh0fyvvRkPBZWW/91tcfyvuaWCm6mbRNrkN5e/ZtSE7lFiKc5INNRiLipOBAAS
        rtmL1QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7bCSvO77l0JxBq8Pylr0njvJZPF/20Rm
        iytf37NZvLh3kcWi//FrZovz5zewW5xtesNusenxNVaLy7vmsFnMOL+PyWLG5JdsDtwee78t
        YPHYtKqTzWP7twesHve7jzN5bF5S79G3ZRWjx+dNcgHsUVw2Kak5mWWpRfp2CVwZCx/vYCt4
        LFyx8PYh1gbGHoEuRk4OCQETiX+zbjB1MXJxCAnsZpR4evAJSxcjB1BCQmLLVg4IU1ji8OFi
        iJK3jBLbt09kA+kVFnCRWNt3kxnEFhFwl1jwfw0bSBGzwBUmiTPP9oIlhAS2MEqs+sYPYrMJ
        qEpMXHEfrJlXwE7izM8LLCA2i4CKxJ+581lBbFGBCInn228wQtQISpyc+QSshlPATOL4tDaw
        GmYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpu
        sWGBYV5quV5xYm5xaV66XnJ+7iZGcLxpae5gvLwk/hCjAAejEg/vigChOCHWxLLiytxDjBIc
        zEoivI1ugnFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEoB
        o2NGgeLEpLnxmb75kY5z/vWIv/ig8dOee/LuZ712mrODrmcsXGvKeSmium//BvPUQKV39no5
        r3O3+nQ2/Uj7uDCvcM+/zpxtbyes41jZV3G62fYld11kwOa+jJvNn/fG+Bu+LDrB2HN7YsAR
        viVTmgXPaKpeM0q58zh74aeePas+shuxVxzjUWIpzkg01GIuKk4EAGaSPeazAgAA
X-CMS-MailID: 20200106080359epcas1p43784b28c3abd6d52966fade1144c2a28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200104152253epcas1p121c2069ac4e57679d6012e0a5e7a5002
References: <20200104152107.11407-1-krzk@kernel.org>
        <CGME20200104152253epcas1p121c2069ac4e57679d6012e0a5e7a5002@epcas1p1.samsung.com>
        <20200104152107.11407-15-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

20. 1. 5. 오전 12:21에 Krzysztof Kozlowski 이(가) 쓴 글:
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
> 
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.

Making sense so picked it up now.

Thanks,
Inki Dae

> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/exynos/Kconfig | 6 +++---
>  include/uapi/drm/exynos_drm.h  | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
> index 6f7d3b3b3628..6417f374b923 100644
> --- a/drivers/gpu/drm/exynos/Kconfig
> +++ b/drivers/gpu/drm/exynos/Kconfig
> @@ -1,13 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DRM_EXYNOS
> -	tristate "DRM Support for Samsung SoC EXYNOS Series"
> +	tristate "DRM Support for Samsung SoC Exynos Series"
>  	depends on OF && DRM && (ARCH_S3C64XX || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_MULTIPLATFORM || COMPILE_TEST)
>  	depends on MMU
>  	select DRM_KMS_HELPER
>  	select VIDEOMODE_HELPERS
>  	select SND_SOC_HDMI_CODEC if SND_SOC
>  	help
> -	  Choose this option if you have a Samsung SoC EXYNOS chipset.
> +	  Choose this option if you have a Samsung SoC Exynos chipset.
>  	  If M is selected the module will be called exynosdrm.
>  
>  if DRM_EXYNOS
> @@ -62,7 +62,7 @@ config DRM_EXYNOS_DSI
>  	  This enables support for Exynos MIPI-DSI device.
>  
>  config DRM_EXYNOS_DP
> -	bool "EXYNOS specific extensions for Analogix DP driver"
> +	bool "Exynos specific extensions for Analogix DP driver"
>  	depends on DRM_EXYNOS_FIMD || DRM_EXYNOS7_DECON
>  	select DRM_ANALOGIX_DP
>  	default DRM_EXYNOS
> diff --git a/include/uapi/drm/exynos_drm.h b/include/uapi/drm/exynos_drm.h
> index 45c6582b3df3..a51aa1c618c1 100644
> --- a/include/uapi/drm/exynos_drm.h
> +++ b/include/uapi/drm/exynos_drm.h
> @@ -394,7 +394,7 @@ struct drm_exynos_ioctl_ipp_commit {
>  #define DRM_IOCTL_EXYNOS_IPP_COMMIT		DRM_IOWR(DRM_COMMAND_BASE + \
>  		DRM_EXYNOS_IPP_COMMIT, struct drm_exynos_ioctl_ipp_commit)
>  
> -/* EXYNOS specific events */
> +/* Exynos specific events */
>  #define DRM_EXYNOS_G2D_EVENT		0x80000000
>  #define DRM_EXYNOS_IPP_EVENT		0x80000002
>  
> 
