Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C8C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC1C2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfHNEdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:33:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18920 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbfHNEdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:33:47 -0400
X-UUID: 42e09e84ee194658924509e3bbc81dc4-20190814
X-UUID: 42e09e84ee194658924509e3bbc81dc4-20190814
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1746995198; Wed, 14 Aug 2019 12:33:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 14 Aug
 2019 12:33:36 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 14 Aug 2019 12:33:36 +0800
Message-ID: <1565757215.7317.15.camel@mhfsdcap03>
Subject: Re: [PATCH next v9 07/11] usb: roles: Add
 fwnode_usb_role_switch_get() function
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Date:   Wed, 14 Aug 2019 12:33:35 +0800
In-Reply-To: <20190813130110.GE4691@kuha.fi.intel.com>
References: <1565695634-9711-1-git-send-email-chunfeng.yun@mediatek.com>
         <1565695634-9711-8-git-send-email-chunfeng.yun@mediatek.com>
         <20190813130110.GE4691@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 4CA480A775488A034C17FADD4441FFF8772F99EADAA5F19D81249A977504955E2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 16:01 +0300, Heikki Krogerus wrote:
> On Tue, Aug 13, 2019 at 07:27:10PM +0800, Chunfeng Yun wrote:
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The fwnode_usb_role_switch_get() function is exactly the
> > same as usb_role_switch_get(), except that it takes struct
> > fwnode_handle as parameter instead of struct device.
> > 
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Why is my SoB replaced with Suggested-by tag in this patch?
Sorry, my mistake, I misunderstand what you mean, you suggest use
Suggested-by in [v8 08/11], but I replaced it all for [06, 07, 08], 
will abandon the changes of [06,07] in next version.

> 
> thanks,
> 


