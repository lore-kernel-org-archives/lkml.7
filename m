Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76CFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6D20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="itZ5OnD9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfHFKCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:02:18 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54740 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbfHFKCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565085737; x=1596621737;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yxWzBfGsv2Z1rg7L0Jjnkc+Uvq7aPmSydjrmlj8tZSI=;
  b=itZ5OnD9HpfcvhQXJzOeTqAJC5akptpmKNhARADGckdIpUqgMoR1kLKf
   CpEn1V/hC/oxxXIYOMIRfeNNIYDXQHqHsyqNESOq11sKs6IMTU0c3c6/2
   0EalxVfQXfPv6+OWY+jum2mzyJsF3ui74zgPcTdVF4CeM9YtYTJLurKu4
   o=;
X-IronPort-AV: E=Sophos;i="5.64,353,1559520000"; 
   d="scan'208";a="691271420"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Aug 2019 10:02:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 9670AA2BA4;
        Tue,  6 Aug 2019 10:02:14 +0000 (UTC)
Received: from EX13D05EUC002.ant.amazon.com (10.43.164.231) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 6 Aug 2019 10:02:13 +0000
Received: from [10.125.238.43] (10.43.160.20) by EX13D05EUC002.ant.amazon.com
 (10.43.164.231) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 6 Aug
 2019 10:02:08 +0000
Subject: Re: [PATCH 2/2] arm64: dts: amazon: add Amazon Annapurna Labs Alpine
 v3 support
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <barakw@amazon.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <jonnyc@amazon.com>, <talel@amazon.com>, <hhhawa@amazon.com>,
        <hanochu@amazon.com>
References: <20190728195135.12661-1-ronenk@amazon.com>
 <20190728195135.12661-3-ronenk@amazon.com> <20190729101250.GA831@e107155-lin>
From:   Krupnik <ronenk@amazon.com>
Message-ID: <b1a4611f-2169-7657-bdc8-82f9525492ce@amazon.com>
Date:   Tue, 6 Aug 2019 13:02:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729101250.GA831@e107155-lin>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.20]
X-ClientProxiedBy: EX13D03UWC004.ant.amazon.com (10.43.162.49) To
 EX13D05EUC002.ant.amazon.com (10.43.164.231)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/19 13:12, Sudeep Holla wrote:
> On Sun, Jul 28, 2019 at 10:51:35PM +0300, Ronen Krupnik wrote:
>> This patch adds the initial support for the Amazon Annapurna Labs Alpine v3
>> Soc and Evaluation Platform (EVP).
> [...]
>
>> +
>> +		pmu {
>> +			compatible = "arm,armv8-pmuv3";
> Please use "arm,cortex-a72-pmu" as we know it's Cortex-A72 cores
ack. will be part of v2
>
> --
> Regards,
> Sudeep
