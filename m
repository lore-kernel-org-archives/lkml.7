Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FAC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC8221920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tMR7C0VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbfJAMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:42:18 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55926 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbfJAMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n9SwtzBQLDaKOFpGqdCfpbjlJzYPV55cZxw6ACX85V8=; b=tMR7C0VFFtvrM97u3rSLb+tudh
        9r7oghvLWphuntDvlNJ8IlMl0Wyi5SVbhuOzF3nWZ8Fozhnp0m0f5+rHoKKJT15DCZHW+JwVelUYZ
        vZwN2qH3c+t2N8j92zoECtQkAdLFLw+IMpcXuTdBRIjGyjL3rxVrNR0+cEr6N6Lk/2/M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iFHTi-0000P7-Eq; Tue, 01 Oct 2019 14:42:06 +0200
Date:   Tue, 1 Oct 2019 14:42:06 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MarkLee <Mark-MC.Lee@mediatek.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nelson Chang <nelson.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rene van Dorst <opensource@vdorst.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 1/2] net: ethernet: mediatek: Fix MT7629 missing GMII
 mode support
Message-ID: <20191001124206.GC869@lunn.ch>
References: <20191001123150.23135-1-Mark-MC.Lee@mediatek.com>
 <20191001123150.23135-2-Mark-MC.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001123150.23135-2-Mark-MC.Lee@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 08:31:49PM +0800, MarkLee wrote:
> Add missing configuration for mt7629 gmii mode support
> 
> Signed-off-by: MarkLee <Mark-MC.Lee@mediatek.com>

Hi Mark

Since this is for net, it should have a Fixes: tag.

Thanks
	Andrew
