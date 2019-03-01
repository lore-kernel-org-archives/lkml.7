Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29702C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE62087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfCAInU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:43:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:55097 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfCAInT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:43:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 00:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="324446339"
Received: from rajeev-desktop.iind.intel.com (HELO intel.com) ([10.223.84.39])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2019 00:43:16 -0800
Date:   Fri, 1 Mar 2019 14:12:34 +0530
From:   Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, gwendal@google.com,
        jettrink@chromium.org
Subject: Re: [PATCH v2] mfd: cros_ec: instantiate properly CrOS ISH MCU device
Message-ID: <20190301084234.GA632@intel.com>
References: <1551413171-27290-1-git-send-email-rushikesh.s.kadam@intel.com>
 <20190301072811.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301072811.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

On Fri, Mar 01, 2019 at 09:28:11AM +0200, Andy Shevchenko wrote:
> On Fri, Mar 01, 2019 at 09:36:11AM +0530, Rushikesh S Kadam wrote:
> > Integrated Sensor Hub (ISH) is also a MCU running EC
> > having feature bit EC_FEATURE_ISH. Instantiate it as
> > a special CrOS EC device with device name 'cros_ish'.
> 
> > v2
> > - Addressed review comments to term the CrOS EC device as a generic
> >   Integrated Sensor Hub. 
> 
> > +	/* The MCU is an Intel Integrated Sensor Hub */
> 
> This has to be adjusted as well. Intel ISH is just one of the example of ISHs.

Thanks for the catch

I submitted v3 with this fixed

Regards
Rushikesh

> 
> > +	EC_FEATURE_ISH = 40,
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
