Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E92CCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0162080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a0LsMdpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfJaNDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:03:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55974 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaNDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:03:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9VD31nq124895;
        Thu, 31 Oct 2019 08:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572526981;
        bh=jpBAUypS3kMb2gSVD1QCfzFnqXx0fy8eb1N5e+Nc4iA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a0LsMdptZsrjHDm1mZ0BzdowBnneVMP6qD29KVAZrqbc+8mdtxb0BhGo8E8Bjys2S
         zc7G+aoD4Ri6Hf7EBW7CcG3cQz62c9jN4uXqqVip5hJA3saxTs5/zk7vtD4+ZJNFAA
         fvA9es4/97k69F7m43YRxQxXwikkj7kS8K578jtU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9VD30QB048254
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Oct 2019 08:03:00 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 31
 Oct 2019 08:02:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 31 Oct 2019 08:02:47 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9VD2vCC063280;
        Thu, 31 Oct 2019 08:02:58 -0500
Subject: Re: [PATCH] phy: phy-rockchip-inno-usb2: add phy description for px30
To:     Heiko Stuebner <heiko@sntech.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rockchip@lists.infradead.org>,
        <christoph.muellner@theobroma-systems.com>
References: <20190917082532.25479-1-heiko@sntech.de> <1974613.gpRaQal8Ma@phil>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1b31d4fe-fd78-700a-6e53-298bd85d7a27@ti.com>
Date:   Thu, 31 Oct 2019 18:32:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1974613.gpRaQal8Ma@phil>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/10/19 5:38 PM, Heiko Stuebner wrote:
> Hi Kishon,
> 
> Am Dienstag, 17. September 2019, 10:25:32 CET schrieb Heiko Stuebner:
>> The px30 soc from Rockchip shares the same register description as
>> the rk3328, so can re-use its definitions.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> could you pick this up as well please?

merged now, thanks.

-Kishon
> 
> Thanks
> Heiko
> 
>> ---
>>  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 1 +
>>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c                    | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> index 00639baae74a..541f5298827c 100644
>> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>> @@ -2,6 +2,7 @@ ROCKCHIP USB2.0 PHY WITH INNO IP BLOCK
>>  
>>  Required properties (phy (parent) node):
>>   - compatible : should be one of the listed compatibles:
>> +	* "rockchip,px30-usb2phy"
>>  	* "rockchip,rk3228-usb2phy"
>>  	* "rockchip,rk3328-usb2phy"
>>  	* "rockchip,rk3366-usb2phy"
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index eae865ff312c..680cc0c8825c 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -1423,6 +1423,7 @@ static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
>>  };
>>  
>>  static const struct of_device_id rockchip_usb2phy_dt_match[] = {
>> +	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
>>  	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
>>  	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
>>  	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
>>
> 
> 
> 
> 
