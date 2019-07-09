Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF78C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139C2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gpIv8D6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGIGAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:00:02 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:5647 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfGIGAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562652000; x=1594188000;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UtkGVRmMvu6UY0P2XrYTov5ny6K/ib2hxgjTX5ntpb0=;
  b=gpIv8D6y0fXDBSTtpV4Ys8ITjD2EuGxAbJSi8DD14jjBkoz5hAyewge9
   OLGKVXKBYfEPJEL4C0MiYNBXcrH/6SPwQVi2EHtr3g+GHrLTlcTAOw/4v
   ChfJkFWUFFVL5Aj3U5mCWnwW5Sc6nV8sewXB/pDHzlK38TdSr+IT4qhUH
   I=;
X-IronPort-AV: E=Sophos;i="5.62,469,1554768000"; 
   d="scan'208";a="684424846"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 09 Jul 2019 05:59:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 787FAA248F;
        Tue,  9 Jul 2019 05:59:54 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 9 Jul 2019 05:59:53 +0000
Received: from [10.85.103.206] (10.43.161.115) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 9 Jul
 2019 05:59:44 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
To:     Rob Herring <robh@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <shawn.lin@rock-chips.com>, <tglx@linutronix.de>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <jonnyc@amazon.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>
References: <1560155683-29584-1-git-send-email-talel@amazon.com>
 <1560155683-29584-2-git-send-email-talel@amazon.com>
 <20190709022301.GA8734@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <f1fd393d-0b8c-16f1-9ac2-0589e9cb9ea7@amazon.com>
Date:   Tue, 9 Jul 2019 08:59:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709022301.GA8734@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.115]
X-ClientProxiedBy: EX13D05UWC002.ant.amazon.com (10.43.162.92) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc, should I publish those fixes as new patch that updates the 
dt-bindings or new patchset to this list?

On 7/9/2019 5:23 AM, Rob Herring wrote:
> On Mon, Jun 10, 2019 at 11:34:42AM +0300, Talel Shenhar wrote:
>> +- #interrupt-cells: must be 2.
>> +  First cell defines the index of the interrupt within the controller.
>> +  Second cell is used to specify the trigger type and must be one of the
>> +  following:
>> +    - bits[3:0] trigger type and level flags
>> +	1 = low-to-high edge triggered
>> +	4 = active high level-sensitive
> No need to define this here. Reference the standard definition.

This device only support those two modes.

This definition tries to capture the supported modes.

Should I just state that those two modes are supported and then avoid 
the actual bits and values?

>
>> +- interrupt-parent: specifies the parent interrupt controller.
> Drop this. It is implied and could be in the parent.
ack
>
>> +- interrupts: describes which input line in the interrupt parent, this
>> +  fic's output is connected to. This field property depends on the parent's
>> +  binding
>> +
>> +Example:
>> +
>> +amazon_fic: interrupt-controller@0xfd8a8500 {
> Drop the '0x'
ack
