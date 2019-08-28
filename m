Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41118C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B6522CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfH1NTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:19:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:61722 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1NTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:19:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 06:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="197556912"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2019 06:19:44 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 28 Aug 2019 16:19:43 +0300
Date:   Wed, 28 Aug 2019 16:19:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
Message-ID: <20190828131943.GZ3177@lahna.fi.intel.com>
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
 <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
 <20190828102342.GT3177@lahna.fi.intel.com>
 <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:43:35PM +0800, Brad Campbell wrote:
> On 28/8/19 6:23 pm, Mika Westerberg wrote:
> 
> > On Wed, Aug 28, 2019 at 05:12:00PM +0800, Brad Campbell wrote:
> > 
> > Apart from the warning in the log (which is not fatal, I'll look into
> > it) to me the second path setup looks fine.
> > 
> > Can you do one more experiment? Boot the system up without anything
> > connected and then plug both monitors. Does it work?
> > 
> 
> Aside from head ordering issues in X it works just fine.
> I've attached the dmesg. Boot with nothing plugged in, then plug in 0-1 and
> 0-3 in that order.

OK, thanks for checking. So when Linux is in complete control both DP
tunnels get created properly. I suspect there is something different
what the firmware does compared to other Macs I've been using and that
causes the driver to fail to discover all the paths. I will take a look
at this but I'm away tomorrow and friday so it goes to next week.

BTW, have you tried to chain the two monitors?
