Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E26B2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 04:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b9kRdjcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDLEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 00:25:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfDLEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 00:25:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3C4OogU058957;
        Thu, 11 Apr 2019 23:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555043090;
        bh=/0sZ2RicNhWCzerJZaLD6qmiE5+jzq8gEGtTEtBba+M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=b9kRdjcCSwfRWDn/8w27Kfvi6IVy+l7skInFL10FGS+d6TAGgLfPHcPJ3sNpbYz7z
         iGm/qIYB+kXurBZ5hxJGn8HPkLr64vLfNxMnjMW3+6oIPh8lScFT/qjdf2BeKdqN0P
         2amQ5DVVKBeuFo/SeHAczGdiuSqxtRA/rVNedfZo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3C4OomV103770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 23:24:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 23:24:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 23:24:50 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3C4Ojtt110268;
        Thu, 11 Apr 2019 23:24:46 -0500
Subject: Re: [PATCH v6 06/12] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20190410041358.16809-1-lokeshvutla@ti.com>
 <20190410041358.16809-7-lokeshvutla@ti.com>
 <20190411150023.GQ2839@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <9cd4b818-905c-08a4-5675-a5ee763cea98@ti.com>
Date:   Fri, 12 Apr 2019 09:54:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190411150023.GQ2839@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/19 8:30 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [190410 04:15]:
>> +Example:
>> +--------
>> +The following example demonstrates both interrupt router node and the consumer
>> +node(main gpio) on the AM654 SoC:
>> +
>> +main_intr: interrupt-controller0 {
>> +	compatible = "ti,sci-intr";
>> +	ti,intr-trigger-type = <1>;
>> +	interrupt-controller;
>> +	interrupt-parent = <&gic500>;
>> +	#interrupt-cells = <3>;
>> +	ti,sci = <&dmsc>;
>> +	ti,sci-dst-id = <56>;
>> +	ti,sci-rm-range-girq = <0x1>;
>> +};
> 
> To me it seems there should not be too many of these interrupt
> controller nodes for each SoC. Maybe you're already planning on
> doing it, but I suggest that you just add more specific compatibles
> and then look up the dst-id from a mapping table in the driver
> similar to what patch 04/12 in this series is already doing.
> 
> That way you don't need to add custom TI specific (firmware
> defined) device tree properties listed above ;)

I am tired of arguing on this. We did close this topic in the previous version
of this series. Why do you want to keep re visiting the same. Sorry, I am not
going change unless I receive a Nack from Marc or Rob.

Thanks and regards,
Lokesh
