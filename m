Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3457C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4C5218BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 02:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfHTCcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 22:32:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:61411 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfHTCcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 22:32:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 19:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="178050985"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by fmsmga008.fm.intel.com with ESMTP; 19 Aug 2019 19:32:51 -0700
Subject: Re: [RFC PATCH 08/15] drivers/acrn: add VM memory management for ACRN
 char device
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jason Chen CJ <jason.cj.chen@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
 <1565922356-4488-9-git-send-email-yakui.zhao@intel.com>
 <20190816124757.GW1974@kadam>
 <8b909c22-3873-2b5d-4845-1fee1a5d81ce@intel.com>
 <20190819073958.GC4451@kadam>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <1896e9f8-7947-3c7a-4328-ddbdeee892e3@intel.com>
Date:   Tue, 20 Aug 2019 10:25:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190819073958.GC4451@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年08月19日 15:39, Dan Carpenter wrote:
> On Mon, Aug 19, 2019 at 01:32:54PM +0800, Zhao, Yakui wrote:
>> In fact as this driver is mainly used for embedded IOT usage, it doesn't
>> handle the complex cleanup when such error is encountered. Instead the clean
>> up is handled in free_guest_vm.
> 
> A use after free here seems like a potential security problem.  Security
> matters for IoT...  :(

Thanks for pointing out the issue.
The cleanup will be considered carefully.

> 
> regards,
> dan carpenter
> 
