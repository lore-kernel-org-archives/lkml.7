Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACFAC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284A02072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 00:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgAFAmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 19:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:14491 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgAFAmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 19:42:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 16:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,400,1571727600"; 
   d="scan'208";a="210634382"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2020 16:42:49 -0800
Subject: Re: [block] f216fdd77b:
 BUG:kernel_reboot-without-warning_in_boot_stage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191208153922.GI32275@shao2-debian>
 <20191209073152.GA14094@lst.de>
 <a67a0920-472f-7f86-299a-097bc2986a1c@intel.com>
 <20191209083637.GA15038@lst.de>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <b65813c2-5be1-224b-3094-b067f8f2e7f1@intel.com>
Date:   Mon, 6 Jan 2020 08:42:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191209083637.GA15038@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/19 4:36 PM, Christoph Hellwig wrote:
> On Mon, Dec 09, 2019 at 04:08:56PM +0800, Rong Chen wrote:
>> Hi Christoph,
>>
>> Kernel boot failed in early stage with commit "f216fdd77b":
> Well, this config (plus enabling virtio for real) boots just fine for
> me.  There is nothing in your dmesgs, which makes me assume the boot
> stage means really early?  Nothing touched in this commit is involved
> in the very early boot path, though.

Hi Christoph,

Sorry for the inconvenience, it should be a false positive,
but we haven't figure it out yet.

Best Regards,
Rong Chen
