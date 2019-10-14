Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EE4ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD9520854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfJNQCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:02:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:7262 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731357AbfJNQCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:02:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="199439439"
Received: from rtnitta-mobl1.amr.corp.intel.com (HELO [10.251.134.135]) ([10.251.134.135])
  by orsmga006.jf.intel.com with ESMTP; 14 Oct 2019 09:02:31 -0700
Subject: Re: [alsa-devel] [PATCH v2 0/5] soundwire: intel/cadence: better
 initialization
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <635444ee-0a7f-73ab-f0d8-a910d9f38848@linux.intel.com>
Date:   Mon, 14 Oct 2019 11:00:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916190952.32388-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/19 2:09 PM, Pierre-Louis Bossart wrote:
> V2 of the original series 'soundwire: inits and PM additions for 5.4',
> with PM additions removed since more tests on hardware are required.

Vinod, if you are back at your desk, those patches are almost a month 
old. thanks!

> 
> Changes since v1: addressed feedback from Vinod Koul
> clarified init changes impact Intel and Cadence sides
> remove unnecessary intermediate variable
> disable interrupts when exit_reset fails, updated error handling
> returned -EINVAL on debugfs invalid parameter
> 
> Pierre-Louis Bossart (5):
>    soundwire: intel/cadence: fix startup sequence
>    soundwire: cadence_master: add hw_reset capability in debugfs
>    soundwire: intel: add helper for initialization
>    soundwire: intel/cadence: add flag for interrupt enable
>    soundwire: cadence_master: make clock stop exit configurable on init
> 
>   drivers/soundwire/cadence_master.c | 131 +++++++++++++++++++++--------
>   drivers/soundwire/cadence_master.h |   5 +-
>   drivers/soundwire/intel.c          |  38 ++++++---
>   3 files changed, 126 insertions(+), 48 deletions(-)
> 
