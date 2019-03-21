Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83437C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C96C21916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfCUQb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:31:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:43900 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbfCUQb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:31:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 09:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="329400519"
Received: from plaxmina-desktop.iind.intel.com ([10.66.245.186])
  by fmsmga006.fm.intel.com with ESMTP; 21 Mar 2019 09:31:54 -0700
Date:   Thu, 21 Mar 2019 22:01:33 +0530
From:   "Bharadiya,Pankaj" <pankaj.laxminarayan.bharadiya@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Message-ID: <20190321163132.GA18985@plaxmina-desktop.iind.intel.com>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
 <20190321123156.GB5684@sirena.org.uk>
 <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
 <20190321140948.GD5684@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321140948.GD5684@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 02:09:48PM +0000, Mark Brown wrote:
> On Thu, Mar 21, 2019 at 08:59:55AM -0500, Pierre-Louis Bossart wrote:
> > On 3/21/19 7:31 AM, Mark Brown wrote:
> > > On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:
> 
> > > This is very non-obvious - it's not at all clear why we'd need the text
> > > to free controls.  If there is an issue here it seems like it'd be
> > > better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
> > > being NULL, that will be clearer and also avoid potential issues with
> > > other callers.
> 
> > I believe the issue is real, but you need to look at the entire code to figure it out
> 
> Yeah, I'm fairly sure there's an actual issue here - it's just that the
> fix is obscure and feels fragile.

Will fix it in snd_soc_dapm_free_kcontrol() and submit a new patch..

Thanks,
Pankaj

