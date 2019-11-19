Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F6EC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4142245C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 20:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pojpkqbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKSUk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 15:40:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSUk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 15:40:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAJKemnp003319;
        Tue, 19 Nov 2019 14:40:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574196048;
        bh=BZMZhIOhih6YWB34NAzn3mDl5RjnHoAwoyYhzzDXlMM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pojpkqbdgJivQrnErcOzv/20vn8gRtjnv0zV6pa0n10JWMQsJn6uUYJXgErIv0nFC
         59xX2J5VFE/RZ//QXSjV0E/V6aRid6Td62yLdIN3rKm1MP+XeHLpPlHivX6r/NCiP+
         37UngNfXN8XM4xOTdXQpK5jQD0z4wL3i53FvyLJo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAJKemcF077835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Nov 2019 14:40:48 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 19
 Nov 2019 14:40:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 19 Nov 2019 14:40:47 -0600
Received: from [10.250.45.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAJKekhh012907;
        Tue, 19 Nov 2019 14:40:46 -0600
Subject: Re: [PATCH 0/1] ARM: dts: am5729: beaglebone-ai: enable board
To:     Caleb Robey <c-robey@ti.com>, <linux-omap@vger.kernel.org>
CC:     Jason Kridner <jkridner@gmail.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191119202850.18149-1-c-robey@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a117b152-8fcb-01a8-5a53-2cb615e87111@ti.com>
Date:   Tue, 19 Nov 2019 15:40:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191119202850.18149-1-c-robey@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 3:28 PM, Caleb Robey wrote:
> The following patch adds the device tree file for BeagleBone AI
>  


Cover-letter for a single patch is probably not needed, especially when
you don't add anything useful in the cover letter.

Andrew


> Caleb Robey (1):
>   ARM: dts: am5729: beaglebone-ai: adding device tree
> 
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/am5729-beagleboneai.dts | 782 ++++++++++++++++++++++
>  2 files changed, 783 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am5729-beagleboneai.dts
> 
