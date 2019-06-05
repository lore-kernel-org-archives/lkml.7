Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D582C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BB220874
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559719077;
	bh=UvZZuTWpoc60H6O/TupAG9xibh4izaL9XRjkHa2JaI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wbpyotu1X3ouwGXD1RN4iDQ2118Ak4uCelgqZKhKjVEXTwwx07o2ABfL3NLN9Q/ag
	 vsAxY9unFqJyLkoB7FdJxkFrFZP9oVL635gtDpndEoTPgketGlH61v5EJzpaXZIFoB
	 uuwqOYUaqMZR+WVo1nuQmdfUAmLrD5i0S2gz0YBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFEHR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFEHR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:17:56 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D21472083E;
        Wed,  5 Jun 2019 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559719075;
        bh=UvZZuTWpoc60H6O/TupAG9xibh4izaL9XRjkHa2JaI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1D8S4Ie3SSoULHmowUpqy9X5b28/CfbNF1dbyL9chKV+2hrBvhG7vdknYejggZV6t
         FGHa7BnYq5+Pim2bbZ+ctVoMCI74Yp1nhsX4AIi9tOK7xsWFTeEN21cxIKXU6hwCT3
         g+n30nfD6OVOU/9IjiKWkVfDUCljRd5rZnE/QDtg=
Date:   Wed, 5 Jun 2019 15:17:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: ls1028a: fix watchdog device node
Message-ID: <20190605071735.GI29853@dragon>
References: <20190528124506.9339-1-chuanhua.han@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528124506.9339-1-chuanhua.han@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:45:06PM +0800, Chuanhua Han wrote:
> ls1028a platform uses sp805 watchdog, and use 1/16 platform clock as
> timer clock, this patch fix device tree node.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>

Applied, thanks.
