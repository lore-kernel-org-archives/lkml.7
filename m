Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDBECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0413321721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VYcWVAND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJIJ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:56:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51150 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfJIJ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:56:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x999uYfE051750;
        Wed, 9 Oct 2019 04:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570614994;
        bh=hJk1QqWDxBHr549Ey1KHH9as6OvUiWG5ahTGSI2IUBw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VYcWVANDFQ1nxQtSs3/YpAlV00C0bShS2xPdsfd7yp6ECQ/wnvpe5FNh9bUDrETmd
         rUd9zmGgOcmJNanqN51f5jsmpsS8a3krb9+1jYezhRRtC6LpTyP8P6r+jlNNBKo0wU
         SCvf5ks1k/oWOB609ML8KI66VMxw0avoRwil8S1k=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x999uY4T038772;
        Wed, 9 Oct 2019 04:56:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 04:56:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 04:56:31 -0500
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x999uVjm033887;
        Wed, 9 Oct 2019 04:56:32 -0500
Subject: Re: [PATCH 0/2] Add Support for MMC/SD for J721e-base-board
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <nm@ti.com>, <robh+dt@kernel.org>,
        <t-kristo@ti.com>
References: <20190919153242.29399-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <f176e389-d181-8848-2bce-6680232b8fa8@ti.com>
Date:   Wed, 9 Oct 2019 15:27:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919153242.29399-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/09/19 9:02 PM, Faiz Abbas wrote:
> The following are dts patches to add MMC/SD Support on TI's J721e base
> board.
> 
> Patches depend on Lokesh's gpio patches[1] and device exclusivity patches[2].
> 
> [1] https://patchwork.kernel.org/cover/11085643/
> [2] https://patchwork.kernel.org/cover/11051559/
> 
> Faiz Abbas (2):
>   arm64: dts: ti: j721e-main: Add SDHCI nodes
>   arm64: dts: ti: j721e-common-proc-board: Add Support for eMMC and SD
>     card
> 
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 34 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 50 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 

Gentle ping.

Thanks,
Faiz
