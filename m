Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D1C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90534214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfHVHXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:23:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:6996 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfHVHXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:23:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="378408813"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.36.176])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 00:23:39 -0700
Date:   Thu, 22 Aug 2019 09:23:39 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Message-ID: <20190822072338.GA30465@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822071835.GA30262@ubuntu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 09:18:35AM +0200, Guennadi Liakhovetski wrote:

[snip]

> >  static int hda_sdw_init(struct snd_sof_dev *sdev)
> >  {
> >  	acpi_handle handle;
> > @@ -67,6 +131,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
> >  	res.mmio_base = sdev->bar[HDA_DSP_BAR];
> >  	res.irq = sdev->ipc_irq;
> >  	res.parent = sdev->dev;
> > +	res.ops = &sdw_callback;
> > +	res.arg = sdev;
> >  
> >  	sdw = sdw_intel_init(handle, &res);
> >  	if (!sdw) {
> 
> Hm, looks like this function is using spaces for indentation... Let me check 
> if this is coming from an earlier patch

Ouch, it's mutt or whatever editor it's using... Sorry for the noise.

Thanks
Guennadi
