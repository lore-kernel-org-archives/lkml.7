Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB61ECE587
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF138215EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569977865;
	bh=MG19YeAOY8LCvIuIz4SQI0njSnM6m5/3C+dLNtuySv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BU10lBCTKOdOeL4q6pdlQfeE1JAYwM/l0IDHP0rrD/xPZyk5rnP+vIF24xiRRmY5S
	 +5ijub0tilWOeWKj7vYOADSi75QJJJEsHNyes2/v60FS9qM1dqznsfL/K78fYeXRQO
	 LHJiFhxGk+Ze1mmwdnvQ/3Ikacw7z8tvFzod81gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfJBA5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfJBA5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:57:44 -0400
Received: from dragon (unknown [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14CC620842;
        Wed,  2 Oct 2019 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569977863;
        bh=MG19YeAOY8LCvIuIz4SQI0njSnM6m5/3C+dLNtuySv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0AaBsHhbgJbbTWaxd924N4N5TkZV/Z/owgmD037LXSP7CbXzmVZW0sHmyJLyjuT5
         /jYm6JmI/Gtrh7R3c8XISpyMKlHcBC7ZqyNIA/WKkHe/3gR5l5IIjZ8a0uudxq8xMs
         6jNC3TT7TKDiQkfFFO3JG5dZOktqSDFSUF92vpjg=
Date:   Wed, 2 Oct 2019 08:57:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jiafei Pan <jiafei.pan@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [EXT] Re: [PATCH v5] arm64: dts: ls1028a: Add esdhc node in dts
Message-ID: <20191002005723.GA18972@dragon>
References: <20190815033901.18696-1-yinbo.zhu@nxp.com>
 <20190819131033.GH5999@X250>
 <VI1PR04MB4158E2E8C626FCABF089E15AE9840@VI1PR04MB4158.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4158E2E8C626FCABF089E15AE9840@VI1PR04MB4158.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 03:02:04AM +0000, Yinbo Zhu wrote:
> Hi Shawn Guo,
> 
> I see that you had merged my patch, but I don't see that in 
> url = git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git master branch.
> Please help check.

My master branch will only get updated to each -rc1 tag when merge
window closes.  I just updated it to v5.4-rc1, and it should has your
patch now.

Shawn
