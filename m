Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6646FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368F8206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ws1ObVni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDZHui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:50:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60312 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfDZHuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:50:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3Q7oUiN108277;
        Fri, 26 Apr 2019 02:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556265030;
        bh=isa+lVye5iESSUHdmV4X0RQwaweSxh690t7x5lg54yk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ws1ObVniiTcLCQn7xDLe3VPLaxwKhjOrOyL6XOSnz13V02CMET3PuRZnud40R22fa
         O1OKmXh5eovhT2+QdseotbrX2KCnm4jyaahClpvN8mjDqdHY2GqIBgevipUDyDrAtX
         FiNW2O3wyZsb9I9Bwd8aVrKgM4sWpByKVTCxspuU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3Q7oUpw120486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 02:50:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 02:50:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 02:50:30 -0500
Received: from [172.22.140.253] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3Q7oQTl104377;
        Fri, 26 Apr 2019 02:50:26 -0500
Subject: Re: [RFC PATCH v3 net-next 06/11] dt-bindings: net: ti: add new cpsw
 switch driver bindings
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-7-git-send-email-grygorii.strashko@ti.com>
 <20190425224021.GA4041@lunn.ch>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <4dc2a645-4769-e873-d5d3-b6ef74367ca3@ti.com>
Date:   Fri, 26 Apr 2019 10:50:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190425224021.GA4041@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.04.19 01:40, Andrew Lunn wrote:
>> +Required Sub-nodes:
>> +- ports	: contains CPSW external ports descriptions
>> +	Required properties:
>> +	- #address-cells : Must be 1
>> +	- #size-cells : Must be 0
>> +	- reg : CPSW port number. Should be 1 or 2
>> +	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
>> +	- phy-mode : operation mode of the PHY interface [1]
>> +	- phy-handle : phandle to a PHY on an MDIO bus [1]
> 
> 
>> +		cpsw_port1: port@1 {
>> +			reg = <1>;
>> +			ti,label = "port1";
>> +			/* Filled in by U-Boot */
>> +			mac-address = [ 00 00 00 00 00 00 ];
>> +			phys = <&phy_gmii_sel 1>;
> 
> Hi Grygorii
> 
> phy-mode and phy-handle are required, but missing from your example.
> 
> Otherwise, this looks like a reasonable binding.

Yea. they configured in board files - will add.

Thanks. 

-- 
Best regards,
grygorii
