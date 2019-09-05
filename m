Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5851C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECBF205ED
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 23:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbfIEXF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 19:05:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:49498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfIEXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 19:05:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 16:05:57 -0700
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; 
   d="scan'208";a="334712141"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.155.245])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 16:05:56 -0700
Message-ID: <e02287479ad936142a21cbd7c6c00947ca0c5088.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/9] tools-power-x86-intel-speed-select: Fixes and
 updates for output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, David Arcari <darcari@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Sep 2019 16:05:55 -0700
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 08:03 -0400, Prarit Bhargava wrote:
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
> 
> v2: Add additional patch to fix memory leak and remove help text in
> 8/9.

For the series

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> 
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: David Arcari <darcari@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> 
> Prarit Bhargava (9):
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
>   tools/power/x86/intel-speed-select: Fix memory leak
> 
>  .../x86/intel-speed-select/isst-config.c      |  21 +--
>  .../x86/intel-speed-select/isst-display.c     | 120 +++++++++++++---
> --
>  2 files changed, 98 insertions(+), 43 deletions(-)
> 

