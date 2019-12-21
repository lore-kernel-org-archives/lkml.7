Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78654C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 11:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492F32070C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 11:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfLUL7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 06:59:09 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54844 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfLUL7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 06:59:08 -0500
Received: from [195.37.15.138] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iidPR-0004n3-CJ; Sat, 21 Dec 2019 12:59:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: dts: rockchip: RockPro64: enable wifi/bt
Date:   Sat, 21 Dec 2019 12:58:54 +0100
Message-ID: <12929824.v0dLTkq57a@phil>
In-Reply-To: <20191218223523.30154-1-smoch@web.de>
References: <20191218223523.30154-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Dezember 2019, 23:35:21 CET schrieb Soeren Moch:
> Enhance devicetree of the RockPro64 arm64/rockchip board to use an
> AP6359SA based wifi/bt combo module.
> 
> Patches 1-7 of version 2 of this patch series (to add support for the
> BCM4359 chipset with SDIO interface to the brcmfmac wireless network
> driver) are already picked up for wireless-drivers-next. So this
> version 3 only contains the patches 8-9 from v2.
> 

applied both for 5.6

Thanks
Heiko


