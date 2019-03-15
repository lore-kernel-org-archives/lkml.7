Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D162184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfCOJOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:14:19 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21571 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727282AbfCOJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:14:19 -0400
X-UUID: dad85c0880044b85b0c26a529b841199-20190315
X-UUID: dad85c0880044b85b0c26a529b841199-20190315
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 823694479; Fri, 15 Mar 2019 17:14:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 17:14:09 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 17:14:08 +0800
Message-ID: <1552641248.10179.134.camel@mhfsdcap03>
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by
 node
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 15 Mar 2019 17:14:08 +0800
In-Reply-To: <20190315091127.GF7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
         <20190315081835.GD7752@kuha.fi.intel.com>
         <20190315091127.GF7752@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, 2019-03-15 at 11:11 +0200, Heikki Krogerus wrote:
> On Fri, Mar 15, 2019 at 10:18:35AM +0200, Heikki Krogerus wrote:
> > Andy already pointed out that you need to use fwnodes.
> > 
> > Rule of thumb: You always use fwnodes. Only if there is something that
> > can't be done with fwnodes you use DT or ACPI nodes directly.
> > 
> > In this case there is absolutely nothing that would prevent you from
> > using fwnodes.
> 
> ...
> 
> > +/**
> > + * usb_role_switch_get_by_node - Find USB role switch by it's parent node
> > + * @node: The node that register USB role switch
> > + *
> > + * Finds and returns role switch registered by @node. The reference count
> > + * for the found switch is incremented.
> > + */
> > +struct usb_role_switch *usb_role_switch_get_by_node(struct device_node *node)
> 
> This is my proposal for function prototype:
> 
> struct usb_role_switch *
> fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);
Ok, thanks again
> 
> 
> thanks,
> 


