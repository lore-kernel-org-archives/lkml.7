Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38356C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1062722CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567578921;
	bh=fX0AE40pfxtbRZ5P+J2OtsTCuel/OpN/4yspy4TH4pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fi98b/pbgTEa9dX5oTLLQnUvQ8MR/yMeJ/XRJ3FHZneCaQHf2LqcTnTs23KGopGAL
	 5sOo/p+RM7vAczj2LqEyN38jQT+tvCdnOkPXobRMDUtxctORSI5C8jjr9lI4IWdGrU
	 ZYby4MZR1wrMVlD4MNaoqmQSM6d5iscc5GmNjmZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfIDGfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDGfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:35:20 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AFF2087E;
        Wed,  4 Sep 2019 06:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567578919;
        bh=fX0AE40pfxtbRZ5P+J2OtsTCuel/OpN/4yspy4TH4pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRQY8Pf6YpUV//wJzt3ZA6wEV276BQDhJszhb7paLxspZ8oE4twpu3EPeQOlVy6hp
         AyDlvIg6SYnEseAhudnCHQS/PNH+Qx+hn7N8sFsethMwx5WW8pzlf50MKcAoh/pfy0
         KJKg7UxdRViS7qn5hNcfJ7oyLLrbsMCXHKoScEh0=
Date:   Wed, 4 Sep 2019 12:04:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        gregkh@linuxfoundation.org, Blauciak@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: set initial value to port_status
Message-ID: <20190904063410.GH2672@vkoul-mobl>
References: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-08-19, 02:11, Bard liao wrote:
> From: Bard Liao <yung-chuan.liao@linux.intel.com>
> 
> port_status[port_num] are assigned for each port_num in some if
> conditions. So some of the port_status may not be initialized.

Applied, thanks

-- 
~Vinod
