Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB91C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2820842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565676420;
	bh=k18Vm3ai25X4rDVxWuyFZQotI4xt6Ufw+xHlCRt3JCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JzItNFpIuB4g0enc0XlXkRej1WDXoX0YeB9E4TGvw3F4r+IglBAx+kH9aqwU6qgNR
	 MdR0c65KjRt0/bbUdrqn9B4MiJ/JoRD2y5TIbkhAE0MTRVoFj4js353ieuDQDUKW4d
	 OSdDBLkMjvHdCK7UKlHTwHJeni93C/GMpewhtUXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHMGG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfHMGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:06:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 625DA206C2;
        Tue, 13 Aug 2019 06:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676417;
        bh=k18Vm3ai25X4rDVxWuyFZQotI4xt6Ufw+xHlCRt3JCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUJ2ULq6N7GPk/2GlP54WB5I31mQK+Z6aON6KBICNrynoKoXx9MWfstV2b4lmsBlO
         3wYqpImOwNvjpFm6hB6q2U4Z3LllSPSBmq1cOIJBS7c+fN6UjlRAoMph6zeLJSf98G
         TZZlpxAuQctIXcNKakBH3GHtm10Z0BQY5gD+xY1g=
Date:   Tue, 13 Aug 2019 08:06:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com
Subject: Re: [PATCH v2 0/3] soundwire: debugfs support for 5.4
Message-ID: <20190813060655.GF6670@kroah.com>
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 06:59:39PM -0500, Pierre-Louis Bossart wrote:
> This patchset enables debugfs support and corrects all the feedback
> provided on an earlier RFC ('soundwire: updates for 5.4')
> 
> There is one remaining hard-coded value in intel.c that will need to
> be fixed in a follow-up patchset not specific to debugfs: we need to
> remove hard-coded Intel-specific configurations from cadence_master.c
> (PDI offsets, etc).
> 
> Changes since v1 (Feedback from GKH)
> Handle debugfs in a more self-contained way (no dentry as return or parameter)
> Used CONFIG_DEBUG_FS in structures and code to make it easier to
> remove if need be.
> No functional change for register dumps.

Looks much better:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
