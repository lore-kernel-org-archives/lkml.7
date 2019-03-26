Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEFD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfCZOJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:09:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:29479 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfCZOJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:09:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 07:09:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="158528047"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2019 07:09:06 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id C8063205E7; Tue, 26 Mar 2019 16:09:05 +0200 (EET)
Date:   Tue, 26 Mar 2019 16:09:05 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 5/5] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190326140905.xmdipix35a5rdmiy@paasikivi.fi.intel.com>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-6-sakari.ailus@linux.intel.com>
 <20190322172114.GY9224@smile.fi.intel.com>
 <20190324181745.vgckevapfwi7mul7@mara.localdomain>
 <20190326131353.GY9224@smile.fi.intel.com>
 <20190326133947.pbniwkvszlahw3dr@paasikivi.fi.intel.com>
 <20190326135557.GD9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326135557.GD9224@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 26, 2019 at 03:55:57PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 03:39:47PM +0200, Sakari Ailus wrote:
> > On Tue, Mar 26, 2019 at 03:13:53PM +0200, Andy Shevchenko wrote:
> > > On Sun, Mar 24, 2019 at 08:17:46PM +0200, Sakari Ailus wrote:
> 
> > > The patch series by Petr I mentioned takes care about OF case. But it doesn't
> > > have covered yours by obvious reasons.
> > 
> > Do you happen to have a pointer to it?
> 
> Petr, can you share what is the state of affairs with that series?
> 
> > The behaviour on others is different indeed, you're generally printing a
> > single item at a time. The question rather is, whether we want to be
> > compatible with %pOF going forward or not. I'd prefer that, so using the
> > fwnode API would be easier.
> 
> I would prefer to mimic %pOF and actually to deprecate it in favour of %pfw.
> But it's just mine opinion. I'm skeptical about getting support on it.

IMHO code that only deals with OF specifically is better to continue to use
%pOF. You'd have of_fwnode_handle() in places where you just had the name
of the node previously.

What could be done though is to unify the implementations; that's something
which the set does a little of already.

Cc Rob, too.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
