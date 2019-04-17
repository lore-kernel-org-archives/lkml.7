Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbfDQHqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:46:30 -0400
Received: from nbd.name ([46.4.11.11]:49514 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQHq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:46:29 -0400
Received: from p548c87c0.dip0.t-ipconnect.de ([84.140.135.192] helo=[192.168.45.69])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hGfH0-0004HX-8U; Wed, 17 Apr 2019 09:46:26 +0200
Subject: Re: [PATCH v1 3/3] net: ethernet: add ag71xx driver
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        netdev@vger.kernel.org
References: <20190417062201.15745-1-o.rempel@pengutronix.de>
 <20190417062201.15745-4-o.rempel@pengutronix.de>
From:   John Crispin <john@phrozen.org>
Message-ID: <e7b75751-85fe-db7a-a39e-d1991e104403@phrozen.org>
Date:   Wed, 17 Apr 2019 09:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417062201.15745-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2019 08:22, Oleksij Rempel wrote:
> index 000000000000..0e1374ddac63
> --- /dev/null
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -0,0 +1,1971 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Atheros AR71xx built-in ethernet mac driver
> + *
> + *  Copyright (C) 2019 Oleksij Rempel<o.rempel@pengutronix.de>
> + *  Copyright (C) 2008-2010 Gabor Juhos<juhosg@openwrt.org>
> + *  Copyright (C) 2008 Imre Kaloz<kaloz@openwrt.org>
> + *

Hi,

I think this list needs to be extended by quite a bit. we should to a 
git log --follow inside the openwrt tree. a ton of people have done a 
lot of work on the codebase over the years.

     John


> + *  Based on Atheros' AG7100 driver
> + */
