Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF96FC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB132086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfHPL1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:27:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:16195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfHPL1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:27:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 04:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="377387511"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2019 04:26:46 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hyaNY-0008EG-8g; Fri, 16 Aug 2019 14:26:44 +0300
Date:   Fri, 16 Aug 2019 14:26:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, jay.dolan@accesio.com,
        hslester96@gmail.com, je.yen.tam@ni.com, lkp@intel.com,
        kai.heng.feng@canonical.com, heikki.krogerus@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Message-ID: <20190816112644.GF30120@smile.fi.intel.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:27:29PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
> IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
> only support IO.

We have 8250_fintek.
Isn't it a right place to add these?

-- 
With Best Regards,
Andy Shevchenko


