Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B1CC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287E221850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCTHuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:50:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34568 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726802AbfCTHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:50:02 -0400
X-UUID: 2e6fc7c51e58446989dccb26774ac9f5-20190320
X-UUID: 2e6fc7c51e58446989dccb26774ac9f5-20190320
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 29587343; Wed, 20 Mar 2019 15:49:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Mar
 2019 15:49:43 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Mar 2019 15:49:42 +0800
Message-ID: <1553068182.10179.166.camel@mhfsdcap03>
Subject: Re: [PATCH v2] usb: introduce usb_ep_type_string() function
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@ti.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Dmitry Torokhov" <dtor@chromium.org>,
        Johan Hovold <johan@kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Colin Ian King <colin.king@canonical.com>,
        Matteo Croce <mcroce@redhat.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 20 Mar 2019 15:49:42 +0800
In-Reply-To: <87r2b2ujao.fsf@linux.intel.com>
References: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com>
         <1552982059.10179.143.camel@mhfsdcap03> <20190319092331.GA21652@kroah.com>
         <1553044567.10179.148.camel@mhfsdcap03> <87r2b2ujao.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

On Wed, 2019-03-20 at 08:55 +0200, Felipe Balbi wrote:
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> 
> > Hi Greg,
> >
> > On Tue, 2019-03-19 at 10:23 +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Mar 19, 2019 at 03:54:19PM +0800, Chunfeng Yun wrote:
> >> > 
> >> > Hi Felipe & Mathias,
> >> > 
> >> > Could you please comment this patch, if there is some-effect on dwc3 and
> >> > xhci, I'll remove its change.
> > typo: some-effect/side-effect
> 
> well, we don't really know if there are tools parsing the output. The
> side-effect _does_ exist (i.e. you change the string :-), what we don't
> know is if this will cause problems to possibly existing tools.
> 
> Personally, I don't mind the patch, but if it breaks existing parsers,
> that would be a little annoying.
Thank you for the feedback.

I'll abandon the changes about dwc3 & xhci
> 


