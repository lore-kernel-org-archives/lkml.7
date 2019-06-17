Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92991C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B56F208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NARiwjCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfFQPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:47:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57850 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbfFQPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:47:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5HFlN1h043664;
        Mon, 17 Jun 2019 10:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560786443;
        bh=UqzhKdCvFhtNpUr5vFdw+6v6fHvR90i1hNildl+b+9s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=NARiwjCy3syAuulADRz6Lykk68iTE2lZIoiDk6E7W9V7Qg6HXFhTxbv7P1oKTAtck
         3tI0r1c1eIGH2sQB8SEDbhDNHg9dHsxFTjeNc6Z9FgDqtpIYcjEAu3S2dRl6jv2dAR
         eM83QjPhhrGrtcUUm2A8t4+2mjIk2vFODDkLvnzs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5HFlNfw076253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Jun 2019 10:47:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 17
 Jun 2019 10:47:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 17 Jun 2019 10:47:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5HFlMXS023695;
        Mon, 17 Jun 2019 10:47:22 -0500
Date:   Mon, 17 Jun 2019 10:46:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: arm: ti: Add bindings for J721E SoC
Message-ID: <20190617154614.wlbh6dtj54brkt67@kahuna>
References: <20190522161921.20750-1-nm@ti.com>
 <20190522161921.20750-2-nm@ti.com>
 <20190614164526.GA14925@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190614164526.GA14925@bogus>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:45-20190614, Rob Herring wrote:
> On Wed, May 22, 2019 at 11:19:16AM -0500, Nishanth Menon wrote:
> > The J721E SoC belongs to the K3 Multicore SoC architecture platform,
> > providing advanced system integration to enable lower system costs
> > of automotive applications such as infotainment, cluster, premium
> > Audio, Gateway, industrial and a range of broad market applications.
> > This SoC is designed around reducing the system cost by eliminating
> > the need of an external system MCU and is targeted towards ASIL-B/C
> > certification/requirements in addition to allowing complex software
> > and system use-cases.
> > 
> > Some highlights of this SoC are:
> > * Dual Cortex-A72s in a single cluster, three clusters of lockstep
> >   capable dual Cortex-R5F MCUs, Deep-learning Matrix Multiply Accelerator(MMA),
> >   C7x floating point Vector DSP, Two C66x floating point DSPs.
> > * 3D GPU PowerVR Rogue 8XE GE8430
> > * Vision Processing Accelerator (VPAC) with image signal processor and Depth
> >   and Motion Processing Accelerator (DMPAC)
> > * Two Gigabit Industrial Communication Subsystems (ICSSG), each with dual
> >   PRUs and dual RTUs
> > * Two CSI2.0 4L RX plus one CSI2.0 4L TX, one eDP/DP, One DSI Tx, and
> >   up to two DPI interfaces.
> > * Integrated Ethernet switch supporting up to a total of 8 external ports in
> >   addition to legacy Ethernet switch of up to 2 ports.
> > * System MMU (SMMU) Version 3.0 and advanced virtualisation
> >   capabilities.
> > * Upto 4 PCIe-GEN3 controllers, 2 USB3.0 Dual-role device subsystems,
> >   16 MCANs, 12 McASP, eMMC and SD, UFS, OSPI/HyperBus memory controller, QSPI,
> >   I3C and I2C, eCAP/eQEP, eHRPWM, MLB among other peripherals.
> > * Two hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
> >   management.
> > * Configurable L3 Cache and IO-coherent architecture with high data throughput
> >   capable distributed DMA architecture under NAVSS
> > * Centralized System Controller for Security, Power, and Resource
> >   Management (DMSC)
> > 
> > See J721E Technical Reference Manual (SPRUIL1, May 2019)
> > for further details: http://www.ti.com/lit/pdf/spruil1
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Okay for now, but please convert K3 and other TI SoCs to schema soon.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>


Thanks Rob. Will do the change to rst soon (hopefully post in the 5.3 window).
-- 
Regards,
Nishanth Menon
