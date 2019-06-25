Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F2AC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CB720656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 04:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561436590;
	bh=g8R5D05SwKQ/XjeNXsPC9J7BSXUsfkuivSbwg4q4NZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4VnI12nTW4y6duHFShn1Nq55L7TDGTBJY3WxaCpzbk4Cf2pRYgXG0C0jE+1Ock3f
	 gTQKfrA7TMv8dxA+eLIX+s7Rc13UUx/aPsmeqfBn2bVcGJE/oalhX+XKve1RYFK29K
	 w+jWhFEHIdlNWqQjwPQdT3ngnrGR9b/xLPgzEXps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFYEXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 00:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFYEXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 00:23:08 -0400
Received: from localhost (unknown [106.201.40.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7946A20656;
        Tue, 25 Jun 2019 04:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561436587;
        bh=g8R5D05SwKQ/XjeNXsPC9J7BSXUsfkuivSbwg4q4NZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYvC5dxsJ23hoTCkZTiRGFIxBQ9YNYhXofBwb3niiPvgiliFIfs8WggaGaAn1DovP
         I+X+cxtQSblri14bQCNATdChWkV7jCwUwuE7ofs6lxZx2anF6DNd2PVbnP34QZXIzY
         aoGYTlWWfauBFDc5CbKwMx94NGStHhB+NEuaZh+k=
Date:   Tue, 25 Jun 2019 09:49:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: dmatest: timeout value of -1 should
 specify infinite wait
Message-ID: <20190625041957.GG2962@vkoul-mobl>
References: <156089501718.8121.12070116684408969349.stgit@taos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156089501718.8121.12070116684408969349.stgit@taos>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-19, 22:03, Hook, Gary wrote:
> The dmatest module parameter 'timeout' is documented as accepting a
> -1 to mean "infinite timeout". Howver, an infinite timeout is not

typo Howver

> advised, nor possible since the module parameter is an unsigned int,
> which won't accept a negative value. Change the parameter
> comment to reflect current behavior, which allows values from 0 up to
> 4294967295 (0xFFFFFFFF).

Applied after fixing typo, thanks
-- 
~Vinod
