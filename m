Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484DAC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C301207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFFI3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:29:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:4563 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfFFI3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:29:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 01:29:14 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2019 01:29:12 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.2: display corruption on X60, X220
In-Reply-To: <20190603074004.GA15821@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190603074004.GA15821@amd>
Date:   Thu, 06 Jun 2019 11:32:18 +0300
Message-ID: <87v9xj15d9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jun 2019, Pavel Machek <pavel@ucw.cz> wrote:
> In recent kernels (5.2.0-rc1-next-20190522, 5.2-rc2) I'm getting
> display corruption in X. Usually in terminals, but also in title bars
> etc. Black areas with white lines in them, usually...
>
> Same configuration worked properly in ... probably 4.19? Then I got
> some graphics-crashes on X220 that prevented me from testing :-(.

It's pretty hard to say anything based on the above.

Anything in the logs with drm.debug=14 added?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
