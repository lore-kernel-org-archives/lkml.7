Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C986EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C46120673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 07:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YKJamFAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFFHXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 03:23:42 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22812 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 03:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559805821; x=1591341821;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yjyi2g0jOB4zyn5CSmS3NmsUb+YaZqOiG5ImmDkMQQ8=;
  b=YKJamFAp/sgIQT8ZlJPU+ZsmstJ56Pzw29kec5RJlyjU7PAoy8sujpY2
   twM8oHKLMG6FcrLhWulWd9aOcHzUCWo0jxPmvGgqE+EXfil+SedEJ7AQp
   CVfJdkeuzhPr+xQSv5vI3PldbqxPp7sqGAPW9nVw7abf1+ETh4VPR6Lfg
   I=;
X-IronPort-AV: E=Sophos;i="5.60,558,1549929600"; 
   d="scan'208";a="803908499"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 06 Jun 2019 07:23:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id C4B50A258B;
        Thu,  6 Jun 2019 07:23:38 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 07:23:38 +0000
Received: from [10.125.238.52] (10.43.161.89) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 07:23:28 +0000
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
To:     Eduardo Valentin <eduval@amazon.com>
CC:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-2-git-send-email-talel@amazon.com>
 <20190605154955.GD1534@u40b0340c692b58f6553c.ant.amazon.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <19dbb9a4-2a91-fd6f-f61e-95e1e800e013@amazon.com>
Date:   Thu, 6 Jun 2019 10:23:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605154955.GD1534@u40b0340c692b58f6553c.ant.amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.89]
X-ClientProxiedBy: EX13D17UWC003.ant.amazon.com (10.43.162.206) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/2019 6:49 PM, Eduardo Valentin wrote:
> On Wed, Jun 05, 2019 at 01:52:00PM +0300, Talel Shenhar wrote:
>> +- compatible: should be "amazon,al-fic"
>> +- reg: physical base address and size of the registers
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: must be 2.
> It would be great if you describe what the 2 numbers must represent here..

will be included in v4

Thanks,

Talel.


