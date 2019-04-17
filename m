Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38F1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19BC20651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbfDQUQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:16:36 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:53784 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:16:35 -0400
Received: from cpe-2606-a000-111b-405a-0-0-0-188a.dyn6.twc.com ([2606:a000:111b:405a::188a] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hGqyD-0002cQ-EE; Wed, 17 Apr 2019 16:15:55 -0400
Date:   Wed, 17 Apr 2019 16:15:21 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     David Miller <davem@davemloft.net>
Cc:     arnd@arndb.de, ralf@linux-mips.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, socketcan@hartkopp.net,
        mkl@pengutronix.de, gerrit@erg.abdn.ac.uk, alex.aring@gmail.com,
        stefan@datenfreihafen.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, vyasevich@gmail.com,
        marcelo.leitner@gmail.com, andrew.hendry@gmail.com,
        edumazet@google.com, willemb@google.com, deepa.kernel@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-can@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-x25@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
Message-ID: <20190417201521.GB15487@hmswarspite.think-freely.org>
References: <20190416203620.539628-1-arnd@arndb.de>
 <20190417093523.GA15487@hmswarspite.think-freely.org>
 <20190417.102112.382636552216165456.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417.102112.382636552216165456.davem@davemloft.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:21:12AM -0700, David Miller wrote:
> From: Neil Horman <nhorman@tuxdriver.com>
> Date: Wed, 17 Apr 2019 05:35:23 -0400
> 
> > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> 
> Neil, please quote appropriately in the future.
> 
> I have to scroll through all of those pages of quoted patch just to
> see this one line.
> 
> Thank you.
> 
Sorry, completely forgot to snip.  Will remember in the future
Neil

