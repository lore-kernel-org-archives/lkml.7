Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1CBC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B92C218AE
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JcMGlmRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDFKKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 06:10:47 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52560 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 06:10:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x36AAhqt099260;
        Sat, 6 Apr 2019 05:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554545443;
        bh=KnCtIU5Fe5TY1GZ+TJUK9AeqVXHkEAtPFqF0r1QdvHs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JcMGlmROY7bi9kcS5/BY9fNeeDpWW2oUmTRt7p5wY2kq3LCk75xvhKA39yPXhUrga
         G4cJHU334xMcfY72KjyhBLjsoA+QoTYJ5NDnKl7D4pxZOM/ayU7qTUXe+oPLVOHW20
         zWN0ToiAs3enVBqTFJGyJNxvB/tNkHWpiYt6d/sE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x36AAhGu020982
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 6 Apr 2019 05:10:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 6 Apr
 2019 05:10:43 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 6 Apr 2019 05:10:43 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x36AAeVm126846;
        Sat, 6 Apr 2019 05:10:41 -0500
Subject: Re: [PATCH 2/2] ARM: dts: dra7: Separate AM57 dtsi files
To:     Roger Quadros <rogerq@ti.com>, <tony@atomide.com>
CC:     <robh+dt@kernel.org>, <s-anna@ti.com>, <nm@ti.com>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190405132806.20772-3-rogerq@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <0e1de55a-7333-7940-6965-8080d9fb0b14@ti.com>
Date:   Sat, 6 Apr 2019 15:40:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190405132806.20772-3-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/04/19 6:58 PM, Roger Quadros wrote:
> AM5 and DRA7 SoC families have different set of modules
> in them so the SoC sepecific dtsi files need to be separated.
> 
> e.g. Some of the major differences between AM576 and DRA76
> 
> 		DRA76x	AM576x
> 
> USB3		x
> USB4		x
> ATL		x
> VCP		x
> MLB		x
> ISS		x
> PRU-ICSS1		x
> PRU-ICSS2		x
> 
> This patch only deals with disabling USB3, USB4 and ATL for
> AM57 variants.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

