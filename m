Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46DFC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AFC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbfHONI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:08:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:8011 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbfHONI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:08:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 06:08:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="171105628"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.122]) ([10.237.72.122])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 06:08:26 -0700
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal
 clock setup
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
 <20190812225611.GA30758@people.danlj.org>
 <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
 <20190815120432.GA20438@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d13043b2-8945-7fda-2e67-2da592d681dd@intel.com>
Date:   Thu, 15 Aug 2019 16:07:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815120432.GA20438@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/19 3:04 PM, Michael K. Johnson wrote:
> On Thu, Aug 15, 2019 at 02:27:44PM +0300, Adrian Hunter wrote:
>> On 13/08/19 1:56 AM, Michael K. Johnson wrote:
>>> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
>>> setup as part of the internal clock setup as described in 3.2.1 Internal
>>> Clock Setup Sequence of SD Host Controller Simplified Specification
>>> Version 4.20.  This changes the timeouts to the new specification of
>>> 150ms for each step and is documented as safe for "prior versions which
>>> do not support PLL Enable."
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
>>
>> Did you mean for this patch to be "From:" Ben Chuang because otherwise
>> "Co-developed-by" the author is redundant.
> 
> Ben wrote the code and is the primary author. I helped with some
> changes to bring it closer to normal style, so I have definitely
> been a secondary co-developer. Ben's corporate email server adds a
> generic confidentiality notice outside his control, and we were
> informed that with that header on the email the patches could not
> be accepted.  We developed it in a git repository, so that I have
> not been "tainted" by the automatic confidentiality notice, and
> at Ben's request I have posted the work. To credit me as primary
> author would be fundamentally incorrect.
> 
> Are you saying that this work cannot be accepted until Ben chooses
> an alternative email provider besides his corporate email in order
> to avoid the spurious confidentiality notice, such that he is the
> sender of the email?
> 

No, there should be a "From:" line.  Here's an example:

	https://marc.info/?l=linux-mmc&m=155966548112475&q=raw

If you had committed your changes with Ben as the author (git commit
--author) then "git format-patch" would have added the correct "From:" line.
