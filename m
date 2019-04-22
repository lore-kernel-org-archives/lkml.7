Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4BDC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB9E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555900878;
	bh=+lvoS4UUHn557V0DVSXAxEuRoX98o8feH96FURhbXXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e/KEShuhMrCxxhQR9N/BHOi289I6V4+6oJQgyre5vvj1UpxhlsXLj+OcpQWlB46zN
	 LKGKGHKlJsC24xuYSJV8La2tiKuBnp6krDaRYmh2rLmELICdiZ2gMd+XSxcjKZvcIw
	 SO1qXBuvRE9CEy20nVezcB9vthZBHWCDOiy9Ywec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfDVClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfDVClQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:41:16 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D70720859;
        Mon, 22 Apr 2019 02:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555900875;
        bh=+lvoS4UUHn557V0DVSXAxEuRoX98o8feH96FURhbXXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wyLAPLcFbL4+b14Ce02f/7LJE7kNLdlOYIDHmXLVhkF2oafHDydfQ+oG6PNgLAmIr
         m556CTTD/anYNCqEjxGsQfavdqAjYakXPujg7qkQWhpSmrxVKLYHD3gtJnbUchZzOw
         6MvDiGrripgqugY6Xi5QQfIEYfeBRcGyrQClopY8=
Date:   Mon, 22 Apr 2019 10:41:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: lx2160a: add cpu idle support
Message-ID: <20190422024059.GT19962@dragon>
References: <20190418034401.26480-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418034401.26480-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:42:25AM +0000, Ran Wang wrote:
> lx2160a supports pw20 which could help save more power during cpu is
> dile. It needs system firmware support via PSCI.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
