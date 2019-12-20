Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1D5C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11C2467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UAzsxaea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTLut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:50:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50486 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:50:48 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKBoYQM012834;
        Fri, 20 Dec 2019 05:50:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576842634;
        bh=F5NzVoBOc0H3AQcimqUogeBFtzoUavarjXQ1aoFfC+w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UAzsxaeaHZa/6OX3d/fo2uAFhLLjO25PaTZG0YDWhMMaGMH8rWWv2O57BRHwOpUVh
         jQDc/OO/rXAXHSTHRlez4SQRqn+b+T7pNdCF3LGEdy8bvbRKJ0qdQvjIGky9milvMu
         vpfzhb3uZC1jmi57D40RpZ5qWbFHJ9XGlyFHix+A=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKBoX41111098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 05:50:34 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 05:50:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 05:50:33 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKBoUCE033381;
        Fri, 20 Dec 2019 05:50:31 -0600
Subject: Re: [PATCH RESEND 1/2] dt-bindings: phy: drop #clock-cells from
 rockchip,px30-dsi-dphy
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
CC:     Rob Herring <robh@kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20191216122448.27867-1-heiko@sntech.de>
 <12525836.FhlgEYrHGb@diego> <45c59145-5705-90f9-ff0e-c84cf8d17e8b@ti.com>
 <3795174.JdKOkfR0EK@diego>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <400d28a9-6ae3-5ff3-8d95-005714cfca33@ti.com>
Date:   Fri, 20 Dec 2019 17:22:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3795174.JdKOkfR0EK@diego>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/12/19 5:07 pm, Heiko Stübner wrote:
> Hi Kishon,
> 
> Am Freitag, 20. Dezember 2019, 12:21:28 CET schrieb Kishon Vijay Abraham I:
>>
>> On 16/12/19 11:31 pm, Heiko Stübner wrote:
>>> Hi Rob,
>>>
>>> Am Montag, 16. Dezember 2019, 18:56:15 CET schrieb Rob Herring:
>>>> On Mon, 16 Dec 2019 13:24:47 +0100, Heiko Stuebner wrote:
>>>>> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>>>>>
>>>>> Further review of the dsi components for the px30 revealed that the
>>>>> phy shouldn't expose the pll as clock but instead handle settings
>>>>> via phy parameters.
>>>>>
>>>>> As the phy binding is new and not used anywhere yet, just drop them
>>>>> so they don't get used.
>>>>>
>>>>> Fixes: 3817c7961179 ("dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy")
>>>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>>>>> ---
>>>>> Hi Kishon,
>>>>>
>>>>> maybe suitable as a fix for 5.5-rc?
>>>>>
>>>>> Thanks
>>>>> Heiko
>>>>>
>>>>>  .../devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      | 5 -----
>>>>>  1 file changed, 5 deletions(-)
>>>>>
>>>>
>>>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>>>> there's no need to repost patches *only* to add the tags. The upstream
>>>> maintainer will do that for acks received on the version they apply.
>>>>
>>>> If a tag was not added on purpose, please state why and what changed.
>>>
>>> sorry about that. The original response somehow did not thread correctly
>>> in my mail client, probably some fault on my side, so I've only found your
>>> mail just now by digging hard.
>>>
>>> @Kishon, the original mail already got an
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> merged now, Thanks!
> 
> thanks ... just to make sure, did you also see the driver changes in patch2?
> As I don't see them in either of your branches :-)

For some reason, patch 2 of the "RESEND" series is not in my inbox.
However looking at your original series, looks like this is a candidate
for 5.6. I'll take patch 2 from your original series.

Thanks
Kishon
