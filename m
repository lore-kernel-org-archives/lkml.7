Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF080C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BAF217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565420627;
	bh=kpJbuK0jBthEnD9QvJbFCUekPzZ5HRLa9DcGPAd+Xic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+Hez6UMNQ8N5XW6dwpzYJDTgTgwWOxr4eL5N1IsxKJqruLnq4tw2aMBfpT234UL5
	 gSbWq/wJdZIAFsVAEc2NslMh2sdlI/ZpuK9txm5CwDDspyaMVXcs4XFc9f5FENHVss
	 bhlNpIseIAq8SdQyihLVKsEFGQjDSh4AEk9mDyY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfHJHDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 03:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfHJHDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 03:03:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D87208C3;
        Sat, 10 Aug 2019 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565420625;
        bh=kpJbuK0jBthEnD9QvJbFCUekPzZ5HRLa9DcGPAd+Xic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5JhwW5Cd9gJMKJxx9uQBx/RWuXc/MVM/qwMYY7yUWRmWpfS6jmcf6vLmVMLLTbRr
         sSiO0Gk+ahIV2bU2Gn/yz3gUi51fxsAIVUUzsHWlzj9ZER32kguQkXM2mA6Q2wrZwc
         DQqBb+DcQB3OUgzqSgrfT9WKeImamaRjJaPGA5Ko=
Date:   Sat, 10 Aug 2019 09:03:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 3/3] soundwire: intel: add debugfs register dump
Message-ID: <20190810070343.GC6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:43:41PM -0500, Pierre-Louis Bossart wrote:
> @@ -885,6 +996,8 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_dai;
>  	}
>  
> +	intel_debugfs_init(sdw);

See, make patch 1/3 work the same like this.  It's much cleaner.

thanks,

greg k-h
