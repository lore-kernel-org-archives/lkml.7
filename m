Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133EC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C682147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfF1GWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:22:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:56411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfF1GWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:22:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 23:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,426,1557212400"; 
   d="scan'208";a="164573684"
Received: from mylly.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2019 23:22:32 -0700
Subject: Re: [PATCH v2 08/27] i2c: busses: remove memset after
 dmam_alloc_coherent
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Seth Heasley <seth.heasley@intel.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190628024711.15203-1-huangfq.daxian@gmail.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <f97d130f-0906-05cb-6f08-bb84bf32ff02@linux.intel.com>
Date:   Fri, 28 Jun 2019 09:22:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628024711.15203-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/28/19 5:47 AM, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dmam_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   drivers/i2c/busses/i2c-ismt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
It would be better to refer actual commit or commits that implement that 
zeroing rather than merge point in commit log if possible.

At quick look commit 518a2f1925c3 ("dma-mapping: zero memory returned 
from dma_alloc_*") is the one but I'm not really an expert here to say 
is that alone enough.

-- 
Jarkko
