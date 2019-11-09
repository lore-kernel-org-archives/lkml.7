Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEDA2196F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573298112;
	bh=+Uo6rk00iqR1/CTLP0DUqCBhv4xrbNgtArL3NrHybps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KzwjpZAlrFaH5IaHFHCN92Ox+01sR+DOUJwUcXrnoFeLkT1ZHuF1li68+LDqjzKM3
	 VMfcJ9+dX7skI9M4+Bt8dkxO+SWLnq23rYI34az+7EBvxXSLmDc2PfCbgFCWFAC+zQ
	 fMaKX/4RDzVkxo8j0MW750rJ12PwvKhV2zTOrtrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKILPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 06:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfKILPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 06:15:11 -0500
Received: from localhost (unknown [122.167.114.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58000207FF;
        Sat,  9 Nov 2019 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573298110;
        bh=+Uo6rk00iqR1/CTLP0DUqCBhv4xrbNgtArL3NrHybps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRrJRW/2zCVDQYmhWCzmTkMTd3htBODq/582NTvloiY4Pw82+dSLg8SV77rF/nJZF
         FWodxwiC49XRxjoPwPZeVYgbl+8gxreUvFKMxWqw+Nnej/QJEMuoJmgt91A2Sd1hJ9
         skL0gfo+QxIKNMfq4pYEBQfBi+7VwdCIkJuEh1+A=
Date:   Sat, 9 Nov 2019 16:45:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: intel: fix PDI/stream mapping for Bulk
Message-ID: <20191109111500.GC952516@vkoul-mobl>
References: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022232948.17156-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:29, Pierre-Louis Bossart wrote:
> The previous formula is incorrect for PDI0/1, the mapping is not
> linear but has a discontinuity between PDI1 and PDI2.
> 
> This change has no effect on PCM PDIs (same mapping).

Applied now

-- 
~Vinod
