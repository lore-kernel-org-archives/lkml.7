Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A89C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879B821883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfIDUGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:06:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:46333 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbfIDUGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:06:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 13:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="184012957"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga007.fm.intel.com with ESMTP; 04 Sep 2019 13:06:29 -0700
Message-ID: <e6390a656dfd29b114b1e0659e3db169344cfa81.camel@linux.intel.com>
Subject: Re: [PATCH 0/8] tools-power-x86-intel-speed-select: Fixes and
 updates for output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 13:06:29 -0700
In-Reply-To: <20190903153734.11904-1-prarit@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 11:37 -0400, Prarit Bhargava wrote:
> Some general fixes and updates for intel-speed-select.  Fixes include
> some
> typos as well as an off-by-one cpu count reporting error.  Updates
> for the
> output are
> 
> - switching to MHz as a standard
> - reporting CPU frequencies instead of ratios as a standard
> - viewing a human-readable CPU list.
> - avoiding reporting "0|1" as success|fail as these can be confusing
> for a
>   user.
Series looks fine, except 8/8.
So please submit v2. Better to resubmit as a series as v2, unless Andy
has other preference.

Thanks,
Srinivas

> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> 
> Prarit Bhargava (8):
>   tools/power/x86/intel-speed-select: Fix package typo
>   tools/power/x86/intel-speed-select: Fix help option typo
>   tools/power/x86/intel-speed-select: Fix cpu-count output
>   tools/power/x86/intel-speed-select: Simplify output for turbo-freq
> and
>     base-freq
>   tools/power/x86/intel-speed-select: Switch output to MHz
>   tools/power/x86/intel-speed-select: Change turbo ratio output to
>     maximum turbo frequency
>   tools/power/x86/intel-speed-select: Output human readable CPU list
>   tools/power/x86/intel-speed-select: Output success/failed for
> command
>     output
> 
>  .../x86/intel-speed-select/isst-config.c      |   4 +-
>  .../x86/intel-speed-select/isst-display.c     | 116 ++++++++++++--
> ----
>  2 files changed, 83 insertions(+), 37 deletions(-)
> 

