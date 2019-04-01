Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783CB20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDAEbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:31:14 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:46683 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAEbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:31:13 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1256D2800DC4D;
        Mon,  1 Apr 2019 06:31:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B64A917E50; Mon,  1 Apr 2019 06:31:11 +0200 (CEST)
Date:   Mon, 1 Apr 2019 06:31:11 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario.Limonciello@dell.com, linux-kernel@vger.kernel.org,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        andreas.noever@gmail.com, andriy.shevchenko@linux.intel.com,
        ckellner@redhat.com
Subject: Re: [PATCH v3 00/36] thunderbolt: Software connection manager
 improvements
Message-ID: <20190401043111.smpqjn3dhgitmh3e@wunner.de>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
 <1aaab9baea4f46b481b5601dfb060104@ausx13mpc120.AMER.DELL.COM>
 <20190328165621.GB3622@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328165621.GB3622@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 06:56:21PM +0200, Mika Westerberg wrote:
> On Thu, Mar 28, 2019 at 03:17:57PM +0000, Mario.Limonciello@dell.com wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Thursday, March 28, 2019 7:36 AM
> > >   * Do not automatically create PCIe tunnels. Instead we implement "user"
> > >     security level in the software connection manager as well taking
> > >     advantage of the existing sysfs interfaces. This allows user to disable
> > >     PCIe tunneling completely or implement different white listing
> > >     policies. Major distros include bolt system daemon that takes care of
> > >     this.
> > 
> > This is a bit unfortunate.  Is this because of IOMMU limitations in working
> > with devices down the chain?
> 
> No, it just makes it possible to do things such as "disable all PCIe
> tunneling", like the master switch we have in GNOME UI.

It appears to be a change in behavior though as PCIe tunnels are
currently established automatically on Macs which don't use ICM.
The change might be considered breaking userspace, not sure.

Also on macOS it's just plug and play without any need to configure
whitelists or anything.

Thanks,

Lukas
