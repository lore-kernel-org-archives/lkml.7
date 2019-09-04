Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771AEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D2521883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfIDMkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:40:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:4451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729565AbfIDMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:40:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 05:40:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194717629"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 05:39:58 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i5UZp-0000qY-7a; Wed, 04 Sep 2019 15:39:57 +0300
Date:   Wed, 4 Sep 2019 15:39:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Subject: Re: [PATCH v3 2/2] phy: intel-lgm-sdxc: Add support for SDXC PHY
Message-ID: <20190904123957.GM2680@smile.fi.intel.com>
References: <20190904062719.37462-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190904062719.37462-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904062719.37462-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:27:19PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add support for SDXC PHY on Intel's Lightning Mountain SoC.

What's the difference to eMMC PHY?
Can they share the same / similar code?

-- 
With Best Regards,
Andy Shevchenko


