Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C1C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64AC216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557364133;
	bh=HHCN83sJGDHkgbhIwvLbEuO8IR+0t6CVcaGE9uGJjDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=av5TFvXAPoSdmgUskZ6M8GKtWaIyvnHemZi+O2tQArQAgzt3VZbUHjH3QHiOWzjvS
	 nZTt9jmq89uMzRt1buhNAzd8f8hDhr2nxx4hjUmEArqU3uD3A5J8KR/km6y35JA/vT
	 CBLlcQ8mw/QfLVtjITFKimWw70q3UqUHr4B+8gsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEIBIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfEIBIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:08:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA490214AF;
        Thu,  9 May 2019 01:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557364132;
        bh=HHCN83sJGDHkgbhIwvLbEuO8IR+0t6CVcaGE9uGJjDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IaP05M3Q6k+0AQL9Jydqk2Th4poz3rAb6ArQfCkdC8jxuZPBw7zXo7tBMfSQimbEz
         pRT6COESspTWRihN0k5gsRgwC7RCB//5FzGYVj4awAholMTc8c4595ExPq77QGIz60
         QANGzL5zh4jTDWXjL+j79alegmGvdRnsgT9/tqC8=
Date:   Wed, 8 May 2019 21:08:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH] hv: tools: fix KVP and VSS daemons exit code
Message-ID: <20190509010850.GR1747@sasha-vm>
References: <20190506165058.6749-1-avladu@cloudbasesolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190506165058.6749-1-avladu@cloudbasesolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:50:58PM +0000, Adrian Vladu wrote:
>HyperV KVP and VSS daemons should exit with 0 when the '--help'
>or '-h' flags are used.
>
>Signed-off-by: Adrian Vladu <avladu@cloudbasesolutions.com>
>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Sasha Levin <sashal@kernel.org>
>Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>

Queued for hyperv-fixes, thanks!

--
Thanks,
Sasha
