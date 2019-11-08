Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF369C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A7620650
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfKHU0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:26:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:8482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKHU0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:26:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2019 12:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,283,1569308400"; 
   d="scan'208";a="201449763"
Received: from guptas2-mobl.ger.corp.intel.com ([10.251.82.217])
  by fmsmga008.fm.intel.com with ESMTP; 08 Nov 2019 12:26:49 -0800
Message-ID: <4d607c661be2459f005d2cd6329c779f09d31fa9.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 1/4] soundwire: sdw_slave: add new fields
 to track probe status
From:   Liam Girdwood <liam.r.girdwood@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Date:   Fri, 08 Nov 2019 20:26:46 +0000
In-Reply-To: <e3e10c25-84dc-f4e7-e94b-d18493450021@linux.intel.com>
References: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
         <20191023210657.32440-2-pierre-louis.bossart@linux.intel.com>
         <20191103045604.GE2695@vkoul-mobl.Dlink>
         <f53b28bb-1ec7-a400-54ed-51fd55819ecd@linux.intel.com>
         <20191108042940.GW952516@vkoul-mobl>
         <e3e10c25-84dc-f4e7-e94b-d18493450021@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-08 at 08:55 -0600, Pierre-Louis Bossart wrote:
> Please start with the patches "soundwire: code hardening and 
> suspend-resume support" and come back to this interface description when 
> you have reviewed these changes. It's not detective work, it's working 
> around the consequences of having separate trees for Audio and SoundWire.

Separate trees seem to be clearly not working well for everyone
atm. I'm reading the discomfort on all sides here.

Vinod, how often do you merge on ALSA/ASoC ? Would it not make more
sense to be part of ALSA to ease workflow (including yours) ? 

This model worked well for soundwire's predecessors (AC97 and HDA)
which like soundwire were primarily audio busses with secondary non
audio features.

Liam

