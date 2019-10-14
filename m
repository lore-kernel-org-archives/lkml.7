Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006F0C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD69220882
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571031873;
	bh=vsklJ1aQIJVTHMMlcpWk6UVcFsa6nZxkigPpSNGLoPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KpMu93XjGycENPZzMKr3ocfu9IOdypnBLLzJKOZ6vqBKG4Is/wN4Di3RkSS5VAoP7
	 pXfA/LMECFTt2/fw5nIM73FLPoJKwftD01mr5qEojWmr/my0cA45aMo+I3DNZxVta/
	 DN8QOdN7l9FqFliv/2HGNCyWbP7ZgcujS9WiUv3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfJNFoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfJNFoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:44:32 -0400
Received: from dragon (unknown [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFE4920873;
        Mon, 14 Oct 2019 05:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571031872;
        bh=vsklJ1aQIJVTHMMlcpWk6UVcFsa6nZxkigPpSNGLoPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJTlJ0ei+XSYfi5w86FMeEP3FwZCWIEK5XG4Ck1AExRX6QwB/c3Hc7gHcWNj6xiVa
         pHMnADLsucAoI2OFlRqUXAp7gQAwZvb9iOTeTYdhEaKjjilBQ1MSEv4TfKcwliYmHA
         Y9nK1KBOlZ7b8Mijykl/9WIxip19yWORiwlIaQyQ=
Date:   Mon, 14 Oct 2019 13:44:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: lx2160a: Correct CPU core idle state name
Message-ID: <20191014054416.GA12262@dragon>
References: <20190917073357.5895-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917073357.5895-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:33:56PM +0800, Ran Wang wrote:
> lx2160a support PW15 but not PW20, correct name to avoid confusing.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

Applied, thanks.
