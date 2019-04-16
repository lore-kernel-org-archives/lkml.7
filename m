Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD52C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B9F20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfDPJ11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:27:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44177 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726905AbfDPJ11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:27:27 -0400
X-UUID: 4599a2f3db24431aa277b06be6d70067-20190416
X-UUID: 4599a2f3db24431aa277b06be6d70067-20190416
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2134039423; Tue, 16 Apr 2019 17:27:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 17:27:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 17:27:16 +0800
Message-ID: <1555406836.27018.10.camel@mtksdaap41>
Subject: Re: [PATCH v9] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <mars.cheng@mediatek.com>,
        <eddie.huang@mediatek.com>, Ben Ho <Ben.Ho@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Date:   Tue, 16 Apr 2019 17:27:16 +0800
In-Reply-To: <135d7e3a-d5a3-0f13-05c9-4a8ec0524256@gmail.com>
References: <1552898552-13045-2-git-send-email-erin.lo@mediatek.com>
         <201903190247.QZDwfpLQ%lkp@intel.com>
         <135d7e3a-d5a3-0f13-05c9-4a8ec0524256@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-04-16 at 10:29 +0200, Matthias Brugger wrote:
> 
> On 18/03/2019 19:42, kbuild test robot wrote:
> > Hi Erin,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on robh/for-next]
> > [also build test ERROR on v5.1-rc1 next-20190318]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Erin-Lo/arm64-dts-Add-Mediatek-SoC-MT8183-and-evaluation-board-dts-and-Makefile/20190318-170422
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > config: arm64-allyesconfig (attached as .config)
> > compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=arm64 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from arch/arm64/boot/dts/mediatek/mt8183-evb.dts:9:0:
> >>> arch/arm64/boot/dts/mediatek/mt8183.dtsi:8:10: fatal error: dt-bindings/clock/mt8183-clk.h: No such file or directory
> >     #include <dt-bindings/clock/mt8183-clk.h>
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    compilation terminated.
> > 
> > vim +8 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> >    > 8	#include <dt-bindings/clock/mt8183-clk.h>
> >      9	#include <dt-bindings/interrupt-controller/arm-gic.h>
> >     10	#include <dt-bindings/interrupt-controller/irq.h>
> >     11	
> > 
> 
> Stephen queued the corresponding patch for v5.2.
> I propose we wait for v5.2-rc1 and then apply the basic support and the others
> based on this one.
> 
> Erin: There are may mt8183 dts patches floating around that depend on this or
> more patches. Can you coordinate with your colleagues to resend them as a
> series? Then it will be easier for me to take them for v5.3, as some have
> dependencies on other series etc.
> 
> Thanks a lot.
> Matthias

OK, I will coordinate with my colleagues to resend mt8183 dts patches as
a series base on v5.2-rc1 when v5.2-rc1 release.
Since we want to send this series more confident so they still send
separate patch in v5.1 just for review in advance. Is that ok for you?

