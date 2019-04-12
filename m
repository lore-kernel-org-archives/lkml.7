Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51959C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270F22084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDLO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:28:54 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:8229 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:28:54 -0400
X-IronPort-AV: E=Sophos;i="5.60,341,1549929600"; 
   d="scan'208";a="83442245"
Date:   Fri, 12 Apr 2019 15:28:51 +0100
From:   Wei Liu <wei.liu2@citrix.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
CC:     <xen-devel@lists.xenproject.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wei.liu2@citrix.com>,
        <paul.durrant@citrix.com>, <davem@davemloft.net>,
        <joe.jin@oracle.com>, <junxiao.bi@oracle.com>,
        <jie.l.li@oracle.com>
Subject: Re: [PATCH 1/1] xen-netback: add reference from xenvif to
 backend_info to facilitate coredump analysis
Message-ID: <20190412142851.GK30543@zion.uk.xensource.com>
References: <1555052004-31855-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1555052004-31855-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:53:24PM +0800, Dongli Zhang wrote:
> During coredump analysis, it is not easy to obtain the address of
> backend_info in xen-netback.
> 
> So far there are two ways to obtain backend_info:
> 
> 1. Do what xenbus_device_find() does for vmcore to find the xenbus_device
> and then derive it from dev_get_drvdata().
> 
> 2. Extract backend_info from callstack of xenwatch (e.g., netback_remove()
> or frontend_changed()).
> 
> This patch adds a reference from xenvif to backend_info so that it would be
> much more easier to obtain backend_info during coredump analysis.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Acked-by: Wei Liu <wei.liu2@citrix.com>
