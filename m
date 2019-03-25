Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16995C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BF72085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfCYMeq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:34:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52402 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730603AbfCYMeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:34:46 -0400
Received: from [94.134.91.136] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h8OoK-0006p3-Mj; Mon, 25 Mar 2019 13:34:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rk3399 UART DMAs
Date:   Mon, 25 Mar 2019 13:34:39 +0100
Message-ID: <8309531.dRdlsDmmhi@phil>
In-Reply-To: <20190321162244.10080-1-katsuhiro@katsuster.net>
References: <20190321162244.10080-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 21. März 2019, 17:22:44 CET schrieb Katsuhiro Suzuki:
> Add UART dma channels as specified by the rk3399 TRM.
> 
> Refer:
> RK3399 TRM V1.4: Chapter 12 DMA Controller
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.2

Thanks
Heiko


