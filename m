Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE0C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6F121773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfC1Lvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:51:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:59026 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbfC1Lvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:51:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 04:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138127205"
Received: from pmangere-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.62.244])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 04:51:45 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id C234B21E50; Thu, 28 Mar 2019 13:51:42 +0200 (EET)
Date:   Thu, 28 Mar 2019 13:51:42 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
Message-ID: <20190328115142.k75ijhviovhly25g@kekkonen.localdomain>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
 <20190326124106.27694-7-sakari.ailus@linux.intel.com>
 <c08956873f4dfd7dc8bd918bf59443de9c2c7b33.camel@perches.com>
 <20190328114845.giusyarjibvg5ru7@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328114845.giusyarjibvg5ru7@kekkonen.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:48:45PM +0200, Sakari Ailus wrote:
> I actually intended to leave this --- it points to anyone accidentally
> trying to use %pf to what it needs to be replaced with. But the Deprecated
> should be replaced with Invalid (i.e. remove that assignment).

This is actually already a part of an earlier patch, "[PATCH v2 4/6]
lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps".

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
