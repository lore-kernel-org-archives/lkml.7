Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB54C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A3C218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfDWVca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:32:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36442 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfDWVc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:32:29 -0400
Received: from p57b772a1.dip0.t-ipconnect.de ([87.183.114.161] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hJ31e-0004bd-M3; Tue, 23 Apr 2019 23:32:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: linux-next: Fixes tag needs some work in the rockchip tree
Date:   Tue, 23 Apr 2019 23:32:26 +0200
Message-ID: <1748269.eM8PPa3JB8@phil>
In-Reply-To: <20190424072539.51aa27e2@canb.auug.org.au>
References: <20190424072539.51aa27e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 23. April 2019, 23:25:39 CEST schrieb Stephen Rothwell:
> Hi Heiko,
> 
> In commit
> 
>   89c1f66ae88a ("arm64: dts: rockchip: fix IO domain voltage setting of APIO5 on rockpro64")
> 
> Fixes tag
> 
>   Fixes: e4f3fb4909 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Thanks for that catch. I've amended the commit to have a correct
fixes commit-id.


Thanks
Heiko


