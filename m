Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAAFC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3FC20721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgAIPSc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:18:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36057 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgAIPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:18:31 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id AA51DE0009;
        Thu,  9 Jan 2020 15:18:27 +0000 (UTC)
Date:   Thu, 9 Jan 2020 16:18:26 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: onenand: Enable compile testing of OMAP and
 Samsung drivers
Message-ID: <20200109161826.7fda02a4@xps13>
In-Reply-To: <20191231073339.GA6747@pi3>
References: <20191229183612.22133-3-krzk@kernel.org>
        <201912310904.9iM6MaFr%lkp@intel.com>
        <20191231073339.GA6747@pi3>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Krzysztof Kozlowski <krzk@kernel.org> wrote on Tue, 31 Dec 2019
08:33:39 +0100:

> On Tue, Dec 31, 2019 at 10:00:48AM +0800, kbuild test robot wrote:
> > Hi Krzysztof,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on linus/master]
> > [also build test WARNING on v5.5-rc4 next-20191220]
> > [if your patch is applied to the wrong git tree, please drop us a note to help
> > improve the system. BTW, we also suggest to use '--base' option to specify the
> > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Krzysztof-Kozlowski/mtd-onenand-samsung-Fix-pointer-cast-Wpointer-to-int-cast-warnings-on-64-bit/20191230-030838
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bf8d1cd4386535004c4afe7f03d37f9864c9940e
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-129-g341daf20-dirty
> >         make ARCH=x86_64 allmodconfig
> >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >   
> 
> It is not related to my patch. I'll fix it up soon.

I would like this to be fixed before enabling compile testing, is your
fix read?

Thanks,
Miquèl
