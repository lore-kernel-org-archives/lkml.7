Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F532084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571916372;
	bh=NDsl/4tXkq4rM0GucLThcaVbN8qZgwhPUuL+6WnfcRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CXeiOpMId5J+QRKAzJwgqALKJTG0NE9eFldcvC1WJx6+HtLQIH7AyJvDGGaNWGB8P
	 nEDxq2kMZAwoJkT3XWbCrft7LLwnoO8uOhHWRlxsMOcJcTZHBxV76d4Zse/zdtVaEE
	 JUv59u+0yTzdjIf2Z/uZG8mV3OfowsHAKZ1ZGgsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438963AbfJXL0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 07:26:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436501AbfJXL0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 07:26:11 -0400
Received: from localhost (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BA020856;
        Thu, 24 Oct 2019 11:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571916370;
        bh=NDsl/4tXkq4rM0GucLThcaVbN8qZgwhPUuL+6WnfcRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qbw0P9jLSv32Z8eS2uhpkB59VU+U+Zdgd93jznEQr8o1ofW/RrGg0s5xxSO2guwjL
         QD6e1XUmUAIrZn4YOjG8/n20ywxnVTRwgVAv5Utd6YdywroQngMY60Yh3aRB0lXPmD
         j5T+ubKEEs2gw5+byuDpUvtQgJXKh88T/6oq8HKU=
Date:   Thu, 24 Oct 2019 16:56:04 +0530
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
Subject: Re: [PATCH] soundwire: slave: fix scanf format
Message-ID: <20191024112604.GB2620@vkoul-mobl>
References: <20191022233147.17268-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022233147.17268-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-19, 18:31, Pierre-Louis Bossart wrote:
> fix cppcheck warning:
> 
> [drivers/soundwire/slave.c:145]: (warning) %x in format string (no. 1)
> requires 'unsigned int *' but the argument type is 'signed int *'.

Applied, thanks

-- 
~Vinod
