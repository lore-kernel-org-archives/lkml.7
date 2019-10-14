Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D02C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C96821835
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbfJNQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:02:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:7262 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732813AbfJNQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:02:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="199439459"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135]) ([10.251.134.135])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 09:02:33 -0700
Subject: Re: [alsa-devel] [PATCH 0/6] soundwire: intel/cadence: simplify PDI
 handling
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9be43d87-de80-ca8f-d6f7-53879540675a@linux.intel.com>
Date:   Mon, 14 Oct 2019 11:01:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/19 2:23 PM, Pierre-Louis Bossart wrote:
> These patches were originally submitted as '[RFC PATCH 00/11]
> soundwire: intel: simplify DAI/PDI handling'. There were no comments
> received.
> 
> This series only provides the PDI changes, which makes it simpler to
> review. The DAI changes will be provided with the complete series for
> ASoC/SOF integration, which is a larger change.

Vinod, if you are back at your desk, those patches are almost a month 
old. thanks!

> 
> Bard Liao (3):
>    soundwire: intel: fix intel_register_dai PDI offsets and numbers
>    soundwire: intel: remove playback/capture stream_name
>    soundwire: cadence_master: improve PDI allocation
> 
> Pierre-Louis Bossart (3):
>    soundwire: remove DAI_ID_RANGE definitions
>    soundwire: cadence/intel: simplify PDI/port mapping
>    soundwire: intel: don't filter out PDI0/1
> 
>   drivers/soundwire/cadence_master.c | 158 +++++++----------------------
>   drivers/soundwire/cadence_master.h |  34 ++-----
>   drivers/soundwire/intel.c          | 155 ++++++----------------------
>   include/linux/soundwire/sdw.h      |   3 -
>   4 files changed, 73 insertions(+), 277 deletions(-)
> 
