Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BFBC17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25425222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573608629;
	bh=6A6kbeJRQUdIpb0UL6yB/6+57iQ0+YlQbszsDcrCses=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zN+/IqUi1fQQhtx6c/c1XxH117zjgfwTLAfeX1GilpddDD3V9t+0203WQba2iszWJ
	 SFnrp2XUHvKHHAOHYPUAOY5E3eZzMyiNpemML6SBsWEtzNzesGGrrPHrUupHThVBCs
	 RarvNPcxtUMLkWuvxZKYBZvGOS8WN+p9ImQZDL1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKMBa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726936AbfKMBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:30:28 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54BEC222CE;
        Wed, 13 Nov 2019 01:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573608627;
        bh=6A6kbeJRQUdIpb0UL6yB/6+57iQ0+YlQbszsDcrCses=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2A1K3QFkYVoGRcdTRXGTlXPSxTvFRpSPVMIcMOnFA4px5/tGc9/VcsosvJT+fKc9l
         Fga1T2tp8F/sNYoB2DZQqa1KEiGtno2kNHiEIFYff/Nn00oYfbJHHB+ILVHj9T6rvj
         f1y6A5cs7KQNR249udiCUb+1ViRfYsubgHZqQH1M=
Date:   Tue, 12 Nov 2019 20:30:26 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     akpm@linux-foundation.org, oleg@redhat.com, christian@brauner.io,
        tj@kernel.org, peterz@infradead.org, prsood@codeaurora.org,
        avagin@gmail.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: PROBLEM: objtool: __x64_sys_exit_group()+0x14: unreachable
 instruction
Message-ID: <20191113013026.GO8496@sasha-vm>
References: <20191112223300.GA17891@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191112223300.GA17891@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 04:03:00AM +0530, Jeffrin Jose wrote:
>hello all,
>
>i found a warning during kernel build (5.3.11-rc1+).
>-----------------x----------x-----------------
>kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
>-------------------x---------------x-----------

Could you bisect it please? I'm not seeing the warning here, and
kernel/exit.c wasn't touched during the life of the 5.3 stable tree.

-- 
Thanks,
Sasha
