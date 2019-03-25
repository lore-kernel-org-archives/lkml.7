Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D60BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254A420811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfCYKFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:05:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:37103 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfCYKFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:05:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="125635425"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 25 Mar 2019 03:05:03 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Mar 2019 12:05:02 +0200
Date:   Mon, 25 Mar 2019 12:05:02 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: acpi: Add an example for PRP0001
Message-ID: <20190325100502.GG3622@lahna.fi.intel.com>
References: <20190322134705.27994-1-thomas.preston@codethink.co.uk>
 <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0isa7x+XPAregcKtMxtgsNw43JuBhGB_1x3eHkvaV8HRg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:31:13AM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 22, 2019 at 2:47 PM Thomas Preston
> <thomas.preston@codethink.co.uk> wrote:
> >
> > Add an example for the magic PRP0001 device ID which allows matching
> > ACPI devices against drivers using OF Device Tree compatible property.
> > It wasn't clear to me that PRP0001 could be used in _CID.
> 
> Mika, Andy, can you have a look at this, please?

Looks good to me.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
