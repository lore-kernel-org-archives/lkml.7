Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066E0214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfCLI30 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:29:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57398 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfCLI30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:29:26 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3cmo-0000Sm-AX; Tue, 12 Mar 2019 09:29:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: rockchip: remove disable-wp from rv1108-elgin-r1 emmc node
Date:   Tue, 12 Mar 2019 09:29:21 +0100
Message-ID: <8230885.i9KLFSsvLL@phil>
In-Reply-To: <20190310151928.2344-1-jbx6244@gmail.com>
References: <20190219130317.2817-1-jbx6244@gmail.com> <20190310151928.2344-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. März 2019, 16:19:28 CET schrieb Johan Jonker:
> The mmc.txt didn't explicitly say disable-wp is for SD card slot only,
> but that is what it was designed for in the first place.
> Remove all disable-wp from emmc or sdio controllers.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

applied for 5.2

Thanks
Heiko


