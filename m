Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A414CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F31821773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfDWKb0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:31:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60494 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDWKbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:31:23 -0400
Received: from p57b772a1.dip0.t-ipconnect.de ([87.183.114.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hIshp-0001qI-8D; Tue, 23 Apr 2019 12:31:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix IO domain voltage setting of APIO5
Date:   Tue, 23 Apr 2019 12:31:16 +0200
Message-ID: <1963530.P7P6axORlu@phil>
In-Reply-To: <20190327120317.15256-1-katsuhiro@katsuster.net>
References: <20190327120317.15256-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 27. März 2019, 13:03:17 CEST schrieb Katsuhiro Suzuki:
> This patch fixes IO domain voltage setting that is related to
> audio_gpio3d4a_ms (bit 1) of GRF_IO_VSEL.
> 
> This is because RockPro64 schematics P.16 says that regulator
> supplies 3.0V power to APIO5_VDD. So audio_gpio3d4a_ms bit should
> be clear (means 3.0V). Power domain map is saying different thing
> (supplies 1.8V) but I believe P.16 is actual connectings.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>

applied for 5.2

Thanks
Heiko


