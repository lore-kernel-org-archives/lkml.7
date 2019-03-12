Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CFA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCLKIH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:08:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58444 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfCLKIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:08:07 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3eKM-0000yM-0r; Tue, 12 Mar 2019 11:08:06 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tomohiro Mayama <parly-gh@iris.mystia.org>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64
Date:   Tue, 12 Mar 2019 11:08:05 +0100
Message-ID: <5987950.f1rGcapdrK@phil>
In-Reply-To: <22e82bfa-8044-d126-59cc-6e6f42ca4b9c@iris.mystia.org>
References: <4e9800cd-ac6d-9eb8-60d4-8e4b1aa761b9@iris.mystia.org> <22e82bfa-8044-d126-59cc-6e6f42ca4b9c@iris.mystia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. März 2019, 17:10:12 CET schrieb Tomohiro Mayama:
> This patch makes USB ports functioning again.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Tomohiro Mayama <parly-gh@iris.mystia.org>
> Tested-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

added Fixes and Cc-stable tags and applied as fix for 5.1

Thanks
Heiko


