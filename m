Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78F8216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfEHRAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:00:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:26189 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbfEHRAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:00:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:00:18 -0700
X-ExtLoop1: 1
Received: from mayalewx-mobl1.amr.corp.intel.com (HELO [10.255.230.159]) ([10.255.230.159])
  by fmsmga006.fm.intel.com with ESMTP; 08 May 2019 10:00:16 -0700
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
To:     Evan Green <evgreen@chromium.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Sathya Prakash <sathya.prakash.m.r@intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-2-evgreen@chromium.org>
 <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
 <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0d2c6330-7882-a7e5-8dcb-51eec0e845ba@linux.intel.com>
Date:   Wed, 8 May 2019 12:00:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft7PtNWzH1QYigbQvDcJwZSb7ZLWoKzurPGBnh72DYcZrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/19 11:42 AM, Evan Green wrote:
> On Tue, May 7, 2019 at 3:14 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> Minor nit-picks below. The Kconfig would work but select CANNONLAKE even
>> if you don't want it.
>>
>>>
>>> +config SND_SOC_SOF_COMETLAKE_LP
>>> +     tristate
>>> +     select SND_SOC_SOF_CANNONLAKE
>>
>> This should be
>> select SND_SOF_SOF_HDA_COMMON
> 
> You mean SND_SOC_SOF_HDA_COMMON I assume.
> Except that I also need &cnl_desc, so I need CANNONLAKE to be on as
> well. Should I select them both?

Ah I see. I'd rather use a different descriptor then, and make the two 
platforms independent, as I did for CoffeeLake. You can use the same 
descriptor for the two -H and -LP skews though.
