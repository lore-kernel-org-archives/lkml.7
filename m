Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1222C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F6F2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 03:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576034070;
	bh=Ut608EWmoKpCpeQTzJgsEa7BVoL4dGTgh87HRiPQsmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bLEanyVGhj5mRGxOaFU6MNYCcW7+YD3VNvfWCLXhU9FKhRSNTkhQIoRMuuJiz3wCX
	 Lh/FCyD8M6hQYxMNIpCc3yx9z789RJgIBBgnkIjg8y5gneMaf8k4HfpeAY+zSMlGjz
	 GGmISW6gGWgG05pQSHKiUG/WARa72xHcXr2ZmNmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfLKDO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:14:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfLKDO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 22:14:27 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7843D2073B;
        Wed, 11 Dec 2019 03:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576034066;
        bh=Ut608EWmoKpCpeQTzJgsEa7BVoL4dGTgh87HRiPQsmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KH6ClGGtvP3KOoN6fGzLlT//jCsfFMl66C9rsYgWPb4Gc2MIJXVDtLmhlxYyHVDom
         LtVYKsWNLUnCZ3yhw1nH/NzhUFDjk+arbWJ2xGwlYiug7CznrvCAPGRPGwEDHt/j/Q
         0pb2BWHkcJHw9B4ZYqdCX3fMsSljpBIDu75tWOFA=
Date:   Wed, 11 Dec 2019 11:14:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>
Cc:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 0/5] Add dts support for various NXP boards
Message-ID: <20191211031413.GG15858@dragon>
References: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575457098-18368-1-git-send-email-Ashish.Kumar@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 04:28:13PM +0530, Ashish Kumar wrote:
> This patch series add dts support for various boards like 1028ardb,
> 1028aqds, ls1046afrwy, ls1046ardb and ls1088ardb.
> QSPI dts nodes are sorted alphabeticaly and dtsi nodes are sorted
> addresswise.
> 
> Patch 1 adds support for ls1028ardb and ls1028aqds.
> 
> Patch 2 adds support for ls1046afrwy.
> 
> Patch 3 adds support for ls1046ardb.
> 
> Patch 4 adds support for ls2080a.
> 
> Patch 5 adds support for ls1088ardb and ls1088aqds.
> 
> Ashish Kumar (4):
>   arm64: dts: ls1028a: Add FlexSPI support
>   arm64: dts: ls1046a: Update QSPI node properties of ls1046ardb
>   arm64: dts: ls208x: Remove non-compatible driver device from qspi node
>   arm64: dts: ls1088a: Add QSPI support for NXP LS1088
> 
> Kuldeep Singh (1):
>   arm64: dts: ls1046a: Add QSPI node for ls1046afrwy

Applied all, thanks.
