Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F6C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3D2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfFNLcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 07:32:47 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39726 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfFNLcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:32:46 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbkRm-0004mJ-74; Fri, 14 Jun 2019 13:32:42 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     xieqinick@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards
Date:   Fri, 14 Jun 2019 13:32:41 +0200
Message-ID: <4566563.QzcLDyM7tj@phil>
In-Reply-To: <1560153473-17190-1-git-send-email-xieqinick@gmail.com>
References: <1559035267-1884-1-git-send-email-xieqinick@gmail.com> <1560153473-17190-1-git-send-email-xieqinick@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juni 2019, 09:57:53 CEST schrieb xieqinick@gmail.com:
> From: Nick Xie <nick@khadas.com>
> 
> Add devicetree support for Khadas Edge/Edge-V/Captain boards.
> Khadas Edge is an expandable Rockchip RK3399 board with goldfinger.
> Khadas Captain is the carrier board for Khadas Edge.
> Khadas Edge-V is a Khadas VIM form factor Rockchip RK3399 board.
> 
> Signed-off-by: Nick Xie <nick@khadas.com>

applied for 5.3 after doing some style-fixes to the edge.dtsi
(2 missing gpio constants, some newlines and sdio-regulator
references were missing "<..>")

Please double-check the result


Thanks
Heiko


