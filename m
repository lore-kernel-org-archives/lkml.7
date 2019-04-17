Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A6BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF8C2176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s8RufhkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfDQIJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:09:50 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:62225 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:09:49 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190417080947epoutp01732c844b69bde4b291634c70af09ee14~WNKDqAy9B1668516685epoutp01K
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:09:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190417080947epoutp01732c844b69bde4b291634c70af09ee14~WNKDqAy9B1668516685epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555488587;
        bh=M1KlmsFxp8IIy/czUXSX23w3lYTaCR4FADID1qiBD9k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s8RufhkNT8TAg6fCj3IhFC2z7aST37EmR0eb+4XFaSH0n2fvG94tQ7YyOvIEY0VPA
         A05IKk0DWFhNEIJbO/ivhwDwm//+8QJi5UtFE40no+3xWCuNVVOcsLU7Wg/BTLzjS+
         XLj5krgC9H2UakXqryCxoSHvvkUFRlA34kbshWzY=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190417080942epcas1p2a65a5b6fea6cac44b99d69a0054cfce6~WNJ-wzMP02488824888epcas1p2f;
        Wed, 17 Apr 2019 08:09:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.AA.04143.64FD6BC5; Wed, 17 Apr 2019 17:09:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190417080941epcas1p1aa6e9146ea5af4640631e7dbc173b156~WNJ_44Yml1835618356epcas1p1k;
        Wed, 17 Apr 2019 08:09:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417080941epsmtrp28bba37b65ebeaabe4625f6db2d560a7f~WNJ_3_r1v0672006720epsmtrp2Q;
        Wed, 17 Apr 2019 08:09:41 +0000 (GMT)
X-AuditID: b6c32a37-394199c00000102f-78-5cb6df4670ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.10.03692.54FD6BC5; Wed, 17 Apr 2019 17:09:41 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417080941epsmtip1e003496d948884ee7dc98f6147954e3b~WNJ_mpkzZ2510625106epsmtip1W;
        Wed, 17 Apr 2019 08:09:41 +0000 (GMT)
Subject: Re: [PATCH 1/3] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3fcb6dde-7ccc-4da6-5f8b-c8338edaa155@samsung.com>
Date:   Wed, 17 Apr 2019 17:10:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEJsWRmVeSWpSXmKPExsWy7bCmnq7b/W0xBt8OSllsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3ibNMbdotbDTIWmx5fY7W4vGsOm8Xn3iOMFjPO72OyWHvkLrvF0usXmSxu
        N65gs2jde4Td4vCbdlYHfo8189Ywemxa1cnmsXlJvcfBd3uYPPq2rGL0+LxJLoAtKtsmIzUx
        JbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hiJYWyxJxSoFBA
        YnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJucWleul5yfq6VoYGBkSlQYUJ2xt5Nu1kL
        2oQrpkx5wtrAuIK/i5GDQ0LAROLSn7QuRi4OIYEdjBKbvs1ghXA+MUrM/zCBEcL5xiix/upX
        9i5GTrCOUxt+sUAk9jJKfHrygRnCec8oceHFcWaQKmGBaIlp9y+AzRIROMso8aBpGxuIwyxw
        hVHi6ZdFYFVsAloS+1/cYAOx+QUUJa7+eMwIYvMK2EnsOrAYzGYRUJXY+/cmE4gtKhAhcf/Y
        BlaIGkGJkzOfsIDYnAJeErfnTwCbwywgLnHryXwmCFteonnrbLDzJAS2sUvc+L6fGeIJF4lJ
        G58zQtjCEq+Ob4F6Tkri87u9bBB2tcTKk0fYIJo7GCW27L/ACpEwlti/dDITKPyYBTQl1u/S
        h1jGJ/Huaw8rJFh5JTrahCCqlSUuP7jLBGFLSixu74Qa7yGxYvJ9pgmMirOQvDMLyQuzkLww
        C2HZAkaWVYxiqQXFuempxYYFxsjxvYkRnJ61zHcwbjjnc4hRgINRiYd3xc+tMUKsiWXFlbmH
        GCU4mJVEeB1TtsQI8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR5Hxg7sgriTc0NTI2NrYwMTQz
        NTRUEudd7+AcIySQnliSmp2aWpBaBNPHxMEp1cDoqTLN4nTbxLuB6kfOPrZhnrPlp0HjHvFI
        5mV1QZv/sEx/tuP864NSfo9UnxUdsxPZdJ/j55zdm58ySs1jVf1j69C+0aTYa5bwtksT66Z2
        2lbu1+Zoefsx9fqW3NXNO+2ScjjsjhnF9Wx/edox1kZEW8g7wKjqZozJVvu+5Ys/ZD3fnezH
        nP1DiaU4I9FQi7moOBEAeT+TNuUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7bCSnK7r/W0xBu3fdS02zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3
        G1ewWbTuPcJucfhNO6sDv8eaeWsYPTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWxWWTkpqT
        WZZapG+XwJWxd9Nu1oI24YopU56wNjCu4O9i5OSQEDCROLXhF0sXIxeHkMBuRonVUyawQSQk
        JaZdPMrcxcgBZAtLHD5cDFHzllFiy8vDLCA1wgLREm0H14M1iwicZZRYNGkBO4jDLHCFUWL5
        tcmsEC13GSU6Wk8yg7SwCWhJ7H9xA2wFv4CixNUfjxlBbF4BO4ldBxaD2SwCqhJ7/95kArFF
        BSIkzrxfwQJRIyhxcuYTMJtTwEvi9nyIU5kF1CX+zLvEDGGLS9x6Mp8JwpaXaN46m3kCo/As
        JO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwZGqpbmD8fKS
        +EOMAhyMSjy8K35ujRFiTSwrrsw9xCjBwawkwuuYsiVGiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OO/TvGORQgLpiSWp2ampBalFMFkmDk6pBka5eg9NRiuVGfPnyE6TjTFV6A649W0Z44aLOxv1
        ncNOXvxnv/Or7I/Is5NXODY0X2Jq3SlpFnq6rfTtZcb3cziuuvrX/259mnvi5aEQjWNvz772
        S/34SPDzk8ml+pX/MyXlA99ZVvWasBwW3Bln8ax+jaDq1l0aIsqvzq850fZ74637cucOvvmj
        xFKckWioxVxUnAgAwv2rgdACAAA=
X-CMS-MailID: 20190417080941epcas1p1aa6e9146ea5af4640631e7dbc173b156
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c@eucas1p2.samsung.com>
        <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
> This patch add support of a new feature which can be used in DT:
> Performance Monitoring Unit with defined event data type.
> In this patch the event data types are defined for Exynos PPMU.
> The patch also updates the MAINTAINERS file accordingly.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                           |  5 +++++
>  include/dt-bindings/pmu/exynos_ppmu.h | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3671fde..f4aac78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12376,6 +12376,11 @@ L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/pm8001/
>  
> +PMU EXYNOS DT BINDINGS
> +M:	Lukasz Luba <l.luba@partner.samsung.com>
> +S:	Maintained
> +F:	include/dt-bindings/pmu/exynos_ppmu.h
> +

IMHO, I'm not sure that it is right of adding one dt-binding header file
to MAINTAINERS file. If right, I'm OK.


>  PNP SUPPORT
>  M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>  S:	Maintained
> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
> new file mode 100644
> index 0000000..a6971eb
> --- /dev/null
> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Samsung Exynos PPMU event types for counting in regs
> + *
> + * Copyright (c) 2019, Samsung
> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
> + */
> +
> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
> +
> +
> +#define PPMU_RO_BUSY_CYCLE_CNT		0x0
> +#define PPMU_WO_BUSY_CYCLE_CNT		0x1
> +#define PPMU_RW_BUSY_CYCLE_CNT		0x2
> +#define PPMU_RO_REQUEST_CNT		0x3
> +#define PPMU_WO_REQUEST_CNT		0x4
> +#define PPMU_RO_DATA_CNT		0x5
> +#define PPMU_WO_DATA_CNT		0x6
> +#define PPMU_RO_LATENCY			0x12
> +#define PPMU_WO_LATENCY			0x16
> +#define PPMU_V2_EVT3_RW_DATA_CNT	0x22

If we can select the data type for monitoring, it looks good to me.
But, when I developed the Exynos PPMU, I has not tested other data type
except for PPMU_RO_DATA_CNT and PPMU_WO_DATA_CNT.

Do you test all data types with PPMU device?

> +
> +#endif
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
