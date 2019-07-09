Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFCCC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9AB216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XCSM7hgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGIIRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:17:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:44757 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIIRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562660251; x=1594196251;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=G+5thZQW+z+i9GKZkumZ9p7t1EroWVUVq0owQCtkCPI=;
  b=XCSM7hgfEDJ1cuX97mh5zB7PuqUlCnme9tYvGdOi/qgHyxhG7ucqxbmI
   tLPqsqhFs09zJzR17KjFA1IXgwwwtPZDkWsmELlVBo8a35Xld1rH5Z0BX
   7/YBhChjvgZPg+1ONQ7f98cHsvjFpYV0zifRGRLdBhcGs4qkr4hk0DQnA
   E=;
X-IronPort-AV: E=Sophos;i="5.62,469,1554768000"; 
   d="scan'208";a="404138398"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 09 Jul 2019 08:17:28 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id D9579A2309;
        Tue,  9 Jul 2019 08:17:27 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 9 Jul 2019 08:17:27 +0000
Received: from [10.85.103.206] (10.43.160.65) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 9 Jul
 2019 08:17:18 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
To:     Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <mark.rutland@arm.com>, <mchehab+samsung@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
 <1560155683-29584-2-git-send-email-talel@amazon.com>
 <20190709022301.GA8734@bogus>
 <f1fd393d-0b8c-16f1-9ac2-0589e9cb9ea7@amazon.com>
 <ff3794af-cd5a-5331-fca0-30280530670e@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <d9dbe06b-534a-4610-397b-4b241329dde9@amazon.com>
Date:   Tue, 9 Jul 2019 11:17:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ff3794af-cd5a-5331-fca0-30280530670e@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will do.

On 7/9/2019 11:15 AM, Marc Zyngier wrote:
> On 09/07/2019 06:59, Shenhar, Talel wrote:
>> Marc, should I publish those fixes as new patch that updates the
>> dt-bindings or new patchset to this list?
>
> If you are going to update the binding, please submit a patch on top of
> mainline, as it's been merged already.
>
> Thanks,
>
> 	M.
