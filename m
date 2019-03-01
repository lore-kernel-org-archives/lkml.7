Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254F22186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfCAH2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:28:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:35920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAH2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:28:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 23:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="151080343"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 23:28:12 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1gzcaZ-0002Qp-AZ; Fri, 01 Mar 2019 09:28:11 +0200
Date:   Fri, 1 Mar 2019 09:28:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Cc:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, gwendal@google.com,
        jettrink@chromium.org
Subject: Re: [PATCH v2] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Message-ID: <20190301072811.GH9224@smile.fi.intel.com>
References: <1551413171-27290-1-git-send-email-rushikesh.s.kadam@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551413171-27290-1-git-send-email-rushikesh.s.kadam@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 09:36:11AM +0530, Rushikesh S Kadam wrote:
> Integrated Sensor Hub (ISH) is also a MCU running EC
> having feature bit EC_FEATURE_ISH. Instantiate it as
> a special CrOS EC device with device name 'cros_ish'.

> v2
> - Addressed review comments to term the CrOS EC device as a generic
>   Integrated Sensor Hub. 

> +	/* The MCU is an Intel Integrated Sensor Hub */

This has to be adjusted as well. Intel ISH is just one of the example of ISHs.

> +	EC_FEATURE_ISH = 40,

-- 
With Best Regards,
Andy Shevchenko


