Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91D7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F882064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGBKxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:53:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:60493 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfGBKxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:53:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 03:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,442,1557212400"; 
   d="scan'208";a="157585477"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2019 02:59:59 -0700
Subject: Re: buildbot status?
To:     Philip Li <philip.li@intel.com>, Kalle Valo <kvalo@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Liu Yiding <yidingx.liu@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190628142859.GA4844@lst.de> <87h887qu2t.fsf@codeaurora.org>
 <20190630134944.GA22324@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <f5f5409b-eaca-d38c-bd31-c54ef69b3833@intel.com>
Date:   Tue, 2 Jul 2019 18:00:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190630134944.GA22324@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/19 9:49 PM, Philip Li wrote:
> On Sun, Jun 30, 2019 at 12:51:54PM +0300, Kalle Valo wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> Hi buildbot maintainers,
>>>
>>> lately I usually get no, in some case a few very delayed build bot
>>> results for my repos.  Is this as known issue?
>> I have the same problem, I did receive few reports on Wednesday but
>> nothing after that. I rely a lot for buildbot doing build checks on
>> wireless-drivers patches so I hope it comes back soon.
> hi Kalle and Christoph, sorry for inconvenience. We will check this as
> early as possible which may be due to certain issue in our side. +Rong
> to help check the exact problem.

Hi all,

There's a problem with the network in our side, we're trying to solve it.
Sorry for the inconvenience that may have caused to you.

Best Regards,
Rong Chen


>
>> -- 
>> Kalle Valo
