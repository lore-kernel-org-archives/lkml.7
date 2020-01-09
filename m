Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885BC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A9A206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgAIIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:51:26 -0500
Received: from gloria.sntech.de ([185.11.138.130]:54056 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbgAIIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:51:25 -0500
Received: from ip5f5a5f74.dynamic.kabel-deutschland.de ([95.90.95.116] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ipTXE-0005bd-IY; Thu, 09 Jan 2020 09:51:20 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-rockchip@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: rockchip: Use ABI name for recovery mode pin on veyron fievel/tiger
Date:   Thu, 09 Jan 2020 09:51:19 +0100
Message-ID: <4961361.gyzMsJYQDa@diego>
In-Reply-To: <20200108092908.1.I3afd3535b65460e79f3976e9ebfa392a0dd75e01@changeid>
References: <20200108092908.1.I3afd3535b65460e79f3976e9ebfa392a0dd75e01@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 8. Januar 2020, 18:29:33 CET schrieb Matthias Kaehlcke:
> The recovery mode pin is currently named 'REC_MODE_L', which is
> how the signal is called in the schematics. The Chrome OS ABI
> requires the pin to be named 'RECOVERY_SW_L', which is also how
> it is called on all other veyron devices. Rename the pin to match
> the ABI.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied for 5.6

Thanks
Heiko


