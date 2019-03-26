Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEE32075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfCZOMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:12:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:25986 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZOMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:12:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 07:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="217684249"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2019 07:12:45 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id F1CBD205E7; Tue, 26 Mar 2019 16:12:43 +0200 (EET)
Date:   Tue, 26 Mar 2019 16:12:43 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326141243.g2x44v65npw4yhw5@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
 <20190326140633.GE7049@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326140633.GE7049@kuha.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moi,

On Tue, Mar 26, 2019 at 04:06:33PM +0200, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> > > > > On ACPI based systems the resulting strings look like
> > > > > 
> > > > > 	\_SB.PCI0.CIO2.port@1.endpoint@0
> > > > > 
> > > > > where the nodes are separated by a dot (".") and the first three are
> > > > > ACPI device nodes and the latter two ACPI data nodes.
> > > > 
> > > > Do we support swnode here?
> > > 
> > > Good question. The swnodes have no hierarchy at the moment (they're only
> > > created for a struct device as a parent) and they do not have human-readable
> > > names. So I'd say it's not relevant right now. Should these two change,
> > > support for swnode could (and should) be added later on.
> > 
> > Heikki, what do you think about this?
> 
> Well, the swnodes do have hierarchy. That was kind of the whole point
> of introducing them. They now can also be named using "name" property.
> See commit 344798206f171c5abea7ab1f9762fa526d7f539d.

Right; I saw the function after initially replying to Andy but I missed
where the node name came from. :-) Now I know...

I can add support for swnode, too, if you like.

-- 
Terveisin,

Sakari Ailus
sakari.ailus@linux.intel.com
