Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBCFC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 19:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528A206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 19:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566674718;
	bh=z1Hc0A0G81OLbky3EuSdI9HyPUyJ6eEn/caLXChVCdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qUqweT8xEGoa0wBuGeJnZa5QYGLjrHBmeXU5JBLfpDX6C+Pohn9OZig+k5N3KabIn
	 iNVn50zZzkA1Inni4kZbD3mhpCzMjBF26ojYbEiHZPu0XMT3wQfeXPLZgTSZhgLDLl
	 wmTMS9u9FsjDIHzmJbsRpnGotA4gNCBh2lK0NrPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfHXTZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 15:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfHXTZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 15:25:17 -0400
Received: from X250.getinternet.no (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EFD206E0;
        Sat, 24 Aug 2019 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566674716;
        bh=z1Hc0A0G81OLbky3EuSdI9HyPUyJ6eEn/caLXChVCdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0g4htK2aGA2Uplr72ayIAA7GsCJAoOjgXg/0XxJyJRYM2zqB92xdpAEJPETEdUfd
         yDX8/OcF6SVAYnCThHaoU08FzB6gJjzYtuI1dP7Zobne8PUAVmX+Xa8gjvFt45BHbX
         5Ylg0U4x2DXELZgc3f4EqwgJTrACO6sKwunNmGaY=
Date:   Sat, 24 Aug 2019 21:25:05 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-cfu1: Slow I2C0 down to 100 kHz
Message-ID: <20190824192503.GH16308@X250.getinternet.no>
References: <20190821013936.12223-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821013936.12223-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 06:39:36PM -0700, Andrey Smirnov wrote:
> Fiber-optic modules attached to the bus are only rated to work at
> 100 kHz, so decrease the bus frequency to accommodate that.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
