Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF28DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909EE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MX94Lin5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfFQPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:01:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41282 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfFQPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:01:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5HF0uN3122514;
        Mon, 17 Jun 2019 10:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560783656;
        bh=aubl2oHp92o7mM/SXfatWCDIGIQjf/qgeP0RChTXmVE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=MX94Lin5sGkgV5GaUoyy6DYg8+HpW0GksFneqyolWatjDgsbS8ZThp/KiMpJFMpI8
         ldekZ2osUclPfFoQ/rb8la/1egvEYE/yYhT9B6G2AcG7scUi3tmMgKLE/Rm04lNICs
         2eZMXRVGW6EV7UgctlcSpF2xa6RKdHMSmJylBJZs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5HF0uLc062532
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jun 2019 10:00:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 17
 Jun 2019 10:00:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 17 Jun 2019 10:00:55 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5HF0qSa022800;
        Mon, 17 Jun 2019 10:00:53 -0500
Subject: Re: [PATCH 0/6] AM654: Add PCIe and SERDES DT nodes
To:     Kishon Vijay Abraham I <kishon@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190529091812.20764-1-kishon@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <9e03c24e-4ca7-5ba5-a8d4-a95b2b6579f1@ti.com>
Date:   Mon, 17 Jun 2019 18:00:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529091812.20764-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2019 12:18, Kishon Vijay Abraham I wrote:
> Patch series adds PCIe and SERDES DT nodes to k3-am65.dtsi and keeps
> them disabled in k3-am654-base-board.dts since there are no PCIe
> slots in the base board.
> 
> PCIe slots are actually present in add on boards. Once overlay support
> is merged, I'll add overlay DTS files to enable PCIe.
> 
> All the driver patches and binding documentation patches for PCIe and
> SERDES are already merged.

Queued up towards 5.3, thanks.

-Tero

> 
> Kishon Vijay Abraham I (6):
>    arm64: dts: k3-am6: Add "socionext,synquacer-pre-its" property to
>      gic_its
>    arm64: dts: k3-am6: Add mux-controller DT node required for muxing
>      SERDES
>    arm64: dts: k3-am6: Add SERDES DT node
>    arm64: dts: k3-am6: Add PCIe Root Complex DT node
>    arm64: dts: k3-am6: Add PCIe Endpoint DT node
>    arm64: dts: ti: am654-base-board: Disable SERDES and PCIe
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 128 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am65.dtsi           |   1 +
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts |  24 ++++
>   3 files changed, 153 insertions(+)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
