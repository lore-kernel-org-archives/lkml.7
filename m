Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC8C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D2B218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGCJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:03:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16231 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbfGCJDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:03:50 -0400
X-UUID: 1d1dccf0f76246f68129117300f117fb-20190703
X-UUID: 1d1dccf0f76246f68129117300f117fb-20190703
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 746527483; Wed, 03 Jul 2019 17:03:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Jul 2019 17:03:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Jul 2019 17:03:44 +0800
Message-ID: <1562144624.3550.1.camel@mtksdaap41>
Subject: Re: [PATCH] checkpatch: avoid default n
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Joe Perches <joe@perches.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Andy Whitcroft <apw@canonical.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 3 Jul 2019 17:03:44 +0800
In-Reply-To: <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
References: <20190703083031.2950-1-miles.chen@mediatek.com>
         <be8a97c15249ff8a613910db5792c5bcdc75333c.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 01:42 -0700, Joe Perches wrote:
> On Wed, 2019-07-03 at 16:30 +0800, Miles Chen wrote:
> > This change reports a warning when "default n" is used.
> > 
> > I have seen several "remove default n" patches, so I think
> > it might be helpful to add this test in checkpatch.
> > 
> > tested:
> > WARNING: 'default n' is the default value, no need to write it explicitly.
> > +       default n
> 
> I don't think this is reasonable as there are
> several uses like:
> 
> 		default y
> 		default n if <foo>
> 
> For instance:
> 
> arch/alpha/Kconfig-config ALPHA_WTINT
> arch/alpha/Kconfig-     bool "Use WTINT" if ALPHA_SRM || ALPHA_GENERIC
> arch/alpha/Kconfig-     default y if ALPHA_QEMU
> arch/alpha/Kconfig:     default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
> arch/alpha/Kconfig:     default n if !ALPHA_SRM && !ALPHA_GENERIC

Hi,


I've sent similar patch in 2016, my version won't complain about these.

https://lkml.org/lkml/2016/4/22/580

Joe.C

