Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD3BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEEE02053B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfLPWee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:55889 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfLPWec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:34:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="365172648"
Received: from andresma-mobl.amr.corp.intel.com (HELO [10.252.132.232]) ([10.252.132.232])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2019 14:34:29 -0800
Subject: Re: [alsa-devel] [PATCH v4 08/15] soundwire: add initial definitions
 for sdw_master_device
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
 <20191213050409.12776-9-pierre-louis.bossart@linux.intel.com>
 <20191213072844.GF1750354@kroah.com>
 <7431d8cf-4a09-42af-14f5-01ab3b15b47b@linux.intel.com>
 <20191213161046.GA2653074@kroah.com>
 <a838eed1-9d55-d1b4-c790-22bdd0a97370@linux.intel.com>
Message-ID: <a4e918c3-8d5c-9f89-903e-a34707cb6f0e@linux.intel.com>
Date:   Mon, 16 Dec 2019 16:34:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a838eed1-9d55-d1b4-c790-22bdd0a97370@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> No, I mean the new MODULE_NAMESPACE() support that is in the kernel.
>> I'll move the greybus code to use it too, but when you are adding new
>> apis, it just makes sense to use it then as well.
> 
> ok, thanks for the pointer, will look into this.

This namespace check already saved me a lot of time. I found an issue in 
our latest code (not submitted for review yet) with a new functionality 
added to the wrong module and without the proper abstraction required...
Really nice tool, I can already see how useful it will be for on-going 
code partitioning (SOF multi-client work and virtualization support).
