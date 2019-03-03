Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A1CC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE6520866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfCCNzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:55:53 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41490 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCCNzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:55:53 -0500
Received: from p54b26aa0.dip0.t-ipconnect.de ([84.178.106.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h0Ram-000515-SK; Sun, 03 Mar 2019 14:55:48 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: add #sound-dai-cells to HDMI of rk3328
Date:   Sun, 03 Mar 2019 14:55:48 +0100
Message-ID: <36101455.UDL3bTQpI8@phil>
In-Reply-To: <20190217173407.29189-1-katsuhiro@katsuster.net>
References: <20190217173407.29189-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. Februar 2019, 18:34:06 CET schrieb Katsuhiro Suzuki:
> This patch adds #sound-dai-cells to use HDMI node as audio
> codec from device tree of rk3328 boards.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.2 .

I'm holding off of patch2 for a bit until you and Jonas can clarify that
all is right as it is :-)


Heiko


