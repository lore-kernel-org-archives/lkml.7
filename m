Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E0C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E906D25AF6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 14:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="h4FQU1TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE3ObP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 10:31:15 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:38722 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3ObO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 10:31:14 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5961841940;
        Thu, 30 May 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        user-agent:in-reply-to:content-disposition:content-type
        :content-type:mime-version:references:message-id:subject:subject
        :from:from:date:date:received:received:received; s=mta-01; t=
        1559226671; x=1561041072; bh=ll2giGFTqdDyHGvuSZXxwLYSy7dMxwuDVbi
        8AS6xgSU=; b=h4FQU1TZ0qR2HRm11GdsDSjcxYXyDxtp/xyoeLUEsg+6l7Zxg5N
        3hzcCv84UlhtjFD8Il3csewASMx3KPl4YIFt82l8GPnURaNH6B0pxpt3mp4465K/
        6s4jDtpWP4TUL1vs227Bm4SGtFiafIE3w5nYKk05SQSsTq0IpJJynxp4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HUOE-xr00LJ2; Thu, 30 May 2019 17:31:11 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id E129B418F9;
        Thu, 30 May 2019 17:31:10 +0300 (MSK)
Received: from localhost (172.17.14.115) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 30
 May 2019 17:31:10 +0300
Date:   Thu, 30 May 2019 17:31:10 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Alexander Filippov <a.filippov@yadro.com>,
        <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Add YADRO VESNIN BMC
Message-ID: <20190530143110.GA24059@bbwork.lan>
References: <20190530093948.12479-1-a.filippov@yadro.com>
 <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CACPK8XfG7j4Z2bqX9CFxUeUrpx708Uqbh-5ts9W5SnDfDw-xYA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [172.17.14.115]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 02:16:59PM +0000, Joel Stanley wrote:
> On Thu, 30 May 2019 at 09:40, Alexander Filippov <a.filippov@yadro.com> wrote:
> > @@ -0,0 +1,262 @@
> 
> Can we get a SDPX license string at the top of the file? Something like this:
> 
> // SPDX-License-Identifier: GPL-2.0+
> // Copyright 2019 <copyright holder>

Sure, on my way.

> 
> > +/dts-v1/;
> > +
> > +#include "aspeed-g4.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +
> 
> > +&i2c3 {
> > +       status = "okay";
> > +       cpr2021@59 {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               compatible = "general,cpr2021", "general,pmbus";
> 
> Do you have a driver for this one you plan on submitting?

Yes, we plan but not right now. I remove it now and it will be added when the
driver will be ready.
