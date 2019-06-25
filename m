Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AE2C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34982085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfFYNCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:02:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:36148 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbfFYNCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:02:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 06:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="184480030"
Received: from pbossart-mobl3.igk.intel.com (HELO [10.237.142.180]) ([10.237.142.180])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jun 2019 06:02:11 -0700
Subject: Re: [alsa-devel] [PATCH v2 00/11] Fix driver reload issues
To:     Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
 <20190625120450.GR5316@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f50433de-279a-cbc8-d91f-4e3a04bae450@linux.intel.com>
Date:   Tue, 25 Jun 2019 08:02:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625120450.GR5316@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/19 7:04 AM, Mark Brown wrote:
> On Mon, Jun 17, 2019 at 01:36:33PM +0200, Amadeusz Sławiński wrote:
>> Hi,
>>
>> This series of patches introduces fixes to various issues found while
>> trying to unload all snd* modules and then loading them again. This
>> allows for modules to be really _modules_ and be unloaded and loaded on
>> demand, making it easier to develop and test them without constant
>> system reboots.
> 
> Pierre?  You did comment on the general concept in one of the patches
> but not on any of the patches directly.

I did review the patches internally and the v1. For the v2 I could only 
do an airport lounge review and didn't see any blatant issues, so feel 
free to take the following tag for the series.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>



