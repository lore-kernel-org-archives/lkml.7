Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BF4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEF5205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563367114;
	bh=USlS3q2z7IeW6nIUb3oVGD5eAw8p5izHaNR3Hcnmy/s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=COk1MEyXQZ/SQBMGjgEUtubk5RO1AVhAq8Scxv0P119FRott2FKaCVsLzTt5cmmTH
	 hao3elN/Ufoh8uBNAelLr9E6FBbgXaKW79BwIpkFH6L/WWltgVrEa9BRl9lcCoSsn4
	 9/HcF7dUqVxP9vz/7r/CFwLptJzRckvubOMh2CsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGQMid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:38:33 -0400
Received: from foss.arm.com ([217.140.110.172]:47022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQMid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:38:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86CE7337;
        Wed, 17 Jul 2019 05:38:32 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3963F71F;
        Wed, 17 Jul 2019 05:38:31 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Fix spelling mistake in my name
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     kvmarm@lists.cs.columbia.edu, will@kernel.org
References: <20190717123330.7220-1-suzuki.poulose@arm.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <95a7da35-8641-9310-abab-960928bfb76e@kernel.org>
Date:   Wed, 17 Jul 2019 13:38:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717123330.7220-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2019 13:33, Suzuki K Poulose wrote:
> Fix a typo in my name against in KVM-ARM reviewers.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Will,
> 
> Please could you pick this one too ? There might be conflict with
> the other updates.
> 
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c144bd6a432e..ce5e40d91041 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8795,7 +8795,7 @@ KERNEL VIRTUAL MACHINE FOR ARM/ARM64 (KVM/arm, KVM/arm64)
>  M:	Marc Zyngier <marc.zyngier@arm.com>
>  R:	James Morse <james.morse@arm.com>
>  R:	Julien Thierry <julien.thierry@arm.com>
> -R:	Suzuki K Pouloze <suzuki.poulose@arm.com>
> +R:	Suzuki K Poulose <suzuki.poulose@arm.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	kvmarm@lists.cs.columbia.edu
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git
> 

OK, who hasn't had their MAINTAINERS update today? ;-)

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead, it just smells funny...
