Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B633F20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 05:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfHSFrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 01:47:22 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:58588 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbfHSFrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 01:47:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 94ED253B3;
        Mon, 19 Aug 2019 05:47:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: salt01_5cf136d77bd2a
X-Filterd-Recvd-Size: 2569
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 05:47:18 +0000 (UTC)
Message-ID: <31cb3e54fe532630b45bb74ba4fc688eb86eab1f.camel@perches.com>
Subject: Re: [PATCH] erofs: Use common kernel logging style
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Gao Xiang <hsiangkao@aol.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel <devel@driverdev.osuosl.org>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Date:   Sun, 18 Aug 2019 22:47:17 -0700
In-Reply-To: <20190819055243.GB30459@138>
References: <20190817082313.21040-1-hsiangkao@aol.com>
         <1746679415.68815.1566076790942.JavaMail.zimbra@nod.at>
         <20190817220706.GA11443@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1163995781.68824.1566084358245.JavaMail.zimbra@nod.at>
         <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
         <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
         <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
         <20190818092839.GA18975@hsiangkao-HP-ZHAN-66-Pro-G1>
         <52e4e3a7f160f5d2825bec04a3bc4eb4b0d1165a.camel@perches.com>
         <20190819055243.GB30459@138>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 13:52 +0800, Gao Xiang wrote:
> Hi Joe,

Hello.

> On Sun, Aug 18, 2019 at 10:28:41PM -0700, Joe Perches wrote:
> > Rename errln, infoln, and debugln to the typical pr_<level> uses
> > to the typical kernel styles of pr_<level>
> 
> How about using erofs_err / ... to instead that?

<shrug>  I've no opinion.
It seems most fs/*/* filesystems actually do use pr_<level>
sed works well if you want that.

>  - I can hardly see directly use pr_<level> for those filesystems in fs/...

just fyi:

There was this one existing pr_<level> use in erofs

drivers/staging/erofs/data.c:366:                               pr_err("%s, readahead error at page %lu of nid %llu\n",
drivers/staging/erofs/data.c-367-                                      __func__, page->index,
drivers/staging/erofs/data.c-368-                                      EROFS_V(mapping->host)->nid);



