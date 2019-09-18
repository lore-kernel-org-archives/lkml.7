Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21032C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C512196E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pyrjSeCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfIRNwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:52:20 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34254 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfIRNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568814738; x=1600350738;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Q4ygvF7O7WhX2bwysg/F08BYHAFbQtKl5wcdvGKLvMM=;
  b=pyrjSeCcYQUhBn0eQVHyNGUzohfuKgfUS13WFXgggY47Jr2S9BVfSGUx
   suSkKS5QaMYLteSR97QVg0rLpvr7Ell9drH9SqFETxdGfqQep7jKoecOM
   PCjBVrfgATC7yHg2jDhEh7Pujbpooe32RBPWe9Yl89oCL/3HLntxuIuGS
   8=;
X-IronPort-AV: E=Sophos;i="5.64,520,1559520000"; 
   d="scan'208";a="833921746"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Sep 2019 13:44:24 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 8F247A213A;
        Wed, 18 Sep 2019 13:44:23 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 18 Sep 2019 13:44:23 +0000
Received: from [10.125.238.52] (10.43.161.217) by EX13D01EUB002.ant.amazon.com
 (10.43.166.113) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 18 Sep
 2019 13:44:16 +0000
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
To:     Rob Herring <robh@kernel.org>
CC:     <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <mchehab+samsung@kernel.org>,
        <shawn.lin@rock-chips.com>, <gregkh@linuxfoundation.org>,
        <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-2-git-send-email-talel@amazon.com>
 <20190918133248.GA16653@bogus>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <6965161b-a51c-9e16-f6b8-6f33b40708ee@amazon.com>
Date:   Wed, 18 Sep 2019 16:44:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190918133248.GA16653@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D02UWC002.ant.amazon.com (10.43.162.6) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tnx Rob for the review.

Shall be part of v3.

Waiting for responses from Arnd and James and will publish v3.

On 9/18/2019 4:35 PM, Rob Herring wrote:
> On Tue, Sep 10, 2019 at 10:05:08PM +0300, Talel Shenhar wrote:
>> Document Amazon's Annapurna Labs POS SoC binding.
>>
>> Signed-off-by: Talel Shenhar <talel@amazon.com>
>> ---
>>   .../devicetree/bindings/soc/amazon/amazon,al-pos.txt   | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
> Please convert to DT schema.
>
>> diff --git a/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
>> new file mode 100644
>> index 00000000..035cc571
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/amazon/amazon,al-pos.txt
>> @@ -0,0 +1,18 @@
>> +Amazon's Annapurna Labs POS
>> +
>> +POS node is defined to describe the Point Of Serialization (POS) logger
>> +unit.
>> +
>> +Required properties:
>> +- compatible:	Shall be "amazon,al-pos".
>> +- reg:		POS logger resources.
>> +- interrupts:	should contain the interrupt for pos error event.
>> +
>> +Example:
>> +
>> +al_pos {
> Needs a unit-address.
>
>> +	compatible = "amazon,al-pos";
>> +	reg = <0x0 0xf0070084 0x0 0x00000008>;
>> +	interrupt-parent = <&amazon_system_fabric>;
>> +	interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
>> +};
>> -- 
>> 2.7.4
>>
