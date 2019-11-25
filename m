Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F02C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8232073F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 00:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYA50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:57:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:32026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfKYA50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 19:57:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 16:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="scan'208";a="216815045"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2019 16:57:25 -0800
Subject: Re: [kbuild-all] Re: {standard input}:211: Error: operand out of
 range (128 is not between -128 and 127)
To:     Matthew Wilcox <willy@infradead.org>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <201911201827.kP7wux6y%lkp@intel.com>
 <20191120123050.GQ20752@bombadil.infradead.org>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <408d25ae-8e3e-dec0-bb06-a4c2c7cfeec8@intel.com>
Date:   Mon, 25 Nov 2019 08:57:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191120123050.GQ20752@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 8:30 PM, Matthew Wilcox wrote:
> On Wed, Nov 20, 2019 at 06:31:38PM +0800, kbuild test robot wrote:
>> Hi Matthew,
>>
>> FYI, the error/warning still remains.
> That's because gcc-7.4.0 is still buggy on arc.

Hi Matthew,

Thanks for clarifying, we'll take a look.

Best Regards,
Rong Chen

>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c74386d50fbaf4a54fd3fe560f1abc709c0cff4b
>> commit: 5a74ac4c4a97bd8b7dba054304d598e2a882fea6 idr: Fix idr_get_next_ul race with idr_remove
>> date:   3 weeks ago
>> config: arc-defconfig (attached as .config)
>> compiler: arc-elf-gcc (GCC) 7.4.0
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

