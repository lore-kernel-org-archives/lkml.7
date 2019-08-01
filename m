Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E6C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B614C214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564652093;
	bh=SH6f21lmIyn+pd+VkvTBUkm1MkwdIZDLUdiyEmRNR+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=reNP/5j0EqL5d4WwOuFkRM5FB8gzM786XQ41a3SHIl7mjtULdRWIpi3GUoJQ6twZ/
	 RPk7FC96berq2rM1JuQ0vHJSo0vzeTr0aT+fWh6o+ZJbfvC3tBpJFeJ9F4xYsaEzXo
	 lwVY5HyK14lCpOhiE0tiw+WuRtD1SGfZxqeWrq34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbfHAJew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:34:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:34:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD4F6206B8;
        Thu,  1 Aug 2019 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564652091;
        bh=SH6f21lmIyn+pd+VkvTBUkm1MkwdIZDLUdiyEmRNR+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APCZAFFlcanmjLy4xSd1nHh5Ni/XshHjAKu46SH/sZy3tsn5F3WiPdQJNnaDQHxlw
         QoxZ5r0DhvsYoN293Q5fmwjTiCNJ2GXZYpCigPypd0UkHNTLJ3F5yQtpoHgzzQFZw6
         +I2aQwIlYyl5HGfv0bZ//1BgokAl2BsR13+3vmuA=
Date:   Thu, 1 Aug 2019 10:34:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-ID: <20190801093447.ktpnc757fdqn4mzs@willie-the-truck>
References: <20190801080621.18868050@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801080621.18868050@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:06:21AM +1000, Stephen Rothwell wrote:
> In commit
> 
>   97d5db366224 ("arm64: Lower priority mask for GIC_PRIO_IRQON")
> 
> Fixes tag
> 
>   Fixes: bd82d4bd21880b7c ("arm64: Fix incorrect irqflag restore for
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.

Thanks, will fix.

Will
