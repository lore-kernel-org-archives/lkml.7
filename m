Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C32C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FC1215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfJBOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:21:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfJBOVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:21:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B6DFAC7B;
        Wed,  2 Oct 2019 14:21:08 +0000 (UTC)
Message-ID: <1570026066.2472.15.camel@suse.com>
Subject: Re: [RFC PATCH 06/22] thunderbolt: Add support for lane bonding
From:   Oliver Neukum <oneukum@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        Mario.Limonciello@dell.com,
        Andreas Noever <andreas.noever@gmail.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Date:   Wed, 02 Oct 2019 16:21:06 +0200
In-Reply-To: <20191001125320.GN2714@lahna.fi.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
         <20191001113830.13028-7-mika.westerberg@linux.intel.com>
         <20191001123808.GA2954373@kroah.com>
         <20191001125320.GN2714@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.10.2019, 15:53 +0300 schrieb Mika Westerberg:
> > 
> > Are we only going to be allowed to "bond" two links together?  Or will
> > we be doing more than 2 in the future?  If more, then we might want to
> > think of a different way to specify these...
> 
> AFAICT only two lanes are available in USB4. This goes over USB type-C
> using the two lanes there.
> 
> Of course I don't know if in future there will be USB4 1.1 or something
> that adds more lanes so if you think there is a better way to specify
> these, I'm happy to implement that instead :) 

If this ever can become asymmetric this interface is going to turn
around and bite.

	Regards
		Oliver

