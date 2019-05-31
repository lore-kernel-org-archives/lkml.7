Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11AC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D622642C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="wD9JZsv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfEaGHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:07:36 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:36086 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaGHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:07:35 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 4B3A44196A;
        Fri, 31 May 2019 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1559282853; x=1561097254; bh=aP/v8Ti3LcvTQfv2gGn+BqK/Tdgk+/cwBCm
        +uXIEhhs=; b=wD9JZsv4lyaVNK+ct7ZaeDLknftLzxvLWSIqh8Diw6IZ2YuMo/y
        a2i4VZPvDOpFEEWNxtI7dIQZ0ooZDHHVi9w78KLhbKH4jzaXPBuMbnQzMt0SEvAD
        vkDSPRD64FzunuFWpunrW9UqNzIE2IAPSbptqxYOBlKKj+4vD+QS60IE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vd6-wKmfLZdQ; Fri, 31 May 2019 09:07:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 64D7741860;
        Fri, 31 May 2019 09:07:32 +0300 (MSK)
Received: from localhost (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 31
 May 2019 09:07:32 +0300
Date:   Fri, 31 May 2019 09:07:31 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Alexander Filippov <a.filippov@yadro.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add YADRO VESNIN BMC
Message-ID: <20190531060731.GA22597@bbwork.lan>
References: <20190530143933.25414-1-a.filippov@yadro.com>
 <20190530203653.GD1561@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190530203653.GD1561@lunn.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 10:36:53PM +0200, Andrew Lunn wrote:
> On Thu, May 30, 2019 at 05:39:33PM +0300, Alexander Filippov wrote:
> > VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> > by YADRO.
> > 
> > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> > ---
> >  arch/arm/boot/dts/Makefile                  |   1 +
> >  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 234 ++++++++++++++++++++
> >  2 files changed, 235 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 834cce80d1b8..811e9312cf22 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1259,6 +1259,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >  	aspeed-bmc-microsoft-olympus.dtb \
> >  	aspeed-bmc-opp-lanyang.dtb \
> >  	aspeed-bmc-opp-palmetto.dtb \
> > +	aspeed-bmc-opp-vesnin.dtb \
> >  	aspeed-bmc-opp-romulus.dtb \
> >  	aspeed-bmc-opp-swift.dtb \
> >  	aspeed-bmc-opp-witherspoon.dtb \
> 
> Hi Alexander

Hi Andrew,

> 
> Still not correctly sorted.
> 

Thanks, I've fixed it in V3

>       Andrew
