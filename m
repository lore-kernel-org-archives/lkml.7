Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65F2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9693321849
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564748053;
	bh=yPGd9w2AChJ9TwF477eGZmoBAjtFbH7nOLUGrIYSj78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PVhvJIXgKKqgr+SiZFHVJABqSOkE/JagYfHvpptSiRdfMq24rRl3eu0o828x125fk
	 USVPV+6j/bDBU3MtVvNOYwed3FhUncKDEz4CrEwIK+9idX8RBVXJ97zKgRdzCVtFy9
	 OcYhgcUF+OhMfZAutFf/4VPfoCkheenFg+lHYD58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392584AbfHBMOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389277AbfHBMOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:14:12 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADA42183F;
        Fri,  2 Aug 2019 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564748051;
        bh=yPGd9w2AChJ9TwF477eGZmoBAjtFbH7nOLUGrIYSj78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUvfP4OCekM7yfrQ3NTkWTQ/Ild9U8FGJYxL/dg0BMFgW5yHo508BUVBdo2bnQGzp
         K835l57uNDTDLK9PERDHn+m/pIK1u/DB55LOQpZYKhctyPELAXBKtsmg1Uxozl/+Wc
         bNf1TXdYHUBVjkW2CKfuhpD89u5wcX+Ryjh2/ZCQ=
Date:   Fri, 2 Aug 2019 17:42:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [RFC PATCH 13/40] soundwire: cadence_master: fix register
 definition for SLAVE_STATE
Message-ID: <20190802121258.GO12733@vkoul-mobl.Dlink>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-14-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-14-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> wrong prefix and wrong macro.

Applied, thanks

-- 
~Vinod
