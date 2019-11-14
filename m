Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817C7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A75206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfKNJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:32:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:59846 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfKNJc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:32:56 -0500
Received: from wf0530.dip.tu-dresden.de ([141.76.182.18] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iVBUf-0001Pj-Hv; Thu, 14 Nov 2019 10:32:49 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add node for gpu on rk3399-roc-pc
Date:   Thu, 14 Nov 2019 10:32:48 +0100
Message-ID: <1669035.FjvuzNSCd2@phil>
In-Reply-To: <c2b88509-129d-46d4-9e23-15d0482951be@fivetechno.de>
References: <c2b88509-129d-46d4-9e23-15d0482951be@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. November 2019, 16:38:26 CET schrieb Markus Reichl:
> rk3399-roc-pc has a Mali gpu, enable it for use with panfrost and mesa >19.2.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
> Based on v5.5-armsoc/dts64/75aa5678
> If applied with other patches in between, the second hunk
> offsets and may patch vdd_cpu_b instead of vdd_gpu.

applied for 5.6 (probably) and made sure vdd_gpu got its regulator-always-on
removed, not vdd_cpu_b :-)

Thanks
Heiko


