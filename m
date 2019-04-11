Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C25CC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEE5217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKLih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:38:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57276 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfDKLig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:38:36 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEY2L-0007WH-6t; Thu, 11 Apr 2019 13:38:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ARM: dts: rockchip: Add BT_EN to the power sequence for veyron
Date:   Thu, 11 Apr 2019 13:38:32 +0200
Message-ID: <5092711.5oqtbe4BJ2@phil>
In-Reply-To: <20190409231405.189335-1-mka@chromium.org>
References: <20190409231405.189335-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. April 2019, 01:14:05 CEST schrieb Matthias Kaehlcke:
> Add GPIO D5 (BT_ENABLE_L) as reset-GPIO to the power sequence for the
> Bluetooth/WiFi module. On devices with a Broadcom module the signal
> needs to be asserted to use Bluetooth.
> 
> Note that BT_ENABLE_L is a misnomer in the schematics, the signal
> actually is active-high.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.2 with Doug's rb.

Thanks
Heiko


