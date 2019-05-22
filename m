Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9843BC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7776620856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfEVJO7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:14:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43894 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbfEVJO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:14:59 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hTNKp-0008JC-Ur; Wed, 22 May 2019 11:14:55 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: Use the GPU to cool CPU thermal zone of veyron mickey
Date:   Wed, 22 May 2019 11:14:55 +0200
Message-ID: <3939310.vedCpJl8Cg@phil>
In-Reply-To: <20190520220051.54847-2-mka@chromium.org>
References: <20190520220051.54847-1-mka@chromium.org> <20190520220051.54847-2-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 21. Mai 2019, 00:00:50 CEST schrieb Matthias Kaehlcke:
> On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
> frequency on veyron mickey to 400 MHz for CPU temperatures >= 65°C
> and to 300 MHz for CPU temperatures >= 85°C.
> 
> This matches the configuration of the downstream Chrome OS 3.14 kernel,
> the 'official' kernel for mickey.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

applied patches 2+3 for 5.3

Thanks
Heiko


