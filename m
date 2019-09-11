Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B70ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A233C2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfIKRR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:17:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62683 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfIKRR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:17:56 -0400
Received: from 38.85.69.148.rev.vodafone.pt (148.69.85.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 8c4416ec4a1609a8; Wed, 11 Sep 2019 19:17:54 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pm tree
Date:   Wed, 11 Sep 2019 19:17:52 +0200
Message-ID: <3207595.z7mfiUyZYE@kreacher>
In-Reply-To: <20190911072741.GA981@kuha.fi.intel.com>
References: <20190911003306.74ca7251@canb.auug.org.au> <20190911072741.GA981@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 11, 2019 9:27:41 AM CEST Heikki Krogerus wrote:
> On Wed, Sep 11, 2019 at 12:33:06AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   fd3f7275826f ("software node: Initialize the return value in software_node_find_by_name()")
> > 
> > Fixes tag
> > 
> >   Fixes: 1666faedb567 ("software node: Add software_node_get_reference_args()")
> > 
> > has these problem(s):
> > 
> >   - Subject does not match target commit subject
> >     Just use
> > 	git log -1 --format='Fixes: %h ("%s")'
> > 
> > Did you mean
> > 
> > Fixes: 1666faedb567 ("software node: Add software_node_find_by_name()")
> > 
> > or
> > 
> > Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
> 
> Rafael, it seems you have rebased your branch.

No, I haven't.

Actually, the commit ID is correct, but the name isn't.

You'd have been unlikely to get a valid commit ID matching anything with
"software node" in the subject had it been rebased. :-)

> Do you want me to resend those fixes, or can you fix the tags in them
> yourself?

I fixed that tag up.

Thanks,
Rafael



