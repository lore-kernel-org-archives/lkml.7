Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0359C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C956E2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559841748;
	bh=E8GVDj8jZE9ZEb/ZBfEk+g3I/3sRmQxNRSfSky732xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ARnHqLW/vafcPgayJOhlk+K4h55mRZYDtE7Lp7zgcSwR+xmrOpSa+/SZm8/UzbYP8
	 mU8831MXM3tXqaKnyx/WJjMWeuk0ighRWrbEMOYb3xpRVMyL/xpGpVPdzWAYCIvqdF
	 jTzOiENGx9UB5oblBrvtzuaJ3WqwxnjD5b6+vc0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfFFRW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:22:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFFRW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:22:27 -0400
Received: from localhost (unknown [106.200.230.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BD4206BB;
        Thu,  6 Jun 2019 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559841747;
        bh=E8GVDj8jZE9ZEb/ZBfEk+g3I/3sRmQxNRSfSky732xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsRfXDNJpiokqV0wIXjGvkYOs1hjY/Ed2GRNadr2ixmtxhDa+tNiuWPkczANgXbhk
         6nIrrby24diROrNhr3zdla26hFwFr6t01BEOm/Zf/jYmDv4S6sDN2VZACyQXvGvKSu
         p31prIJ9UgISoccSrbnBn0QvPxJJRzx/M6nsBILs=
Date:   Thu, 6 Jun 2019 22:49:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: set dai min and max channels correctly
Message-ID: <20190606171918.GC9160@vkoul-mobl.Dlink>
References: <20190606112304.16560-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606112304.16560-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-06-19, 12:23, Srinivas Kandagatla wrote:
> Looks like there is a copy paste error.
> This patch fixes it!

Applied, thanks

-- 
~Vinod
