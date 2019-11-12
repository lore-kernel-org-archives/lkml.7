Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A6BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DC221783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 08:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLIY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:24:27 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56473 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 03:24:27 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BBCC9C0007;
        Tue, 12 Nov 2019 08:24:21 +0000 (UTC)
Date:   Tue, 12 Nov 2019 09:24:20 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Milind Parab <mparab@cadence.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>,
        Dhananjay Vilasrao Kangude <dkangude@cadence.com>,
        Ewan McCulloch <ewanm@cadence.com>,
        Arthur Marris <arthurm@cadence.com>,
        Steven Ho <stevenh@cadence.com>
Subject: Re: [PATCH 1/4] net: macb: add phylink support
Message-ID: <20191112082420.GA13460@kwain>
References: <1573220027-15842-1-git-send-email-mparab@cadence.com>
 <1573220063-17470-1-git-send-email-mparab@cadence.com>
 <20191108154234.GA208063@kwain>
 <BY5PR07MB65146091E2AD492FD656C9AFD3740@BY5PR07MB6514.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR07MB65146091E2AD492FD656C9AFD3740@BY5PR07MB6514.namprd07.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Milind,

On Mon, Nov 11, 2019 at 08:53:39AM +0000, Milind Parab wrote:
> 
> I had a look at your patch. It is worth waiting for your acceptance
> rather than duplicating the effort.  When do you plan to submit your
> "V2" patch?
> And please add me and other cadence members in your patch submission.

I'll send it today, and I'll add you and the mails you provided in Cc.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
