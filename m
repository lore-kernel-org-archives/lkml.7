Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037CAC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B352189E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfGEBfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:35:38 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:51577 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfGEBfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:35:37 -0400
X-UUID: 27620e949d0c4445b1dce6282ae5c56c-20190704
X-UUID: 27620e949d0c4445b1dce6282ae5c56c-20190704
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1737695922; Thu, 04 Jul 2019 17:35:33 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 4 Jul 2019 18:35:32 -0700
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 5 Jul 2019 09:35:30 +0800
Message-ID: <1562290530.10428.6.camel@mtksdaap41>
Subject: Re: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
From:   CK Hu <ck.hu@mediatek.com>
To:     Ulrich Hecht <uli@fpond.eu>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sean Wang <Sean.Wang@mediatek.com>,
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Sean Wang <sean.wang@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        <linux-mediatek@lists.infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <matthias.bgg@kernel.org>,
        "Ulrich Hecht" <ulrich.hecht+renesas@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Fri, 5 Jul 2019 09:35:30 +0800
In-Reply-To: <100944512.353257.1562254420397@webmail.strato.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
         <20181116125449.23581-9-matthias.bgg@kernel.org>
         <20181116231522.GA18006@bogus>
         <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
         <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
         <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
         <458178ac-c0fc-9671-7fc8-ed2d6f61424c@suse.com>
         <154356023767.88331.18401188808548429052@swboyd.mtv.corp.google.com>
         <a229bfc7-683f-5b0d-7b71-54f934de6214@suse.com>
         <1561953318.25914.9.camel@mtksdaap41>
         <84d1c444-d6cb-9537-1bf5-b4e736443239@gmail.com>
         <100944512.353257.1562254420397@webmail.strato.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Uli:

On Thu, 2019-07-04 at 17:33 +0200, Ulrich Hecht wrote:
> > On July 4, 2019 at 11:08 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> > You are right, it took far too long for me to respond with a new version of the
> > series. The problem I face is, that I use my mt8173 based chromebook for
> > testing. It needs some downstream patches and broke somewhere between my last
> > email and a few month ago.
> 
> If that Chromebook is an Acer R13 and you need a working kernel, you may want to have a look at https://github.com/uli/kernel/tree/elm-working-5.2 .

Thanks for your sample code, and your implementation is different than
Matthias' version. In your version, mmsys is a single device which has
clock function and display function, the clock function is placed in
clock driver folder and display function is placed in drm driver folder.
In Matthias' version, clock function is a sub device of mmsys. I've no
idea of which one is better. I would get more information to make better
decision.

Regards,
CK

> 
> CU
> Uli
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


