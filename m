Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C90C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012BC2184C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGCP0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:26:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:33813 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCP0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:26:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 08:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="172168030"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.63])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jul 2019 08:26:08 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com
Subject: Re: [GIT PULL 0/4] intel_th: Fixes for v5.2
In-Reply-To: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
References: <20190621161930.60785-1-alexander.shishkin@linux.intel.com>
Date:   Wed, 03 Jul 2019 18:26:07 +0300
Message-ID: <87sgrnta0g.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:

> Hi Greg,

Hi Greg,

> Here are the fixes I have for v5.2 cycle: two gcc warnings, one dma mapping
> issue and a new PCI ID. All issues were introduced in the same cycle, so no
> -stable involvement.
>
> All patches are aiaiai-clean. Signed git tag below. Individual patches in
> follow-up emails. Please consider pulling or applying. Thanks!

Just in case this got buried under other email.

Thanks,
--
Alex
