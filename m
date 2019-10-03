Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8945C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967422053B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbfJCWp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:45:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56832 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfJCWp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:45:56 -0400
Received: from p57b7758c.dip0.t-ipconnect.de ([87.183.117.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iG9r7-0000ti-Nn; Fri, 04 Oct 2019 00:45:53 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Cole-Baker <sigmaris@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date:   Fri, 04 Oct 2019 00:45:53 +0200
Message-ID: <32713632.1bI0RUAnRe@phil>
In-Reply-To: <20191004075645.715fb074@canb.auug.org.au>
References: <20191004075645.715fb074@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Am Donnerstag, 3. Oktober 2019, 23:56:45 CEST schrieb Stephen Rothwell:
> In commit
> 
>   b62ce630fddb ("arm64: dts: rockchip: fix Rockpro64 RK808 interrupt line")
> 
> Fixes tag
> 
>   Fixes: e4f3fb4 ("arm64: dts: rockchip: add initial dts support for Rockpro64")

I fixed the git hash and updated the branch with it.

Thanks for the catch
Heiko


