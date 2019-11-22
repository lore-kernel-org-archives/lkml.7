Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D859C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159D220708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401441;
	bh=+d9TccEDZc1JUsjII+UTJRjKMBX7aTUKp9D4Z28LF+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ofwD0zqVa+sUik2fMNVrJ3r3JgfbKNddPXIsYd8DZaE4wKhGPF1J8TOo06oesQkS
	 SOQn1lWatZSOZZRE22fHVPgXy/9msLg2U9Bxsqu5dd5gO2S2fAp85/CAtlsjHCNO30
	 y9UJabdojZQTQqVTWqFqlPKWdXxEgX87o7hae7k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKVFoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfKVFn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:43:59 -0500
Received: from localhost (unknown [171.61.94.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481B320708;
        Fri, 22 Nov 2019 05:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401439;
        bh=+d9TccEDZc1JUsjII+UTJRjKMBX7aTUKp9D4Z28LF+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyhhvFiwdMNt082XPHlak304cMKyGbQDWyc6axweOlxHiGeLMLDHvz10B3pzf/6n2
         G3BpF7scFfVWRbHmsPOZWPa9gd4JR6zEXGyGY7J8dCBOqnkbBywEM+a7UmVJ+UtLOi
         v42qF0H5RAyTnlLDyeBffAd9NR4q/cjMQ1oLwuYI=
Date:   Fri, 22 Nov 2019 11:13:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: ti: edma: fix missed failure handling
Message-ID: <20191122054352.GR82508@vkoul-mobl>
References: <20191118073802.28424-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118073802.28424-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-19, 15:38, Chuhong Yuan wrote:
> When devm_kcalloc fails, it forgets to call edma_free_slot.
> Replace direct return with failure handler to fix it.

Applied, thanks

-- 
~Vinod
