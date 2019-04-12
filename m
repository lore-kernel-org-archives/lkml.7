Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BCC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9EF21850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IYmOOA+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfDLA6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:58:38 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34191 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDLA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:58:37 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190412005834epoutp0168d6a8b7a4ccfd7487145e3bb34e0959~UlDI1ghUs2583725837epoutp013
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 00:58:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190412005834epoutp0168d6a8b7a4ccfd7487145e3bb34e0959~UlDI1ghUs2583725837epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555030714;
        bh=vKSoFW2zwZcUclRwrPJJfW0HdEH+OTQjHoyIwUvQqEw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IYmOOA+Vwn8hUIU/FoXLcDq6C1PL/2jbN42ZCM9SDjr7oo4So718dX4x1ONG4vY8f
         Zn0cD+/DLEt1gA2alhnWoqZUN/jJJfdULEFToz0jFUT/F7qRnIW2L8rw1cOMs1e6sL
         yJPliIhCh7Y7YzkvEYBHwsnIQwCcTIm9pZUO8iyM=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190412005832epcas1p2561040aa30b44a3535c05f5827a59eea~UlDGlpvM31678516785epcas1p2J;
        Fri, 12 Apr 2019 00:58:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.BF.04139.8B2EFAC5; Fri, 12 Apr 2019 09:58:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412005832epcas1p11b1351c142ccce92759a0959f95b37c0~UlDGT1Lm81541715417epcas1p1T;
        Fri, 12 Apr 2019 00:58:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412005831epsmtrp27023528758a8f6bf938a94301a2bb450~UlDGTE3rq0981909819epsmtrp2J;
        Fri, 12 Apr 2019 00:58:31 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-b7-5cafe2b8a007
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.37.03662.7B2EFAC5; Fri, 12 Apr 2019 09:58:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412005831epsmtip149f5a594696e24b3a28728553c66a956~UlDGLDQWs1973419734epsmtip12;
        Fri, 12 Apr 2019 00:58:31 +0000 (GMT)
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     myungjoo.ham@samsung.com, wens@csie.org, hdegoede@redhat.com,
        rjw@rjwysocki.net,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Organization: Samsung Electronics
Message-ID: <df1f3722-28a1-30eb-7dbf-e4d4586c9bc3@samsung.com>
Date:   Fri, 12 Apr 2019 09:59:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c11e2ae8-d785-902d-1469-4ff538ebe2ab@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+W2716nNfq7XyaLmjYoEbbe1usZmg6QGRQj5R5SmF71M2eOO
        3U3KCAojy9QeWqEWRWJvmKnFEnS1XmqWlkgP6YEZPYhZrdf+6HGv18j/Pr/zO99zzvf3O2ql
        tolMUhe7vJzHxTooMk519eYifWpg2J+j73+PmY93jymYs50HEDPQfpxkhnadI5nee48I5tTl
        YcREQ30KS4y1efgiYR3tHCStbYPlKmt12wVkjbTMySI22U1FHFvIeXScq4AvLHbZzNTaDXmr
        8ozL9HQqnc4sp3Qu1smZqcx1Wamrix3iGJSuhHX4xFAWKwjU4gyTh/d5OV0RL3jNFOcudLjT
        3WkC6xR8LltaAe9cQev1S4xiYr69KNxahdzRSVv91bXKnehGXAWKVQNeCk/6ekmJtTiAYORd
        bAWKE/kLgvbafTHy4TuCQPlB1T/F6boulXzRgeDhnheEfBhFUNV6TZSo1VNwNvzq1UkCEqdA
        8N0TUsqZivciGG0MEdKFEpugsb8HSTwZJ8Pgz9djrMEZcKL569hMKjwfztQOKiSehjfCyzvN
        hJyTCN11I2MTxeKVUNG3WyHXnAHPRk6O81wou9KglBoDjpBw++nRGNlCJkTLBgiZp8CHu23j
        8SSIhDtImbfD+e5bpCwWp24L9o8LDBBsqlFILpV4EfjbF8vNEiD8rZKQwoA1sHePVs6eBwOv
        nitkngmN5fvGy1uh4tcPdBAl10+wUz/BQv0EC/X/m51CqgtoOucWnDZOoN30xN9uQWMrmmIM
        oNoH60IIqxE1SXPO5M/REmyJsM0ZQqBWUlM12SoxpClkt5VyHj7P43NwQggZxdc+pEyaVsCL
        C+/y5tHGJQaDgVlKLzPSNDVD47esytFiG+vl7Bzn5jz/dAp1bNJOZCQfh8/wlU8/1/x+Yw+v
        Lu379P3Sl/1N+c7AkeKtpu5Ke9SQaA5mXvzxwVJl4l7M2vIx7dB6pmFBfFfuz8o1XZHsryOz
        c5OPP/R1ZJwFW1Z0B295GyxLyEyGE+U9B+LN82/Nul9a0pM+VP28WXs4fmieJe4N/2fzwrKZ
        kdbrRP4QpRKKWDpF6RHYvxsqWZC4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSnO72R+tjDM51W1m8OT6dyWL5vn5G
        i8u75rBZ3G5cwWZx5vQlVosFGx8xWvw8dJ7Jgd1jw6PVrB7v911l89hytZ3Fo2/LKkaPz5vk
        AlijuGxSUnMyy1KL9O0SuDLebe5lLPjJU7G+bwpzA+NBri5GTg4JAROJRTNPsHQxcnEICexm
        lPjQfIkFIiEpMe3iUeYuRg4gW1ji8OFiiJq3jBI7ulcxgsSFBUIk/p5RAClnE9CS2P/iBhtI
        jYhAB6PEomVX2UESzAI2EosvnGKEaP7CKNF+dj0zSIJfQFHi6o/HjCA2r4CdxNwNX9hAbBYB
        VYllU64ygdiiAhESZ96vYIGoEZQ4OfMJmM0pYC/Rdb6FCWKBusSfeZeYIWxxiVtP5kPF5SWa
        t85mnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw
        PGlp7WA8cSL+EKMAB6MSD+8Km/UxQqyJZcWVuYcYJTiYlUR4Q1iAQrwpiZVVqUX58UWlOanF
        hxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhjNH385p8+ZXGuU4RF4XqHr5esHnjP4
        447usT+5oCgtqTT41Quuy7Of/56ybe3r9wVcIirqHAcslvu/bpmqY9W1m8/pqLTBgdADbJs+
        zuzqKmj84H9+/nr5jndl81QDf2zakWATHHRb3y0tcuLVF8t3p+/RYl0qdsd81nrj6tkzFtm9
        vhJodldciaU4I9FQi7moOBEAvGUKiqMCAAA=
X-CMS-MailID: 20190412005832epcas1p11b1351c142ccce92759a0959f95b37c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190404142002epcas1p1a86f6d0d5d1a694581630a99532af633
References: <20190404104222.23900-1-yuehaibing@huawei.com>
        <CGME20190404142002epcas1p1a86f6d0d5d1a694581630a99532af633@epcas1p1.samsung.com>
        <20190404141748.27048-1-yuehaibing@huawei.com>
        <c11e2ae8-d785-902d-1469-4ff538ebe2ab@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
 
+ stable@vger.kernel.org 
 
It should be posted to stable@vger.kernel.org
in order to merge it to stable tree.
 
Regards,
Chanwoo Choi


On 19. 4. 12. 오전 8:30, Chanwoo Choi wrote:
> On 19. 4. 4. 오후 11:17, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> As Hans de Goede pointed, using this driver without ACPI
>> makes little sense, so add ACPI dependency to Kconfig entry
>> to fix a build error while CONFIG_ACPI is not set.
>>
>> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
>> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>>     put_device(&adev->dev);
>>
>> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>> v2: rework patch
>> ---
>>  drivers/extcon/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 1ed4b45..de06faf 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>>  
>>  config EXTCON_AXP288
>>  	tristate "X-Power AXP288 EXTCON support"
>> -	depends on MFD_AXP20X && USB_SUPPORT && X86
>> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>>  	select USB_ROLE_SWITCH
>>  	help
>>  	  Say Y here to enable support for USB peripheral detection
>>
> 
> Applied it. Thanks.
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
