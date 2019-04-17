Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B52C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACCB21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 05:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfDQFkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 01:40:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:17352 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725873AbfDQFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 01:40:21 -0400
X-UUID: 4a19ee1d609e408fb7f43b819a2f6611-20190417
X-UUID: 4a19ee1d609e408fb7f43b819a2f6611-20190417
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1609728534; Wed, 17 Apr 2019 13:40:11 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 13:40:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 13:40:11 +0800
Message-ID: <1555479611.3515.2.camel@mtksdaap41>
Subject: Re: Aw: Re: [PATCH v1 0/4] make hdmi work on bananapi-r2
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Date:   Wed, 17 Apr 2019 13:40:11 +0800
In-Reply-To: <trinity-366430bd-b9d1-487b-80c7-1796b602ca6b-1555479050979@3c-app-gmx-bs70>
References: <20190416145848.11932-1-frank-w@public-files.de>
         <1555470607.16005.12.camel@mtksdaap41>
         <trinity-366430bd-b9d1-487b-80c7-1796b602ca6b-1555479050979@3c-app-gmx-bs70>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

On Wed, 2019-04-17 at 07:30 +0200, Frank Wunderlich wrote:
> Hi CK Hu,
> 
> you mean the problematic patch is fix possible_crtcs (4/4) and the others are ok?
> 
> can you push the first 3 while working on the last one?

I think 3 patches is related to possible crtc problem: (1/4), (2/4), and
(4/4).

And I have comment on (3/4) also.

Regards,
CK

> 
> regards Frank


