Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE86CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3FF21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfHVTgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:36:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732922AbfHVTgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:36:48 -0400
Received: from wsip-184-188-36-2.sd.sd.cox.net ([184.188.36.2] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i0ssy-0001tD-FK; Thu, 22 Aug 2019 21:36:40 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-rockchip@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: rockchip: remove rk3288 fennec board support
Date:   Thu, 22 Aug 2019 21:36:35 +0200
Message-ID: <9055349.xFmPUmBtRx@phil>
In-Reply-To: <20190821031124.17806-1-kever.yang@rock-chips.com>
References: <20190821031124.17806-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. August 2019, 05:11:23 CEST schrieb Kever Yang:
> Since there is no one using this board, remove it.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

applied both patches for 5.4

Thanks
Heiko


