Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83468C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4FD2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE1JX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:23:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48790 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726279AbfE1JX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:23:59 -0400
X-UUID: dca10c745676424ba6419324265dc3a6-20190528
X-UUID: dca10c745676424ba6419324265dc3a6-20190528
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 762711357; Tue, 28 May 2019 17:23:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 28 May
 2019 17:23:51 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 28 May 2019 17:23:50 +0800
Message-ID: <1559035430.8487.11.camel@mhfsdcap03>
Subject: RE: [PATCH v5 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Biju Das <biju.das@bp.renesas.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Chen Yu <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 May 2019 17:23:50 +0800
In-Reply-To: <OSBPR01MB2103B7E9BB12FDCEB4105BAFB81E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <20190520080359.GC1887@kuha.fi.intel.com>
         <OSBPR01MB2103385D996762FA54F8E437B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190520083601.GE1887@kuha.fi.intel.com>
         <OSBPR01MB2103C4C8920C40E42BC1B2A9B8060@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190521095839.GI1887@kuha.fi.intel.com>
         <OSBPR01MB21032206146152983C8F4E8EB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <1558517436.10179.388.camel@mhfsdcap03>
         <OSBPR01MB21038F2B99EF74831A22727BB8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190522142640.GN1887@kuha.fi.intel.com>
         <OSBPR01MB2103B669C24E9E261B4AFA73B8000@OSBPR01MB2103.jpnprd01.prod.outlook.com>
         <20190524124445.GP1887@kuha.fi.intel.com>
         <1558926515.10179.439.camel@mhfsdcap03>
         <OSBPR01MB2103B7E9BB12FDCEB4105BAFB81E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju & Yu,

On Tue, 2019-05-28 at 06:52 +0000, Biju Das wrote:
> Hi Chunfeng Yun,
> 
> + Chen Yu
> 
> Thanks for the feedback.
[...]
> 
> Just a suggestion, Do you think, is it worth to add the below  patch[1] also part of this series? So that we have all common patches in this series.
> 
Or resend it as a single patch?

> "usb: roles: Introduce stubs for the exiting functions in role.h."
> [1] https://patchwork.kernel.org/patch/10909971/
> 
 
> Regards,
> Biju


