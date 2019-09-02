Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C2C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3C621881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 07:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfIBHGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 03:06:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:20176 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfIBHGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 03:06:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:06:04 -0700
X-IronPort-AV: E=Sophos;i="5.64,457,1559545200"; 
   d="scan'208";a="382716611"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 00:06:02 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 835B020B09; Mon,  2 Sep 2019 10:05:30 +0300 (EEST)
Date:   Mon, 2 Sep 2019 10:05:30 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/10] device property: Add functions for accessing
 node's parents
Message-ID: <20190902070530.GC5475@paasikivi.fi.intel.com>
References: <20190829101043.24963-4-sakari.ailus@linux.intel.com>
 <20190829104401.24183-1-sakari.ailus@linux.intel.com>
 <20190830124235.GD2680@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830124235.GD2680@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 03:42:35PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 29, 2019 at 01:44:01PM +0300, Sakari Ailus wrote:
> > Add two convenience functions for accessing node's parents:
> > 
> > fwnode_count_parents() returns the number of parent nodes a given node
> > has. fwnode_get_nth_parent() returns node's parent at a given distance
> > from the node itself.
> > 
> > Also reorder fwnode_get_parent() in property.c according to the same order
> > as in property.h.
> 
> Same comment as per previous version.

Same answer as on previous version. :^)

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
