Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D68C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBB72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLMJfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:35:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:18091 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfLMJfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:35:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 01:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600"; 
   d="scan'208";a="265486366"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2019 01:35:01 -0800
Received: from andy by smile with local (Exim 4.93-RC7)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ifhLh-000678-CA; Fri, 13 Dec 2019 11:35:01 +0200
Date:   Fri, 13 Dec 2019 11:35:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alex.hung@canonical.com, linux-acpi@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        charles.d.prestopine@intel.com, dvhart@infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v1 2/4] acpi: fan: Add new Tiger Lake hardware ID to
 support fan driver in acpi
Message-ID: <20191213093501.GP32742@smile.fi.intel.com>
References: <cover.1576189376.git.gayatri.kammela@intel.com>
 <68c6a37a5fcce792de61c4a0adcce0b83694e8d0.1576189376.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68c6a37a5fcce792de61c4a0adcce0b83694e8d0.1576189376.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:37:18PM -0800, Gayatri Kammela wrote:

>  	{"PNP0C0B", 0},
>  	{"INT3404", 0},
> +	{"INT1044", 0},

Same comment here.

-- 
With Best Regards,
Andy Shevchenko


