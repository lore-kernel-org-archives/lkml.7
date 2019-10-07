Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FBF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 03:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfJGDYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 23:24:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57881 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726852AbfJGDYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 23:24:20 -0400
X-UUID: 2d375be6e5b94d62bfb4b83ce17ecc16-20191007
X-UUID: 2d375be6e5b94d62bfb4b83ce17ecc16-20191007
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 541636460; Mon, 07 Oct 2019 11:24:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Oct 2019 11:24:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Oct 2019 11:24:12 +0800
Message-ID: <1570418653.8779.8.camel@mtksdaap41>
Subject: Re: Aw: Re: [PATCH] mfd: mt6397: fix probe after changing
 mt6397-core
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 7 Oct 2019 11:24:13 +0800
In-Reply-To: <3dcb030d-006e-7518-2679-48726d0c4e0e@gmail.com>
References: <20191003185323.24646-1-frank-w@public-files.de>
         <20191004152001.GS18429@dell>
         <trinity-c33ab112-57a5-47d6-80e5-13c96442e302-1570204319219@3c-app-gmx-bap10>
         <3dcb030d-006e-7518-2679-48726d0c4e0e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: B2BB257C51EF80567F0D78FDC8AB09DCF7AB0000E082C245E93B3B8248ACBB9A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-05 at 10:16 +0200, Matthias Brugger wrote:
> 
> On 04/10/2019 17:51, Frank Wunderlich wrote:
> > This Question goes to Hsin-Hsiung Wang ;)
> > 
> > i only took his code (and splitted the 3rd part) to get mt6323 working again without reverting the other 2 Patches
> >> regards Frank
> > 
Hi Frank,
Sorry for the late reply.
I appreciate your help very much for splitting the code to fix the
issue.
This patch is ok for me.

> > 
> >> Gesendet: Freitag, 04. Oktober 2019 um 17:20 Uhr
> >> Von: "Lee Jones" <lee.jones@linaro.org>
> > 
> >> Will there be other devices which have a !0 CID shift?
> > 
> 
> Frank, a quick look at the series would have given you the answer.
> @Lee: yes, this change is the preparation to support MT6358:
> https://patchwork.kernel.org/patch/11110515/
> 

Hi, Lee
MT6358 uses 8 for the cid shift and I will submit next version patch of
mt6358 which is based on Frank's patch.

Hi, Matthias
Many thanks for the explanation.

> Regards,
> Matthias


