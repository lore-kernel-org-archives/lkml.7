Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4B7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343F82089E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfEQKoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:44:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60942 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727689AbfEQKoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:44:19 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRaLX-0001UL-UH; Fri, 17 May 2019 12:44:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/3] ARM: dts: rockchip: raise CPU trip point temperature for veyron to 100 degC
Date:   Fri, 17 May 2019 12:44:15 +0200
Message-ID: <2157639.ILuVUxfVHr@phil>
In-Reply-To: <20190516162942.154823-1-mka@chromium.org>
References: <20190516162942.154823-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. Mai 2019, 18:29:40 CEST schrieb Matthias Kaehlcke:
> This value matches what is used by the downstream Chrome OS 3.14
> kernel, the 'official' kernel for veyron devices. Keep the temperature
> for 'speedy' at 90°C, as in the downstream kernel.
> 
> Increase the temperature for a hardware shutdown to 125°C, which
> matches the downstream configuration and gives the system a chance
> to shut down orderly at the criticial trip point.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied all 3 for 5.3 with Doug's RB and did a small fix to the commit
message of patch2 ("thorse").

Thanks
Heiko



