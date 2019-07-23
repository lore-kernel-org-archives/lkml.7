Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B962C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5816A2251B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563867415;
	bh=k3LA9hzAaxtEeLK7HegCGPVUaZoeagWVAfV3MLEBScg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NHJlsWonAlO3cXkv36z4DvbE66tl5Xrh4nXb14p3hPKDQPaRHFux0K+zPkqU9GtW4
	 0bKPyzDcupAY/E22YiKOGt422olyuKqaBI0jILUrO/v+Pf245bo6MnCke7lnQlVcPn
	 m8pwL1MoqyESq3DrCMHfphLGc4Aq6apfCmPtq4gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbfGWHgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfGWHgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:36:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A55C2251A;
        Tue, 23 Jul 2019 07:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563867413;
        bh=k3LA9hzAaxtEeLK7HegCGPVUaZoeagWVAfV3MLEBScg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ndm2K1U35TJz0HsSn7XNKjEdJsC6PfuMcpyNN13EPwKh7K/wCiro22wPbo8NDUTKt
         hxf+Si135oYBcLCQ29u7AVvJPSrBW4XTiEDPuOqhb4BEX7y6LmTe4onklrmgoJrj3r
         YZB6od8m+8tOmC751ZmE7zolY9OuTDyKpXFqbatc=
Date:   Tue, 23 Jul 2019 15:36:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: vf610-zii-spb4: Drop unused pinctrl_i2c1
 pinmux config
Message-ID: <20190723073623.GH15632@dragon>
References: <20190717150253.20107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717150253.20107-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 08:02:51AM -0700, Andrey Smirnov wrote:
> Pinctrl_i2c1 pinmux config is not used anywhere. Drop it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Cory Tusar <cory.tusar@zii.aero>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied all, thanks.
