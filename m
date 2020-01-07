Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D7BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDEC207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAGLSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:18:40 -0500
Received: from smtp2.axis.com ([195.60.68.18]:16517 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAGLSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:18:39 -0500
IronPort-SDR: DgEOwWIz79dYYpoCbADPiwHBl+upSucKLsdZuNKDt92cc6JZTsbx6m2RFiWTlx7/hDcpprq75p
 O2TfvZuWbD8qkUY5KYGDirOwiI7IzonY2QQ3vLmpr66uSNSBwJ7MorrjcehHTlu40tQ2nP9idf
 YHH4vAssNjFVjJ3gTQfr6qhtoI0liCtZ8SCQmMvNSzvAaK6UA7BdIZuxOj2inKnOTPrrMnHblB
 fi4bDY1Xj9x3hKntRnt0eMwlavnWJf+SNlx6a8FrJqvPU5OxsXVSUoxo6lMXFNyY9LaRhW/gYP
 PJo=
X-IronPort-AV: E=Sophos;i="5.69,406,1571695200"; 
   d="scan'208";a="4004697"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Date:   Tue, 7 Jan 2020 12:18:36 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Jesper Nilsson <jespern@axis.com>,
        Lars Persson <larper@axis.com>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: artpec6: fix __iomem on reg in set
Message-ID: <20200107111836.uzvja6m4nb5hh56j@axis.com>
References: <20191218101602.2442868-1-ben.dooks@codethink.co.uk>
 <20191218162616.qsxsltfsrxotzqhb@axis.com>
 <048c9653-114b-f726-44b2-9eb1d460b5b5@codethink.co.uk>
 <CACRpkdYFzHCMLj5oU5JMCkQkMZyOvM5351tpO6iEsE8e5nBZWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYFzHCMLj5oU5JMCkQkMZyOvM5351tpO6iEsE8e5nBZWQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 10:39:34AM +0100, Linus Walleij wrote:
> On Wed, Dec 18, 2019 at 6:32 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > On 18/12/2019 16:26, Jesper Nilsson wrote:
> > > On Wed, Dec 18, 2019 at 11:16:02AM +0100, Ben Dooks (Codethink) wrote:
> 
> > >> -    unsigned int *reg;
> > >> +    unsigned int __iomem *reg;
> > >
> > >       void __iomem *reg;
> > >
> > > We're using as an argument to readl()?
> >
> > yes, readl() shoud take an __iomem attributed pointer.
> 
> Shall I change it to void as well when applying?

Please do, sorry that my comment wasn't clear above.

> Yours,
> Linus Walleij

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
