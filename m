Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC273C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA42D20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 21:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfEGVGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 17:06:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:18304 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfEGVGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:06:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 14:06:49 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 14:06:48 -0700
Received: from khbyers-mobl2.amr.corp.intel.com (unknown [10.251.29.37])
        by linux.intel.com (Postfix) with ESMTP id 6BA21580105;
        Tue,  7 May 2019 14:06:47 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        "M, Naveen" <naveen.m@intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
 <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
 <5c42b741-5e5c-ce00-8321-59df1df115f1@linux.intel.com>
 <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <73ebe767-0371-00aa-bb0b-9cb2ba708a42@linux.intel.com>
Date:   Tue, 7 May 2019 16:06:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft5TeW1h3GAT9Gkwdf8eE_p5aoywveE2ddXgYQ+fET8Sdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> What we are missing are the PCI IDs for CML PCH-LP (0x02C8) and CML
>> PCH-H (0x06C8).
>>
>> Can we respin this patchset to add support for those last two instead of
>> just the -LP case?
> 
> Sure. So just to clarify, you want the entry for 0x02c8, and you want
> an additional entry for 0x06c8 under the same config. Will do.

I'd like both entries but with different Kconfigs (e.g. CometLake-LP and 
CometLake-H). We have one PCI ID per Kconfig so far.

>>
>> I'll send a patch to add those IDs for the HDaudio legacy driver for
>> consistency.
> 
> Actually I've got that change ready to go too, I'm happy to send that out.

I guess I beat you to it.
Thanks for reporting all this.
-Pierre
