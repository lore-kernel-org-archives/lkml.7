Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B3CC742A2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A7821537
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 01:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfGLByL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:54:11 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58997 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729313AbfGLByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:54:10 -0400
X-UUID: 4d6d757b1aab4299bc5ad7308f3dc51c-20190712
X-UUID: 4d6d757b1aab4299bc5ad7308f3dc51c-20190712
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1804235620; Fri, 12 Jul 2019 09:54:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Jul
 2019 09:53:55 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 12 Jul 2019 09:53:54 +0800
Message-ID: <1562896434.32589.26.camel@mhfsdcap03>
Subject: Re: [PATCH 3/5] dt-bindings: usb: mtk-xhci: add an optional xhci_ck
 clock
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Mathias Nyman" <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jumin Li <jumin.li@mediatek.com>
Date:   Fri, 12 Jul 2019 09:53:54 +0800
In-Reply-To: <20190709142235.GA11951@bogus>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
         <9b6ad8dee142d73b56d653ecb7475c4ed28e5eb8.1560246390.git.chunfeng.yun@mediatek.com>
         <20190709142235.GA11951@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: AD446FD5990E933C4FDE78939AF1A0F49FEC44906C060D90748162CC59974F922000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-09 at 08:22 -0600, Rob Herring wrote:
> On Wed, Jun 12, 2019 at 01:55:19PM +0800, Chunfeng Yun wrote:
> > Add a new optional clock xhci_ck
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> > index 266c2d917a28..91c0704b586b 100644
> > --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> > +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
> > @@ -29,6 +29,7 @@ Required properties:
> >  	"sys_ck": controller clock used by normal mode,
> >  	the following ones are optional:
> >  	"ref_ck": reference clock used by low power mode etc,
> > +	"xhci_ck": controller clock,
> >  	"mcu_ck": mcu_bus clock for register access,
> >  	"dma_ck": dma_bus clock for data transfer by DMA
> 
> A new clock should go at the end to stay backwards compatible.
Ok, will fix it, thanks
> 
> >  
> > @@ -100,7 +101,7 @@ Required properties:
> >   - clocks : a list of phandle + clock-specifier pairs, one for each
> >  	entry in clock-names
> >   - clock-names : must contain "sys_ck", and the following ones are optional:
> > -	"ref_ck", "mcu_ck" and "dma_ck"
> > +	"ref_ck", "xhci_ck", "mcu_ck" and "dma_ck"
> >  
> >  Optional properties:
> >   - vbus-supply : reference to the VBUS regulator;
> > -- 
> > 2.21.0
> > 


