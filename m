Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94FC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73FC21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oU5zQVfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgAFFtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:49:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51506 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgAFFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:49:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0065nD1d081324;
        Sun, 5 Jan 2020 23:49:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578289753;
        bh=R3i1Mbg4typ+Pc2UOirvRsZH9pZWmKV1X2eo8bAsA4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oU5zQVfiS9SSdzW4TUNv90U1pdkjLl5x4r5UBkg/hZeHCOLzscNGjt0EOMLcQfr0q
         sjvWMsXzeSu4vvRiMzxvhXDW8GDryZ+TjUwZeCT4X9gA1RaH6P3EG7NE1rKqMP6bNb
         XMETQqYbTs2YjSg2RaLlbLf0ePLYxhs/XtNH2hqM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0065nDLk106433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 5 Jan 2020 23:49:13 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 5 Jan
 2020 23:49:13 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 5 Jan 2020 23:49:13 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0065nAPa097986;
        Sun, 5 Jan 2020 23:49:11 -0600
Subject: Re: [PATCH v5 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper)
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191216095712.13266-14-kishon@ti.com>
 <20200102095631.1165-1-kishon@ti.com> <20200103223421.GA9017@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <769f6bdb-cc39-06fb-f7a3-3a6831d80f2d@ti.com>
Date:   Mon, 6 Jan 2020 11:21:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200103223421.GA9017@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/01/20 4:04 AM, Rob Herring wrote:
> On Thu, 2 Jan 2020 15:26:31 +0530, Kishon Vijay Abraham I wrote:
>> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
>> PHY but a wrapper used to configure some of the input signals to the
>> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>>  SERDES]
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>> Changes from v4:
>> *) Fixed the indentation as suggested by Rob v4
>>
>>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
>>  1 file changed, 204 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob!

-Kishon
