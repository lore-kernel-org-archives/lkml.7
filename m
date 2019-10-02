Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A25C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C75218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfJBHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:55:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:2269 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfJBHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:55:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 00:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,573,1559545200"; 
   d="scan'208";a="205273107"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2019 00:55:32 -0700
Date:   Wed, 2 Oct 2019 10:55:31 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc-fixes
 tree
In-Reply-To: <20191002082904.4eef7f15@canb.auug.org.au>
Message-ID: <alpine.DEB.2.21.1910021043590.16459@zeliteleevi>
References: <20191002082904.4eef7f15@canb.auug.org.au>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2 Oct 2019, Stephen Rothwell wrote:

> In commit
> 
>   e66e52c5b742 ("ASoC: SOF: pcm: fix resource leak in hw_free")
> 
> Fixes tag
> 
>   Fixes: c29d96c3b9b4 ("ASoC: SOF: reset DMA state in prepare")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: 04c8027764bc ("ASoC: SOF: reset DMA state in prepare")

yes, you are correct. This was a mistake in original patch submission, 
which had a fixes SHA1 pointing to the patch SOF project's git tree and 
not the merged patch.

Br, Kai
