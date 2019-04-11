Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD8C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF91217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfDKMmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:42:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58008 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfDKMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:42:11 -0400
Received: from wf0380.dip.tu-dresden.de ([141.76.181.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEZ1p-0007uf-Bj; Thu, 11 Apr 2019 14:42:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix cts, rts pin assign of UART3 for rk3399
Date:   Thu, 11 Apr 2019 14:42:04 +0200
Message-ID: <3217226.65qr7uJ2Ov@phil>
In-Reply-To: <20190406153557.25930-1-katsuhiro@katsuster.net>
References: <20190406153557.25930-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 6. April 2019, 17:35:57 CEST schrieb Katsuhiro Suzuki:
> This patch fixes pin assign of cts and rts signal of UART3.
> 
> Currently GPIO3_C2 and C3 pins are assigned but TRM says that
> GPIO3_C0 and C1 are correct.
> 
> Refer:
>   RK3399 TRM v1.4 - Table 19-1 UART Interface Description
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.2

Thanks
Heiko


