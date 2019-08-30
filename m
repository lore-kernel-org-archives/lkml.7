Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4072C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9104A22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfH3Hc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:32:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59796 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfH3Hc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:32:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::642])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5B9951544FE29;
        Fri, 30 Aug 2019 00:32:26 -0700 (PDT)
Date:   Fri, 30 Aug 2019 00:32:25 -0700 (PDT)
Message-Id: <20190830.003225.292019185488425085.davem@davemloft.net>
To:     jiri@resnulli.us
Cc:     idosch@idosch.org, andrew@lunn.ch, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to
 dev->promiscuity.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190830072133.GP2312@nanopsycho>
References: <20190830063624.GN2312@nanopsycho>
        <20190830.001223.669650763835949848.davem@davemloft.net>
        <20190830072133.GP2312@nanopsycho>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 00:32:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Pirko <jiri@resnulli.us>
Date: Fri, 30 Aug 2019 09:21:33 +0200

> Fri, Aug 30, 2019 at 09:12:23AM CEST, davem@davemloft.net wrote:
>>From: Jiri Pirko <jiri@resnulli.us>
>>Date: Fri, 30 Aug 2019 08:36:24 +0200
>>
>>> The promiscuity is a way to setup the rx filter. So promics == rx filter
>>> off. For normal nics, where there is no hw fwd datapath,
>>> this coincidentally means all received packets go to cpu.
>>
>>You cannot convince me that the HW datapath isn't a "rx filter" too, sorry.
> 
> If you look at it that way, then we have 2: rx_filter and hw_rx_filter.
> The point is, those 2 are not one item, that is the point I'm trying to
> make :/

And you can turn both of them off when I ask for promiscuous mode, that's
a detail of the device not a semantic issue.
