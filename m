Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D339C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1FE21019
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbfHWPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:35:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:41957 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfHWPfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 08:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="330760037"
Received: from sdkulkar-mobl.amr.corp.intel.com (HELO [10.254.94.219]) ([10.254.94.219])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2019 08:34:58 -0700
Subject: Re: [alsa-devel] [PATCH v3 0/4] soundwire: debugfs support for 5.4
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
 <20190823063404.GB2672@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cbf39078-1ef2-f05b-e2d7-b4695299e56b@linux.intel.com>
Date:   Fri, 23 Aug 2019 10:34:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823063404.GB2672@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/19 1:34 AM, Vinod Koul wrote:
> On 21-08-19, 13:58, Pierre-Louis Bossart wrote:
>> This patchset enables debugfs support and corrects all the feedback
>> provided on an earlier RFC ('soundwire: updates for 5.4')
>>
>> There is one remaining hard-coded value in intel.c that will need to
>> be fixed in a follow-up patchset not specific to debugfs: we need to
>> remove hard-coded Intel-specific configurations from cadence_master.c
>> (PDI offsets, etc).
> 
> Applied all (i did hand edit of patch 4 to resolve dependency), thanks

Thanks for the edit, appreciate not having to resend a series.
