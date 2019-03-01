Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88383C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5837F218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbfCAIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:12:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:50905 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCAIMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:12:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Mar 2019 00:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,426,1544515200"; 
   d="scan'208";a="128172569"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by fmsmga008.fm.intel.com with ESMTP; 01 Mar 2019 00:12:44 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v1 0/7] stm class/intel_th: Updates for v5.1
In-Reply-To: <20190221161318.GC25800@kroah.com>
References: <20190221155006.76832-1-alexander.shishkin@linux.intel.com> <20190221161318.GC25800@kroah.com>
Date:   Fri, 01 Mar 2019 10:12:43 +0200
Message-ID: <87k1hjau84.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Feb 21, 2019 at 05:49:59PM +0200, Alexander Shishkin wrote:
>> Hi Greg,
>> 
>> Second attempt. Added stable CC and Fixes tags to fixes.
>> 
>> Here are the STM and Intel TH changes that I have for v5.1. Nothing big,
>> a few fixes that are too late for the v5.0 and a few minor cleanups and
>> a documentation update. All sparse/smatch/coccinelle/cppcheck/checkpatch
>> clean as usual, courtesy of aiaiai.
>> Individual patches follow. Please consider pulling or applying. Thanks!
>> 
>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>> 
>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>> 
>> are available in the Git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm.git tags/intel_th-stm-for-greg-20190221
>
> Much better, thanks, pulled and pushed out.

This is super embarrassing, but 5/7 in this set has an off-by-one. A fix
is headed to your inbox [1]. Will do better next time!

[1] https://marc.info/?l=linux-kernel&m=155142781026182

Thanks,
--
Alex
