Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25FDFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872920869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 03:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573185281;
	bh=MIIXRJaBYrNEXOYhmNyw15hFAChncCB29PqU5uPxEfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sh2+W8tBTKzrgljTIPaiq/AF0lT0nNVbFoosa7pkIdNP582NkeXd7hJn4q/kRahgu
	 jGWwYU+MyqB+iJuIEl8TirOhD2q7H6ywdtWiRES2TuFOAMIaDr7muT/oq2r75I/W5I
	 llWWQeKz0KX0rR+mqlVmQnNOwybsMJT74tp5nwjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfKHDyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 22:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbfKHDyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 22:54:40 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D58214DB;
        Fri,  8 Nov 2019 03:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573185279;
        bh=MIIXRJaBYrNEXOYhmNyw15hFAChncCB29PqU5uPxEfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glynSCKHMYu10EcMhBORu0ErVBKrUcV98fhZ85ehrkiuejf16AuHEIuP6/tgXO7Xm
         R+mpks1IK23r3mS/Lj+B9ra8S7pqE+j4peTTVcxubI5Ui8tSR8/zjslW/6iqSFoqKi
         3VS1n5/WKhODgXPpJ8t1Z0vY/WwCCYnolu4VCC6c=
Date:   Fri, 8 Nov 2019 09:24:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dma-jz4780: add missed clk_disable_unprepare
 in remove
Message-ID: <20191108035435.GR952516@vkoul-mobl>
References: <20191104161622.11758-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104161622.11758-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-19, 00:16, Chuhong Yuan wrote:
> The remove misses to disable and unprepare jzdma->clk.
> Add a call to clk_disable_unprepare to fix it.

Applied, thanks

-- 
~Vinod
