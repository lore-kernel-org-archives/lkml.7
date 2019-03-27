Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588D12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 12:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfC0MTm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:19:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46324 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfC0MTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 08:19:41 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h97Wr-0003Tt-K0; Wed, 27 Mar 2019 13:19:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Alexis Ballier <aballier@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: dts: rockchip: Add bindings for rk3288-veyron-mighty
Date:   Wed, 27 Mar 2019 13:19:36 +0100
Message-ID: <1915099.lzZODYNdzv@phil>
In-Reply-To: <20190325162005.99391-1-dianders@chromium.org>
References: <20190325162005.99391-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 25. März 2019, 17:20:04 CET schrieb Douglas Anderson:
> Mighty is basically the same Chromebook as Jaq but it has a full-sized
> SD slot and some different (slightly more rugged) plastics around it.
> Like Jaq, Mighty may show up with various different brandings but all
> of them have the same board inside.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

applied both patches for 5.2

Thanks
Heiko


