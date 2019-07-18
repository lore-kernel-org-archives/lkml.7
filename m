Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F9C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D96E2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403825AbfGRDTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:19:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36347 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391350AbfGRDTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:19:45 -0400
X-UUID: ac384d41e70c43c7a6dc458b2e91b1de-20190718
X-UUID: ac384d41e70c43c7a6dc458b2e91b1de-20190718
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 884264207; Thu, 18 Jul 2019 11:19:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 11:19:40 +0800
Received: from [10.17.3.153] (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 11:19:39 +0800
Message-ID: <1563419979.20220.12.camel@mhfsdcap03>
Subject: Re: [PATCH 0/5]Add support for mt2701 JPEG ENC support
From:   mtk12025 <xia.jiang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 18 Jul 2019 11:19:39 +0800
In-Reply-To: <79316488-30fd-7ff3-7598-d29f85f663ab@xs4all.nl>
References: <20190709032103.10291-1-xia.jiang@mediatek.com>
         <79316488-30fd-7ff3-7598-d29f85f663ab@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans,
Thank you for your reply.

PATCH v2 has used the latest v4l2-compliance version for test.

PATCH v2 has fixed the compliance test fail, and the driver checked the
buffer size in queue_setup function.

I am sorry for existence of change-id caused by my mistake in the new
patch.

Best Regards,
Xia Jiang


