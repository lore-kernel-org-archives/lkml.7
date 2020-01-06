Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C2C32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF84A218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 05:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578288760;
	bh=ec9ZGMCF/7dfhER2aWnXsCMCvBv3Cw5Zbedx2vWhQ7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vIWZftnfe72FCiTQNcnMP3Rv/7bY8n8fbpgDt5sO2nCrLIQMVlS2nugsvR0uNS5Re
	 fQRknyxNA+4WZ4sMVP+4iKZmjJxTcg9Zk/AyRGdYDrT6DPvMJ0FTV3aCMpwxHcwhIT
	 fMCThbYbCF294KLmqUD6qWhs7TEnn5c7CqzR/JL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgAFFcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 00:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgAFFcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 00:32:39 -0500
Received: from localhost (unknown [117.99.94.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DEF215A4;
        Mon,  6 Jan 2020 05:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578288759;
        bh=ec9ZGMCF/7dfhER2aWnXsCMCvBv3Cw5Zbedx2vWhQ7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhGYzVtIn/DFhU30uV0fPfiiyIb3S+jFzuVyumq1Qzyg+9fMWa9IoR2Q8B12Rv2Sp
         0kha2EpCTe88rlkV225h4stHBySL8NJdkEir+Fmivx7NyzAuNSm/z7UNN+wWByBdX/
         qfmLZJXns85b1Do1rj8LQdY5lkaZ5N2vXfrq3oZA=
Date:   Mon, 6 Jan 2020 11:02:34 +0530
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
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial definitions
 for sdw_master_device
Message-ID: <20200106053234.GM2818@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
 <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
 <20191228120930.GR3006@vkoul-mobl>
 <820dbbcd-1401-4382-f5a2-9cdba1d6fcd5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820dbbcd-1401-4382-f5a2-9cdba1d6fcd5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-01-20, 11:36, Pierre-Louis Bossart wrote:

> Would this work for you if we used the following names:
> 
> sdw_slave (legacy shortcut for sdw_slave_device, which could be removed in a
> a future cleanup if desired).
> sdw_slave_driver
> sdw_master_device
> sdw_master_driver
> 
> and all the 'md' replaced by the full 'master_device'.

That does sound nicer, thanks

-- 
~Vinod
