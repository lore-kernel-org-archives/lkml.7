Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFACC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6741F205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEFP2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:28:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:28010 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfEFP2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:28:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 08:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="297588037"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2019 08:28:36 -0700
Received: from slaugust-mobl.amr.corp.intel.com (unknown [10.254.21.102])
        by linux.intel.com (Postfix) with ESMTP id CDA2558010A;
        Mon,  6 May 2019 08:28:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
 <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
 <20190506044012.GM14916@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9f63f0dc-e4ce-bcdc-bee4-d12ebd3aa369@linux.intel.com>
Date:   Mon, 6 May 2019 10:28:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506044012.GM14916@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/19 11:40 PM, Mark Brown wrote:
> On Fri, May 03, 2019 at 09:32:53AM -0500, Pierre-Louis Bossart wrote:
> 
>> As I mentioned it'll compile the bus even if there is no user for it, but
>> it's your call: alignment or optimization.
> 
> You can have both.  Alignment is a requirement.  If you want to optimize
> this then it'd be better to optimize all the bus types rather than just
> having the one weird bus type that does something different for no
> documented reason.

Fine, I'll align if this is the requirement.
Thanks for the feedback.
