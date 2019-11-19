Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FB6C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F842222CD
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKSJKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:10:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54808 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbfKSJKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:10:47 -0500
Received: from wf0530.dip.tu-dresden.de ([141.76.182.18] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWzWz-0004FY-8i; Tue, 19 Nov 2019 10:10:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
Date:   Tue, 19 Nov 2019 10:10:40 +0100
Message-ID: <1847470.bs3PIdjKfZ@phil>
In-Reply-To: <1b9b8314-8778-2d48-6f7a-3502c2146c42@fivetechno.de>
References: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de> <1918981.kTmXGv9Lqf@phil> <1b9b8314-8778-2d48-6f7a-3502c2146c42@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 18. November 2019, 12:23:47 CET schrieb Markus Reichl:
> Add SDR104 capability and regulators to SD card node.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied (yesterday evening already)

Thanks
Heiko


