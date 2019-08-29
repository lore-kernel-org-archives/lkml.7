Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEC1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202482166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfH2WIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:08:55 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54302 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfH2WIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:08:55 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9013F153AC237;
        Thu, 29 Aug 2019 15:08:51 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:08:51 -0700 (PDT)
Message-Id: <20190829.150851.713654232867665043.davem@davemloft.net>
To:     idosch@idosch.org
Cc:     andrew@lunn.ch, jiri@resnulli.us, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to
 dev->promiscuity.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190829175759.GA19471@splinter>
References: <20190829134901.GJ2312@nanopsycho>
        <20190829143732.GB17864@lunn.ch>
        <20190829175759.GA19471@splinter>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Aug 2019 15:08:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 29 Aug 2019 20:57:59 +0300

> On a software switch, when you run tcpdump without '-p', do you incur
> major packet loss? No. Will this happen when you punt several Tbps to
> your CPU on the hardware switch? Yes.
> 
> Extending the definition of promiscuous mode to mean punt all traffic to
> the CPU is wrong, IMO. You will not be able to capture all the packets

This is so illogical, it is mind boggling.

How different is this to using tcpdump/wireshark on a 100GB or 1TB
network interface?

There is no difference.

Please stop portraying switches as special in this regard, they are
not.
