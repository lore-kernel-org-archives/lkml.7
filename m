Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D7BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8038218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J6/Ev2dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbfDRJur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:50:47 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33853 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388451AbfDRJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:50:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190418095045euoutp01c8e5d07d79eac374895d81b7911c196a~WiLf27Vll0640506405euoutp01-
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 09:50:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190418095045euoutp01c8e5d07d79eac374895d81b7911c196a~WiLf27Vll0640506405euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555581045;
        bh=XlqFo64OpA4M2BnDSdVN7DWkiQzakanWPd1XvuFCBlk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=J6/Ev2dw+oo8ma+fMGq14Rd/DgWGrFnStRDcUMfxLP/yajwM6iHkD3p4wkX+EMm4p
         FztUmuZtw57vJ471sriJglu2PJSDVXV7hjh6Wbockg+FZmrgo3fUmjvbrqJCO5vMDq
         wjk8+5lZLyqRnd7/qSi4eqN+RWyhGEKB5IvAL+pk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190418095044eucas1p27932d434c588c36df892d573a09524eb~WiLfLL1Rz2827628276eucas1p22;
        Thu, 18 Apr 2019 09:50:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DF.F1.04325.37848BC5; Thu, 18
        Apr 2019 10:50:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190418095043eucas1p25a9c84f12fd8edfe1748f70257e604ff~WiLeapQ6w2825328253eucas1p2u;
        Thu, 18 Apr 2019 09:50:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190418095043eusmtrp13e1c4a44f49ebb6a722bbb637b8834bc~WiLeMWs5T2722127221eusmtrp1A;
        Thu, 18 Apr 2019 09:50:43 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-83-5cb84873ac21
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.C8.04146.37848BC5; Thu, 18
        Apr 2019 10:50:43 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190418095042eusmtip2f5294e9e1fee167a3306b1b372d77a1b~WiLdhyoH83051630516eusmtip23;
        Thu, 18 Apr 2019 09:50:42 +0000 (GMT)
Subject: Re: [PATCH 3/3] Documentation: devicetree: add PPMU events
 description
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, kgene@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ec6c7ce1-ee13-6921-2656-8a027c3c0686@partner.samsung.com>
Date:   Thu, 18 Apr 2019 11:50:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d867843-ec56-f30b-8a3f-b3172f325bef@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3bO2Y7D2XFqvpglLcSM1C5SB7JSsFoUXSm8QU49qOR1R811
        IU3KNC9dzHRqVijaMDSdOgUldDrMbIp5y2yWlpFJhVsUhNXpKPnf73m+5/2+94GPxKRGwomM
        jktilHGKGJlQjDd1/3zhwcp1IZt/fvOhnxTVEvSIeYagy/UvCDp/ahajjcY6Ed13+bOIrp8a
        JujB1lIhPZ+rR3SRsV1AP9ZPiOjKkQEBPZ5eLaSvtOlFdOfnTMJ3pbzmXg2S12uyhPKGikvy
        PK0Gyefr1x4lgsQ+EUxMdAqj9NodKo6afNQsTKi0Ta3qVQvSULpNNrIigfKGFss7PBuJSSlV
        jaBy8sOiMCPIK9ULuJSUmkcw89tlacJs6l8MVSHoGc7CeDGHoFSv/TtBknbUMWgzXuJ8e6oH
        QW76BMEJjHqJ4L35IcaFhJQn6DSJ3K0Sah809T3FOMYpV6g0jeIcO1ABYOquI/iMLfQUT//z
        rag90DdRgDjGKEd4NV0u4NkFMhpLMH5Tiwh+lATy7A8ZN7sInu3gk0Er4tkZem/n4DyzkJb7
        APF8AabyyxYzO6HTMEBwK2OUO9S2evG2H3wZy8Q5GygbGJ2z5TewgVtNdzHelsC1q1I+vQG0
        Of0CnldBVU2h6AaSqZf1Ui/rol7WRf3/3fsI1yBHJpmNjWTYbXHMWU9WEcsmx0V6hsfH1qO/
        36x3wWDRofZfYR2IIpHMWlLt2hwiJRQprCq2AwGJyewlfhHaEKkkQqE6xyjjTyuTYxi2A60m
        cZmj5PyKyWApFalIYs4wTAKjXDoVkFZOaWj41BvZxO/rVi0H6vAVidlubsyakzE3bSzPV5Yp
        3gZ7DzfuvxPW9uOaa2nQx71g7XB2vWpXVH5qokveCdOQee54RVkJLZcbBq//ci7+PqSyrOnc
        Md7oMasr3P4sYYzc5B9w6PXFBlV+uNh0cK/wiGZriso9MK1g92GXr+u6fL1CFxxlOBul2LIR
        U7KKP9vgkNdiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsVy+t/xe7rFHjtiDH78Z7PYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht9j0+BqrxeVdc9gsPvceYbSYcX4fk8XaI3fZLZZev8hk
        cbtxBZtF694j7BaH37SzOvB7rJm3htFj06pONo/NS+o9+rasYvT4vEkugDVKz6Yov7QkVSEj
        v7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+PByu1sBUsFK5afnsXU
        wNjI18XIySEhYCLx5f4Fli5GLg4hgaWMElOPvWKGSIhJTNq3nR3CFpb4c62LDaLoNaPEvElL
        gRwODmGBQIm95+tB4iICJxklZk/4ywTiMAtcYZRYfm0yK0THJCaJdXMXMIF0sAnoSexYVQgy
        lVfATWLb2QNg21gEVCWW3r/BAmKLCkRInHm/ggWiRlDi5MwnYDangL3E2btTGEFsZgEziXmb
        HzJD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYBRvO/Zz8w7GSxuDDzEKcDAq8fCuUN0eI8SaWFZcmXuIUYKDWUmE1zFlS4wQ
        b0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMTTF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0
        xJLU7NTUgtQimD4mDk6pBsa5DoG2EnwXS9XCCpZ6zlfqynUwZDx9U+/vt+QHMx0iq+x4Vb58
        UVSbd+VqQqjjip9nNAKnBT5I7HiX+fC8WeeT3Y+uCTxeJn6sMykiN4g988m+Y2LFW+q/vJ0a
        PD9h+p2fwf1+R50YVOVsf8SzVb9e/PLAweJVb29Hz05atSa6YVpi8mq1qUeUWIozEg21mIuK
        EwGgt0o3+AIAAA==
X-CMS-MailID: 20190418095043eucas1p25a9c84f12fd8edfe1748f70257e604ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190417074835eucas1p19319bedd176d55e10b272881b7c68919
References: <1555487288-4777-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190417074835eucas1p19319bedd176d55e10b272881b7c68919@eucas1p1.samsung.com>
        <1555487288-4777-4-git-send-email-l.luba@partner.samsung.com>
        <0d867843-ec56-f30b-8a3f-b3172f325bef@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 4/17/19 10:26 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 4. 17. 오후 4:48, Lukasz Luba wrote:
>> Extend the documenation by events description with new 'event-data-type'
>> field. Add example how the event might be defined in DT.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index 3e36c1d..47feb5f 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>>   			reg = <0x104d0000 0x2000>;
>>   			status = "disabled";
>>   		};
>> +
>> +The 'event' type specified in the PPMU node defines 'event-name'
>> +which also contains 'id' number and optionally 'event-data-type'.
>> +
>> +Example:
>> +
>> +		events {
>> +			ppmu_leftbus_0: ppmu-event0-leftbus {
>> +				event-name = "ppmu-event0-leftbus";
>> +				event-data-type = <PPMU_RO_DATA_CNT>;
>> +			};
>> +		};
>> +
>> +The 'event-data-type' defines the type of data which shell be counted
>> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
> 
> I replied about 'pmu' name on patch2. Please check it.
Yes, I've seen it and responded.
> 
>> +all possible type, i.e. count read requests, count write data in bytes,
>> +etc. This field is optional and when it is missing, the driver code will
>> +use default data type.
>>
> Looks good to me.
> But, If you want to add the new 'event-data-type' property,
> you better to add 'event-data-type' to Exynos dts file including
> PPMU device.
> 
> If the dts file contain the data type information,
> I think it is easy to understand for the user
> what is monitoring on PPMU device.

Make sense, I will do that. It will be explicitly telling the user what
is currently monitored in the PPMU device event.

Regards,
Lukasz
> 
> 
