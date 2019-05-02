Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF6A208C4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556780885;
	bh=4UFPxs6JvZxakaeyG4qDIBh4IL4y8hXBZwN3SfTw9Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qj7EbRUfyi1yOjrLbpMtSvWzdc+kn7V+K99ofkrhovgRIT/Pgl48akk3zm3uU/vnq
	 9eg3XUt+H4+THzWcEC2obmcwG285TuQXqOeWumVko5lsoUBq7Jcr+B/bx/SSW+bvYn
	 geAkW+9x6WZmr9uEciZP1/jeMU024CoLfWEy4WyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEBHIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfEBHIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:08:04 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67852085A;
        Thu,  2 May 2019 07:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556780883;
        bh=4UFPxs6JvZxakaeyG4qDIBh4IL4y8hXBZwN3SfTw9Z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vX1nueDloxy/jwbPpl+bD+/PQL4Nk27eLeLLscm7SW5XQiUXI29+PY+3e9U7ZjKF6
         wCLA0qtUDD/MY01BCYAYW0IpzL7HX2MhxHG1C2GQO3Ye9OAUeBx0CgWnqfFmIHyQVh
         S3FHSrrgSHqAwTYnwXK6pH5eGcftsVqFqkgHhCKA=
Date:   Thu, 2 May 2019 12:37:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
Subject: Re: [alsa-devel] [PATCH v4 00/22] soundwire: code cleanup
Message-ID: <20190502070753.GK3845@vkoul-mobl.Dlink>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190502055812.GG3845@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502055812.GG3845@vkoul-mobl.Dlink>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-05-19, 11:28, Vinod Koul wrote:
> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
> > SoundWire support will be provided in Linux with the Sound Open
> > Firmware (SOF) on Intel platforms. Before we start adding the missing
> > pieces, there are a number of warnings and style issues reported by
> > checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Applied all expect 2, 3, 6 and 22

Split 2, 3, 22, updated log for 6 and pushed

-- 
~Vinod
