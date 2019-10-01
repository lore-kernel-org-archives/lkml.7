Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11083C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4683215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfJAJjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:39:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:5346 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfJAJjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:39:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:39:39 -0700
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="181637049"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:39:37 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, rodrigo.vivi@intel.com,
        joonas.lahtinen@linux.intel.com
Subject: Re: DDC on Thinkpad x220
In-Reply-To: <20190930184707.GA5703@amd>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190930184707.GA5703@amd>
Date:   Tue, 01 Oct 2019 12:39:34 +0300
Message-ID: <87eezwdctl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Sep 2019, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> Thinkpad X220 should be new enough machine to talk DDC to the
> monitors, right? And my monitor has DDC enable/disable in the menu, so
> it should support it, too...
>
> But I don't have /dev/i2c* and did not figure out how to talk to the
> monitor. Is the support there in the kernel? What do I need to enable
> it?

# modprobe i2c-dev

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
