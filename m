Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E8C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FA62085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573144964;
	bh=kRomG4skJEKqHmLcDpIBxuJHDtmysngNtIuLfrCdVyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xGBGkMJuG6BN+W1/FUr/TC3SjDqpmRZEMVzV1FHS8HcifqiBoH/1mI/uWiPdXC/41
	 lnNRh58SgzGnxcPqtqAfnVK1UMFlnhhn12o+VZSTqfvGtN4FV2+Xn4NUH6EMa+K9+M
	 Dblyq5s4GXAtXs0iTF/xlPkLajLVam7Z61qu/OX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfKGQmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKGQmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:42:42 -0500
Received: from localhost (unknown [106.51.111.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69BEE2085B;
        Thu,  7 Nov 2019 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573144962;
        bh=kRomG4skJEKqHmLcDpIBxuJHDtmysngNtIuLfrCdVyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1saZOU+jkyznC+PlSeDw+s5jT1DUM0kWCdP5nlGJ8jEr1Fjusadj3mjftLO1zvqd
         dAASBy6WQvmhCu5PIdjeCuzKvGbpbsUJua4VywqEMy59LDpjXJnqQ/ujNLTB4dwl9x
         nKWwzgzgKRUoLWdLbNNzOchLJExNPSUXECUwbQQk=
Date:   Thu, 7 Nov 2019 22:12:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org,
        agross@kernel.org, tsoni@codeaurora.org, sidgup@codeaurora.org,
        psodagud@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] firmware: qcom_scm: Apply consistent naming scheme
 to command IDs
Message-ID: <20191107164237.GO952516@vkoul-mobl>
References: <1572917256-24205-1-git-send-email-eberman@codeaurora.org>
 <1572917256-24205-3-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572917256-24205-3-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-19, 17:27, Elliot Berman wrote:
> Create a consistent naming scheme for command IDs. The scheme is
> QCOM_SCM_##svc_##cmd. Remove unused macros QCOM_SCM_FLAG_HLOS,
> QCOM_SCM_FLAG_COLDBOOT_MC, QCOM_SCM_FLAG_WARMBOOT_MC,
> QCOM_SCM_CMD_CORE_HOTPLUGGED, and QCOM_SCM_BOOT_ADDR_MC.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
