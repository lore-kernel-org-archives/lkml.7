Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84967C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D52220675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558686869;
	bh=ob/7Sz9F0cKP9wKRpECJAF/PRJ5kcHembSLLMghwFj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MLpokEEDGZt86e+QzziJ2jX4yM7njR7ch3Tn2secwVl31VjUjfkL9WoSgPiXrEc6Q
	 BktR5MWuH27Dl7JcqA+84Orr47PJQFHFiJwIi68GRW0EPvnnSUD882XX1Vu+ZzP1Rt
	 p5w2VuWbIZStZSAHabhIOHc7dhZp8ypTKvRsqSjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbfEXIe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389046AbfEXIe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FFE920675;
        Fri, 24 May 2019 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558686866;
        bh=ob/7Sz9F0cKP9wKRpECJAF/PRJ5kcHembSLLMghwFj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E4SkXufx0XuGi/3YT2UX2/sRKrsqXA5md8EF3ksMED1ZVQpm66Pk76b9nEWscOic/
         FUHCrZlGnzxW1PUQUrEhZRs5VyRVPmJcZqd1BydnwhrVR0/Gy/pP7ywHxbb4XtpiQ3
         7fOvq+JjYxUhY1TfcfCtCIqDelpCE1WgT5NaeXAo=
Date:   Fri, 24 May 2019 10:34:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: ks7010: Remove initialisation in
Message-ID: <20190524083423.GA18583@kroah.com>
References: <20190524080622.4801-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524080622.4801-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:36:22PM +0530, Nishka Dasgupta wrote:
> As the initial value of the return variable result is never used, it can
> be removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> Changes in v2:
> - Clarified subject line

Your subject line is an incomplete sentence :(

