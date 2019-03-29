Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E47C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C004B206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbfC2OPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:15:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:17286 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfC2OPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:15:52 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 07:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="218760448"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2019 07:15:50 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h9sIP-0005pq-4r; Fri, 29 Mar 2019 16:15:49 +0200
Date:   Fri, 29 Mar 2019 16:15:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/6] device property: Add functions for accessing
 node's parents
Message-ID: <20190329141549.GZ9224@smile.fi.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-2-sakari.ailus@linux.intel.com>
 <20190327122625.eaisnw776vqwhhnh@pathway.suse.cz>
 <20190327142036.jf6puc5uo2mjutbl@paasikivi.fi.intel.com>
 <CAJZ5v0hi04yACD9ZzDCaxhJh-uHHpMOu=zZzVf4t5vH=ctaYBg@mail.gmail.com>
 <20190328111307.ppuywzyb3i56pw4h@kekkonen.localdomain>
 <CAJZ5v0gAM_jn-gkmyu7Av+X0W_8g9NGjBEeXC-3-q_Ncb2PEGw@mail.gmail.com>
 <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329131507.cc4qt5oyd74nvmzt@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 03:15:07PM +0200, Sakari Ailus wrote:
> On Thu, Mar 28, 2019 at 03:52:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 28, 2019 at 12:13 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Thu, Mar 28, 2019 at 10:38:01AM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 27, 2019 at 3:20 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > On Wed, Mar 27, 2019 at 01:26:25PM +0100, Petr Mladek wrote:
> > > > > > On Tue 2019-03-26 14:41:01, Sakari Ailus wrote:

> Another option would be changing where the counting starts --- the first
> parent. I.e.

Looks better to me, though can you put comment how parents are being counted?

> fwnode = fwnode_get_parent(fwnode);
> 
> for (count = 0; fwnode; count++)
> 	fwnode = fwnode_get_next_parent(fwnode);
> 
> return count;



-- 
With Best Regards,
Andy Shevchenko


