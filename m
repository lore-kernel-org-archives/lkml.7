Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E4C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB6A2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfFSC0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:26:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56692 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSC0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:26:50 -0400
Received: from localhost (unknown [8.46.76.24])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69CB614DB02AD;
        Tue, 18 Jun 2019 19:26:33 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:26:24 -0400 (EDT)
Message-Id: <20190618.222624.192769316432594413.davem@davemloft.net>
To:     maxime.chevallier@bootlin.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 0/4] net: mvpp2: cls: Allow steering based on
 vlan tag
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190618145519.27705-1-maxime.chevallier@bootlin.com>
References: <20190618145519.27705-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Jun 2019 19:26:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Tue, 18 Jun 2019 16:55:15 +0200

> The PPv2 classifier can perform flow steering based on keys extracted
> from the VLAN tag. This series adds support for using the vlan id and
> the vlan prio as keys, using the ethtool interface.
> 
> Patch 1 is a preparatory patch that prevent false-positive matches,
> using a dedicated lookup id for the RSS C2 lookup.
> 
> Patch 2 allows to separate the flows based on the header fields they
> contain. The main goal is to be able to separate tagged traffic from
> untagged traffic for flow steering, just as we already do for RSS.
> 
> Patch 3 solves an issue we have when extracting fields that aren't full
> bytes, such as the vlan tag which is 12 bits wide, or the priority which
> is 3 bits wide.
> 
> Finally, patch 4 adds support for steering based on both vlan id and
> priority, extracted from the outermost tag.

Series applied, thanks.
