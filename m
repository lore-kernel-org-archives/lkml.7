Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967BEC3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6642321773
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 01:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHSBnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 21:43:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfHSBnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 21:43:43 -0400
X-UUID: 210dbc7fd20c4b158bcf2e98870b712b-20190819
X-UUID: 210dbc7fd20c4b158bcf2e98870b712b-20190819
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 706335340; Mon, 19 Aug 2019 09:43:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 09:43:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 09:43:33 +0800
Message-ID: <1566179014.6371.10.camel@mtksdaap41>
Subject: Re: [RFC V2 09/11] dt-bindings: interconnect: Add header for
 interconnect node
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Aug 2019 09:43:34 +0800
In-Reply-To: <20190501202844.GA5092@bogus>
References: <1556614265-12745-1-git-send-email-henryc.chen@mediatek.com>
         <1556614265-12745-10-git-send-email-henryc.chen@mediatek.com>
         <20190501202844.GA5092@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 8644A86D77DF7560D2A7B886E8B77D4D30D0B2D39F8C858A4FD76197ED652F0A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-01 at 15:28 -0500, Rob Herring wrote:
> On Tue, Apr 30, 2019 at 04:51:03PM +0800, Henry Chen wrote:
> > Add header file for mt8183 interconnect node that could be shared between
> > the interconeect provider driver and Device Tree source files.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  include/dt-bindings/interconnect/mtk,mt8183.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183.h
> 
> This goes with the binding patch.
ok, will merged into previous patch 08.


