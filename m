Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E43CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8A321850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfJ0SWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:22:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58196 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbfJ0SWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:22:38 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOnBV-0008Hx-48; Sun, 27 Oct 2019 19:22:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] arm64: dts: rockchip: remove px30 default optee node
Date:   Sun, 27 Oct 2019 19:22:36 +0100
Message-ID: <3461884.ytE3v2kofO@phil>
In-Reply-To: <20191023224409.3550-1-heiko@sntech.de>
References: <20191023224409.3550-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. Oktober 2019, 00:44:09 CET schrieb Heiko Stuebner:
> Having a default optee node in a soc devicetree is not really good.
> For one there is no guarantee that any tee got loaded and there's even
> the possibility that a completely different TEE got loaded.
> 
> OP-Tee however will insert relevant nodes to the devicetree (firmware
> +reserved memory sections) during its own startup, so there really is
> no need to provide a default node.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 5.5


