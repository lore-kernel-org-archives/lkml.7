Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2068321841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066642;
	bh=G/jeCtT9UUfIsnuMXfzBSlN4wjaLwUtIiit1FWBUprU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=13kZQfyJA1g9R6TRbMXg7GGTesMqeyxyiruxT+LwQhRKPgAJR2l+Hd9lKEsbcDA9c
	 1RlctQSeIo3/GPurgHLsaPBSm+Fnf9/Q+BZSpjTU7IHEqtF5coQCCXHLMt42wC+6Ht
	 Tv67/uF5SrpZ3bUcPYPmaQ5GPDO30OvCsl+SirLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCTHYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTHYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:24:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F4221841;
        Wed, 20 Mar 2019 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066639;
        bh=G/jeCtT9UUfIsnuMXfzBSlN4wjaLwUtIiit1FWBUprU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haE2xZRnd8L02Q2xPbNFYZeIOFjE10c60kxjEBtajYRU9GuW+tuZJB6vLR0mWJRR7
         RXTv6UKbsqOSJoUmBxOJqExiLyCMenoAlzC2HybwEhq75ngfz2WhE8J7QMVUk3/peE
         qF7xY05cWfianI4PF1RN9uNBV3VXZSWi2w1+1u94=
Date:   Wed, 20 Mar 2019 08:23:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] staging: rtlwifi: rtl8822b: fix to avoid NULL pointer
 dereference
Message-ID: <20190320072357.GB2647@kroah.com>
References: <20190319202127.16692-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319202127.16692-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:21:25PM -0500, Aditya Pakki wrote:
> skb allocated via dev_alloc_skb can fail and return a NULL pointer.
> This patch avoids such a scenario and returns, consistent with other
> invocations.
> 
> ---
> v1: Patch collision with rtl_phydm.c, fix as per Greg
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Same here, has to be above.

