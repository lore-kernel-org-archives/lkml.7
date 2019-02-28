Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFDC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867C72083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfCBHGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:06:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfCBHGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:06:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9FB77144FCAE8;
        Fri,  1 Mar 2019 23:06:54 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:21:43 -0800 (PST)
Message-Id: <20190228.102143.968303356613794513.davem@davemloft.net>
To:     f.suligoi@asem.it
Cc:     jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: e1000e: add MAC address kernel cmd line parameter
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
References: <1551345635-10291-1-git-send-email-f.suligoi@asem.it>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 01 Mar 2019 23:06:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Flavio Suligoi <f.suligoi@asem.it>
Date: Thu, 28 Feb 2019 10:20:35 +0100

> Sometimes, in some embedded systems boards (i.e. ARM boards),
> the NVM eeprom is not mounted, to save cost and space.
> 
> In this case it is necessary to bypass the NVM management
> and directly force the MAC address using a kernel command-line
> parameter (macaddr).
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Sorry, we don't do things this way.  Otherwise every single driver would
add a hack like this.

Add either DT or appropriate initrd userland components to achieve
this.

