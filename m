Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55711C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE420821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KxtE877R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfDQKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:51:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52428 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbfDQKvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:51:03 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190417105101euoutp02b119b97e082df3ff6189564440cd67bf~WPW1qPNyz0828908289euoutp02V
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:51:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190417105101euoutp02b119b97e082df3ff6189564440cd67bf~WPW1qPNyz0828908289euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555498261;
        bh=cUbJyeLGnZTKoG+3WUWGXKc8QHHKyKlBXZAp/zqOPx8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KxtE877Rf1DW5jj6YuEYsAYnz371V8Nj8GmdeOd3d5yWBSXG3ME4jxXm2vE1hrnno
         IQhEbjhGIdEyK2DkbK7jkJn6BgQvuARhAtRPP1VdFZOWzebEsXGIiKspHrccRn9xRA
         7hPOwPEsA0nrmRaqqYJdc8cWx1SMHR+7wUOnhuao=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190417105100eucas1p1674c2ba5fb088b00628d1c651f1fde88~WPW0y0HiC1190411904eucas1p1A;
        Wed, 17 Apr 2019 10:51:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.1B.04377.41507BC5; Wed, 17
        Apr 2019 11:51:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190417105059eucas1p10209319ab0c5d1f72ff804124767f9a6~WPWz7zhAR1418614186eucas1p1f;
        Wed, 17 Apr 2019 10:50:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190417105059eusmtrp2f942025a37060b56e4619595b62f640c~WPWzsFq0g0265702657eusmtrp2I;
        Wed, 17 Apr 2019 10:50:59 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-98-5cb705141f09
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 88.84.04146.31507BC5; Wed, 17
        Apr 2019 11:50:59 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190417105058eusmtip153fec08da9e3c3bd29b0955051f7e30f~WPWzGd-Dk0939509395eusmtip1N;
        Wed, 17 Apr 2019 10:50:58 +0000 (GMT)
Subject: Re: [PATCH 1/3] include: dt-bindings: add Performance Monitoring
 Unit for Exynos
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ed9df324-33ef-2e58-8b77-9a2561a4d6a4@partner.samsung.com>
Date:   Wed, 17 Apr 2019 12:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3fcb6dde-7ccc-4da6-5f8b-c8338edaa155@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzH+97vfnc/5vR15+FDpnbriS30tH5bppTZ/dmalUUPh9+ccof7
        eUjZolZKeUiSJE8jdhGdI51i4+aS8pSlkmioVmxxWmlKzu8s/73en8/7/f18PtuXIsT9pAsV
        qYpj1Cp5lFRgzW/smOveYk8+CvEuMtjQD/NrSXpw9jNJFxu6STpr7BtB9/TUCemX5yeFtHbs
        NUm/0hcKaFOGAdH5PS08usYwLKQrBvt49FBqlYC++NQgpNsn08i9q2XVRdVIptVcEcjqy8/J
        MnUaJDNp3Q6QR6x9wpmoyARG7eV7wlrRWpPNi+lyOP3sSzMvBVXYpSMrCvAOqLk6QaYja0qM
        qxCUlOdbxCyC1gfvLcKEoKWliFiOfP+ZZWlULkbmRy1iCkHa/d/I7JLgYMgb6V1q2ONOBBmp
        w0uCwAMIJmbLFt+iKAH2hCZNrDkgwgHQOHSdb2Y+3gCDTzpJMzvgIBjpqCM5jx103h5f8ljh
        PVCfm8szM4Gd4N14sYXXwoWGO4R5FuAfQpjJ5wKA/aFial7IsQS+GnUWdoWFx1wYMAspGaWI
        42QYy7pr8eyGdmMfad6ZwO5Qq/fiyn4wU5orMJcB28KbKTtuBVvIabxFcGURXL4k5tybQXet
        1zLIESqr84TZSFqw4rCCFccUrDim4P/cEsTXICcmnlVGMOw2FZPoycqVbLwqwjMsWqlFiz+t
        669xtgnp50PbEKaQ1EZUNdcQIiblCWySsg0BRUjtRX7huhCxKFyedIZRRx9Xx0cxbBtaQ/Gl
        TqKzq0aDxThCHsecYpgYRr3c5VFWLinoaFyjZpNzxLHtet8yhyFNMtw0Dnt7LBT+CuA9T7zR
        vHOydqCJZ0PqBxNlJklM2ElmfSCbs//jveK39TMv4iR1AwuhsVWf8kI3+qDxoD/uRfJSparY
        dGg6UMEeTiA+aPe5GaYbDvaX3R7wrkuyMqY67ip3ds30qfQIXRfm36FQSPmsQr7Vg1Cz8n9y
        rRwvZQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7rCrNtjDKZfFbLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZtF694j7BaH37SzOvB7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2P/2glMBadFK0682M3U
        wLhUsIuRk0NCwETiw/d+1i5GLg4hgaWMEktPHmaESIhJTNq3nR3CFpb4c62LDaLoNaPEopW3
        2UASwgLREm0H17OAJEQETjJKzJ7wlwnEYRa4wiix/NpkqLmTmCQWfFgANIuDg01AT2LHqkKQ
        bl4BN4lttyeygNgsAqoS1/ecZAWxRQUiJM68X8ECUSMocXLmEzCbU8BeYvOUKUwgNrOAmcS8
        zQ+ZIWxxiVtP5kPF5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYBxvO/Zz8w7GSxuDDzEKcDAq8fCu+Lk1Rog1say4MvcQowQHs5IIr2PKlhgh
        3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgemmLySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLp
        iSWp2ampBalFMH1MHJxSDYwT2PK7hVr0wx1K2Z6khlX11yVvy2nRDuB8tLJJ6r7AW0EmvSWb
        nnzTU4rexXR/kZfl2wIuT9Np0lNWPbUy0dnd6fMkTenXmepN5zsn8+YzMIvI2Tx13TR9suMD
        3R/zjl6b/fzIq3A1jjX93xPrnm+oucvQWu6+fuZB3ZO8b9J23OBc1OygM1+JpTgj0VCLuag4
        EQCpIeTc+QIAAA==
X-CMS-MailID: 20190417105059eucas1p10209319ab0c5d1f72ff804124767f9a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074832eucas1p26eca3ed8bf754787b4860206ba542e1c@eucas1p2.samsung.com>
        <1555487288-4777-2-git-send-email-l.luba@partner.samsung.com>
        <3fcb6dde-7ccc-4da6-5f8b-c8338edaa155@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 4/17/19 10:10 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
>> This patch add support of a new feature which can be used in DT:
>> Performance Monitoring Unit with defined event data type.
>> In this patch the event data types are defined for Exynos PPMU.
>> The patch also updates the MAINTAINERS file accordingly.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                           |  5 +++++
>>   include/dt-bindings/pmu/exynos_ppmu.h | 24 ++++++++++++++++++++++++
>>   2 files changed, 29 insertions(+)
>>   create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3671fde..f4aac78 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12376,6 +12376,11 @@ L:	linux-scsi@vger.kernel.org
>>   S:	Supported
>>   F:	drivers/scsi/pm8001/
>>   
>> +PMU EXYNOS DT BINDINGS
>> +M:	Lukasz Luba <l.luba@partner.samsung.com>
>> +S:	Maintained
>> +F:	include/dt-bindings/pmu/exynos_ppmu.h
>> +
> 
> IMHO, I'm not sure that it is right of adding one dt-binding header file
> to MAINTAINERS file. If right, I'm OK.
> 
> 
>>   PNP SUPPORT
>>   M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>   S:	Maintained
>> diff --git a/include/dt-bindings/pmu/exynos_ppmu.h b/include/dt-bindings/pmu/exynos_ppmu.h
>> new file mode 100644
>> index 0000000..a6971eb
>> --- /dev/null
>> +++ b/include/dt-bindings/pmu/exynos_ppmu.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Samsung Exynos PPMU event types for counting in regs
>> + *
>> + * Copyright (c) 2019, Samsung
>> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_PMU_EXYNOS_PPMU_H
>> +#define __DT_BINDINGS_PMU_EXYNOS_PPMU_H
>> +
>> +
>> +#define PPMU_RO_BUSY_CYCLE_CNT		0x0
>> +#define PPMU_WO_BUSY_CYCLE_CNT		0x1
>> +#define PPMU_RW_BUSY_CYCLE_CNT		0x2
>> +#define PPMU_RO_REQUEST_CNT		0x3
>> +#define PPMU_WO_REQUEST_CNT		0x4
>> +#define PPMU_RO_DATA_CNT		0x5
>> +#define PPMU_WO_DATA_CNT		0x6
>> +#define PPMU_RO_LATENCY			0x12
>> +#define PPMU_WO_LATENCY			0x16
>> +#define PPMU_V2_EVT3_RW_DATA_CNT	0x22
> 
> If we can select the data type for monitoring, it looks good to me.
> But, when I developed the Exynos PPMU, I has not tested other data type
> except for PPMU_RO_DATA_CNT and PPMU_WO_DATA_CNT.
> 
> Do you test all data types with PPMU device?
Yes, I have tested all - 1 of them on Odroid XU4 with memory controller
and they work. I haven't checked the last option for Exynos5433,
but it should work since it was default option in your driver.

Regards,
Lukasz
> 
>> +
>> +#endif
>>
> 
> 
