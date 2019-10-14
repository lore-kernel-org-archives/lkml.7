Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D3ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF92F20673
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 07:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfJNHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 03:38:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:38717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbfJNHik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:38:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 00:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,295,1566889200"; 
   d="scan'208";a="395106498"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2019 00:38:38 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iJuw9-0002rf-DX; Mon, 14 Oct 2019 10:38:37 +0300
Date:   Mon, 14 Oct 2019 10:38:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 00/14] software node: add support for reference
 properties
Message-ID: <20191014073837.GI32742@smile.fi.intel.com>
References: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011230721.206646-1-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 04:07:07PM -0700, Dmitry Torokhov wrote:
> These series implement "references" properties for software nodes as true
> properties, instead of managing them completely separately.
> 
> The first 10 patches are generic cleanups and consolidation and
> unification of the existing code; patch #11 implements moving of small
> properties inline when copying property entries; patch #12 implements
> PROPERTY_ENTRY_REF() and friends; patch #13 converts the user of
> references to the property syntax, and patch #14 removes the remains of
> references as entities that are managed separately.

Can we get some test cases?

-- 
With Best Regards,
Andy Shevchenko


