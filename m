Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EFFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D86218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 19:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCPTps convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 15:45:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40922 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPTps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 15:45:48 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h5FFX-0000Xt-63; Sat, 16 Mar 2019 20:45:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexis Ballier <aballier@gentoo.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Small improvements/bugfixes to the rk3399-opi dt
Date:   Sat, 16 Mar 2019 20:45:41 +0100
Message-ID: <7964924.m6SUGMZW0x@phil>
In-Reply-To: <20190315145818.23610-1-aballier@gentoo.org>
References: <20190315145818.23610-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. März 2019, 15:58:15 CET schrieb Alexis Ballier:
> This patch series is based on the rockchip/v5.2-armsoc/dts64 branch and
> fixes a few mistakes in the rk3399-orangepi.dts I sent a couple weeks ago.

applied all 3 for 5.2

Thanks
Heiko


