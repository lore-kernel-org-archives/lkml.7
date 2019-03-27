Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ECAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfC0O2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:48556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfC0O2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:28:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57295ADC8;
        Wed, 27 Mar 2019 14:28:07 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id F3CB9E1404; Wed, 27 Mar 2019 15:28:06 +0100 (CET)
Date:   Wed, 27 Mar 2019 15:28:06 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/22] ethtool netlink interface, part 1
Message-ID: <20190327142806.GT26076@unicorn.suse.cz>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <20190327130928.GC14297@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327130928.GC14297@nanopsycho>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:09:28PM +0100, Jiri Pirko wrote:
> Could you please perhaps split the patchset so it contains max ~15 patches?

Would 1-17 still be acceptable? The thing is that patch 16 is the first
where some "normal" notification (i.e. not EVENT one) is sent and
patch 17 is the first implementation of a request modifying data.
I believe having at least one example of both querying and setting data
would help the review discussion.

Or perhaps I could leave GET_INFO related patches (at least second and
third) for later.

Michal
