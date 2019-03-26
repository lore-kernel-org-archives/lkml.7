Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03497C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA5320848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfCZCyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:54:43 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34606 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727157AbfCZCyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:54:43 -0400
X-UUID: b9c9f0e3a10346899ef0cce6bdba3683-20190326
X-UUID: b9c9f0e3a10346899ef0cce6bdba3683-20190326
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 843191351; Tue, 26 Mar 2019 10:54:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 26 Mar
 2019 10:54:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Mar 2019 10:54:35 +0800
Message-ID: <1553568875.21970.5.camel@mhfsdcap03>
Subject: Re: [PATCH 2/4] arm64: dts: mt8183: add pintcrl file
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linus.walleij@linaro.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <sean.wang@kernel.org>,
        <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <eddie.huang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <biao.huang@mediatek.com>, <hongzhou.yang@mediatek.com>,
        <erin.lo@mediatek.com>, <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>
Date:   Tue, 26 Mar 2019 10:54:35 +0800
In-Reply-To: <20190325193005.GA18114@bogus>
References: <20190325122302.5483-1-zhiyong.tao@mediatek.com>
         <20190325122302.5483-3-zhiyong.tao@mediatek.com>
         <20190325193005.GA18114@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 14:30 -0500, Rob Herring wrote:
> On Mon, Mar 25, 2019 at 08:23:00PM +0800, Zhiyong Tao wrote:
> > This patch adds pinctrl file for mt8183.
> 
> Still has a typo in the subject.

==>we will change it in next version
> 
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
> >  1 file changed, 1120 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> 
> Add acks/reviewed-bys when posting new versions. This should also be 
> called v8 even though a different person sent it.

==>we will add acks/reviewed-bys when posting new versions in nxet
version.
This patch is based on "https://patchwork.kernel.org/patch/10814251/".
If it is based on the patch
"https://patchwork.kernel.org/patch/10814251/", it should called v8.
But I send this patch, we call it v3. Because it it is based on the
patch "https://patchwork.kernel.org/patch/10836969/".

In these v3 patches, we send 4 patches. So we should call 1/4,2/4,3/4 as
v9 in next patch, and call 4/4 patch as v5. is it right?

Thanks.
> 
> Rob
> 


