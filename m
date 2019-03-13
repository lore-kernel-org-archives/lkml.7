Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978C2213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552490447;
	bh=/N+IX9dwx/kA3Nb4bIR76a/5+0Z5dNCjCexuI9RK6d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KXraedBwImCdQNHuRfrAyGLB945I4snw4KnJHyFOkms+C9CPa7IywufOg3nUbpmgV
	 30f3015DvP9Mr3atB3t6a90tA36kThiNQ8/al9PwqfJ2SV2lBnbned3z9JiWHJSFg6
	 sU5DMR6ZvrckitJUVjRyK0hVd/kbn0e4sI+hT0fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCMPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfCMPUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:20:45 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A6D120643;
        Wed, 13 Mar 2019 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552490445;
        bh=/N+IX9dwx/kA3Nb4bIR76a/5+0Z5dNCjCexuI9RK6d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mv3AwOikEKngpFiAGLDCemgBcF1if4kkKmgyD79/gUC+VQgwQbH/m8MQcOoilHeMe
         59HVBCkUetIySb4QhvWCzO5mipraJ6FZEOE6Tj8a8vBUlNvhtBoE+cMqc864buA4us
         iUOwqFq2J6XJinSQsSpwuqiNJrzEAK5FN1bJKA9I=
Date:   Wed, 13 Mar 2019 08:20:44 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Robert Shearman <robertshearman@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Shearman <robert.shearman@att.com>
Subject: Re: [PATCH v4 3/3] i2c: mux: pca954x: allow management of device
 idle state via sysfs
Message-ID: <20190313152044.GD10250@kroah.com>
References: <20190228114343.36443-1-robertshearman@gmail.com>
 <20190228114343.36443-4-robertshearman@gmail.com>
 <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e07248e6-4987-b7a1-327a-7d30a3e5cdf5@axentia.se>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 07:04:06AM +0000, Peter Rosin wrote:
> Hi Greg,
> 
> I was wondering if you think the below ABI addition looks sane to you?

I am not the i2c maintainer :)

> Or, should I ask someone else for a tag?

It's the middle of the merge window.  None of us can do much other than
focus on that until 5.1-rc1 is out.

thanks,

greg k-h
