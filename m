Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD5C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B79206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xUHaVXMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFVKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:43:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:43:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MAe6EL149137;
        Sat, 22 Jun 2019 10:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kq0vqQjo14XEI66TpU/rqYxVUPhSaWKc+eKAGmgwWQA=;
 b=xUHaVXMSzCBsFfEes7e5FsFtZJjipV7WL6pW++EZJmcpQWQLGIXSBL+JnjPEf9qYFLTk
 WS5T7GxE1Nzobuppq2hF/Bmr8tWQ6Zy/T3sPNfSw2kIhBUhqxPME8z4MzauDRJUtdmnc
 9s2M6LGTgzzHVuwJl1L5brdsZoo7kEHUn932cQRnyLIpuZx2DVx6oprsFIi0oR+MDKXx
 VY7E23g19pi4QauLQyApJY+qfCVnHWNfd86EFz+PzZYKvn8oF+wLx9QKJrFowKtxdgsF
 pJRmpMpv7Dg1rU+B0p4cCfbq7aAIaDA+YGQk9vI0X3C4QA5uou2aA5WckZXlqZ5BkGBK Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9p8pp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 10:43:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5MAhPYm103599;
        Sat, 22 Jun 2019 10:43:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9c5239h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jun 2019 10:43:35 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5MAhQga013247;
        Sat, 22 Jun 2019 10:43:26 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 22 Jun 2019 03:43:25 -0700
Date:   Sat, 22 Jun 2019 13:43:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com,
        kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variables 'ret'
Message-ID: <20190622104318.GT28859@kadam>
References: <20190622030314.169640-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622030314.169640-1-maowenan@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906220098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2019 at 11:03:14AM +0800, Mao Wenan wrote:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> index 0e6dba9..0bf4dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> @@ -246,12 +246,10 @@ static int init_pmu_by_type(struct amdgpu_device *adev,
>  /* init amdgpu_pmu */
>  int amdgpu_pmu_init(struct amdgpu_device *adev)
>  {
> -	int ret = 0;
> -
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
>  		/* init df */
> -		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> +		init_pmu_by_type(adev, df_v3_6_attr_groups,
>  				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
>  				       DF_V3_6_MAX_COUNTERS);


You're resending this for other reasons, but don't forget to update the
indenting on the arguments so they still line up with the '('.

regards,
dan carpenter

