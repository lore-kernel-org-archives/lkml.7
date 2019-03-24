Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD933C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8710F2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfCXST4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:19:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:42785 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXSTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:19:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 11:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="154747209"
Received: from pnass-mobl.ger.corp.intel.com (HELO mara.localdomain) ([10.249.136.221])
  by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2019 11:19:53 -0700
Received: from sailus by mara.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1h87ip-0000I4-LY; Sun, 24 Mar 2019 20:19:51 +0200
Date:   Sun, 24 Mar 2019 20:19:45 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] device property: Add fwnode_get_name for returning
 the name of a node
Message-ID: <20190324181945.m3ttecgj3cwwp2t5@mara.localdomain>
References: <20190322152930.16642-1-sakari.ailus@linux.intel.com>
 <20190322152930.16642-3-sakari.ailus@linux.intel.com>
 <7b29c2ef-c74b-e94d-6add-88c5db34dce7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b29c2ef-c74b-e94d-6add-88c5db34dce7@infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sun, Mar 24, 2019 at 10:21:17AM -0700, Randy Dunlap wrote:
> > + * @fwnode - The firmware node
> 
> s/-/:/

Yes, indeed.

Thanks!

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
