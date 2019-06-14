Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCC6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEEB21537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFNOBL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:01:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41382 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbfFNOBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:01:11 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbmlN-0005Zq-MY; Fri, 14 Jun 2019 16:01:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nick Xie <xieqinick@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        nick@khadas.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards
Date:   Fri, 14 Jun 2019 16:01:05 +0200
Message-ID: <1719008.LxYQEzyXAE@diego>
In-Reply-To: <CAP4nuTUQZRG9yV1Bz2hpe10K3CrWhVWf_YYBnMs3O1KyahhrMw@mail.gmail.com>
References: <1559035267-1884-1-git-send-email-xieqinick@gmail.com> <4566563.QzcLDyM7tj@phil> <CAP4nuTUQZRG9yV1Bz2hpe10K3CrWhVWf_YYBnMs3O1KyahhrMw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Am Freitag, 14. Juni 2019, 15:32:11 CEST schrieb Nick Xie:
> Thanks, I'll check them out.
> 
> But there is a small typo:
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/tree/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi?h=v5.3-armsoc/dts64&id=910249897d13beaa0b46069e27139024cd77e916#n299
> 
> *22 (GPIO1_C6)* should be *RK_PC6* NOT *RK_PD6*.

thanks for double-checking ... I've updated the commit to use the right gpio now.

Heiko

> 
> Heiko Stuebner <heiko@sntech.de> 于2019年6月14日周五 下午7:32写道：
> 
> > Am Montag, 10. Juni 2019, 09:57:53 CEST schrieb xieqinick@gmail.com:
> > > From: Nick Xie <nick@khadas.com>
> > >
> > > Add devicetree support for Khadas Edge/Edge-V/Captain boards.
> > > Khadas Edge is an expandable Rockchip RK3399 board with goldfinger.
> > > Khadas Captain is the carrier board for Khadas Edge.
> > > Khadas Edge-V is a Khadas VIM form factor Rockchip RK3399 board.
> > >
> > > Signed-off-by: Nick Xie <nick@khadas.com>
> >
> > applied for 5.3 after doing some style-fixes to the edge.dtsi
> > (2 missing gpio constants, some newlines and sdio-regulator
> > references were missing "<..>")
> >
> > Please double-check the result
> >
> >
> > Thanks
> > Heiko
> >
> >
> >




