Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A16C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0422083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfB1Mh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:37:57 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:25002 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbfB1Mh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:37:57 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="79318758"
Date:   Thu, 28 Feb 2019 12:37:48 +0000
From:   Wei Liu <wei.liu2@citrix.com>
To:     Paul Durrant <Paul.Durrant@citrix.com>
CC:     Wei Liu <wei.liu2@citrix.com>,
        Igor Druzhinin <igor.druzhinin@citrix.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
Message-ID: <20190228123748.5nabuvg44sjiecdz@zion.uk.xensource.com>
References: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
 <8424fba34a1f43908a6dae3a9308863b@AMSPEX02CL02.citrite.net>
 <20190228110136.somjads2f5ivqhju@zion.uk.xensource.com>
 <e5ef3c0291854b67841b6c532f7651b9@AMSPEX02CL02.citrite.net>
 <0aa1850892c94d6ba7543bf322734614@AMSPEX02CL02.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0aa1850892c94d6ba7543bf322734614@AMSPEX02CL02.citrite.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:07:07PM +0000, Paul Durrant wrote:
> Yes, I meant kfree_skb(nskb).
> 

In that case I think your patch looks fine.

Wei.
