Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6EF4214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfCLIw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:52:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57716 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfCLIw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:52:57 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3d9Y-0000bg-FP; Tue, 12 Mar 2019 09:52:52 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Date:   Tue, 12 Mar 2019 09:52:51 +0100
Message-ID: <3482373.0PG0Fu4BEl@phil>
In-Reply-To: <AM3PR03MB0966C52CCF14FCEDE6615265AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <AM3PR03MB0966C52CCF14FCEDE6615265AC790@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 24. Februar 2019, 22:51:22 CET schrieb Jonas Karlman:
> The following error can be seen during boot:
> 
>   of: /cpus/cpu@501: Couldn't find opp node
> 
> Change cpu nodes to use operating-points-v2 in order to fix this.
> 
> Fixes: ce76de984649 ("ARM: dts: rockchip: convert rk3288 to operating-points-v2")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

added a Cc-stable tag and applied as fix for 5.1

Thanks for catching this
Heiko


