Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23F0C742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB358217D4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGMAOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:14:10 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:48302 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727118AbfGMAOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:14:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 26E19100E86C6;
        Sat, 13 Jul 2019 00:14:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: step13_7b009126cd010
X-Filterd-Recvd-Size: 1404
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Jul 2019 00:14:05 +0000 (UTC)
Message-ID: <82ccdd83d2a18912bb8cf75585e751c0bd39a215.camel@perches.com>
Subject: Re: [PATCH] [net-next] cxgb4: reduce kernel stack usage in
 cudbg_collect_mem_region()
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, arnd@arndb.de
Cc:     vishal@chelsio.com, rahul.lakkireddy@chelsio.com,
        ganeshgr@chelsio.com, alexios.zavras@intel.com, arjun@chelsio.com,
        surendra@chelsio.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Fri, 12 Jul 2019 17:14:03 -0700
In-Reply-To: <20190712.153632.1007215196498198399.davem@davemloft.net>
References: <20190712090700.317887-1-arnd@arndb.de>
         <20190712.153632.1007215196498198399.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-12 at 15:36 -0700, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 12 Jul 2019 11:06:33 +0200
> 
> > The cudbg_collect_mem_region() and cudbg_read_fw_mem() both use several
> > hundred kilobytes of kernel stack space.

Several hundred 'kilo' bytes?
I hope not.

