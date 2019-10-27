Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59436214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfJ0SWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:22:22 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58174 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfJ0SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:22:22 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOnBF-0008He-9y; Sun, 27 Oct 2019 19:22:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] arm64: dts: rockchip: enable gpu on rk3399-puma
Date:   Sun, 27 Oct 2019 19:22:02 +0100
Message-ID: <7251662.sC0l0EPzFi@phil>
In-Reply-To: <20191023223954.3139-1-heiko@sntech.de>
References: <20191023223954.3139-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Oktober 2019, 00:39:54 CET schrieb Heiko Stuebner:
> Set the supplying regulator and enable the gpu node on the rk3399-puma som.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 5.5


