Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB40C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F1E2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKGShe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:37:34 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKGShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:37:33 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 27433151EA471;
        Thu,  7 Nov 2019 10:37:33 -0800 (PST)
Date:   Thu, 07 Nov 2019 10:37:32 -0800 (PST)
Message-Id: <20191107.103732.1582617319935662216.davem@davemloft.net>
To:     jonas@norrbonn.se
Cc:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add namespace awareness to Netlink methods
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Nov 2019 10:37:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Bonn <jonas@norrbonn.se>
Date: Thu,  7 Nov 2019 14:27:49 +0100

> Changed in v3:
> - added patch 6 for setting IPv6 address outside current namespace
> - address checkpatch warnings
> - address comment from Nicolas
> 
> Changed in v2:
> - address comment from Nicolas
> - add accumulated ACK's
> 
> Currently, Netlink has partial support for acting outside of the current
> namespace.  It appears that the intention was to extend this to all the
> methods eventually, but it hasn't been done to date.
> 
> With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNSID
> are extended to respect the selection of the namespace to work in.

This patch series does not apply cleanly to net-next, please respin.

I think v2 had this problem too.
