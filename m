Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB301C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A72D24BA4
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfFDGm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:42:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:32490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726410AbfFDGm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:42:56 -0400
X-UUID: b1e17f24206b40989f4201573ba7bd9c-20190604
X-UUID: b1e17f24206b40989f4201573ba7bd9c-20190604
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 333179411; Tue, 04 Jun 2019 14:42:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Jun
 2019 14:42:38 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 4 Jun 2019 14:42:37 +0800
Message-ID: <1559630557.8487.59.camel@mhfsdcap03>
Subject: Re: [PATCH v6 07/10] usb: roles: Add fwnode_usb_role_switch_get()
 function
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Date:   Tue, 4 Jun 2019 14:42:37 +0800
In-Reply-To: <20190603131901.GB10397@kroah.com>
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com>
         <1559115828-19146-8-git-send-email-chunfeng.yun@mediatek.com>
         <20190603131901.GB10397@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 15:19 +0200, Greg Kroah-Hartman wrote:
> On Wed, May 29, 2019 at 03:43:45PM +0800, Chunfeng Yun wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The fwnode_usb_role_switch_get() function is exactly the
> > same as usb_role_switch_get(), except that it takes struct
> > fwnode_handle as parameter instead of struct device.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> > v6:
> >   new patch
> 
> If you are forwarding on a patch from someone else, like this, you need
> to put your signed-off-by line on it as well.
> 
> Please fix that up, and add the tested-by one, when you resend this
> series.
Got it, thanks

> 
> thanks,
> 
> greg k-h


