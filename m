Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3D4C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41772214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 06:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XK0MJuLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfILGuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 02:50:24 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40857 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 02:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568271023; x=1599807023;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RkCzFDA8G0+ul+VXzUIqi6fz+55WLQ8iBiqeKjnUUqw=;
  b=XK0MJuLwRuACdK673mdd5nTyOb/5nuc7oAdIsMFDWDx9JsjdeqoQXY/5
   QxhSUwjEBd3UPSy9FkTdDComzq2zqEmSe6AFgJD7JB6YE5kvQnlVMeYQY
   rLgAcfYS2PlHIfk8Plte0k9CDSbSLGBtrlZsyKBPN4eXPCjZxgRs0H1/v
   g=;
X-IronPort-AV: E=Sophos;i="5.64,495,1559520000"; 
   d="scan'208";a="830871359"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Sep 2019 06:50:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id BD585A22DC;
        Thu, 12 Sep 2019 06:50:15 +0000 (UTC)
Received: from EX13D01EUB002.ant.amazon.com (10.43.166.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 06:50:14 +0000
Received: from [10.125.238.52] (10.43.161.82) by EX13D01EUB002.ant.amazon.com
 (10.43.166.113) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 12 Sep
 2019 06:50:07 +0000
Subject: Re: [UNVERIFIED SENDER] Re: [PATCH v2 2/3] soc: amazon: al-pos:
 Introduce Amazon's Annapurna Labs POS driver
To:     Marc Zyngier <maz@kernel.org>
CC:     <robh+dt@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <mchehab+samsung@kernel.org>, <shawn.lin@rock-chips.com>,
        <gregkh@linuxfoundation.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, James Morse <james.morse@arm.com>
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-3-git-send-email-talel@amazon.com>
 <86d0g6syva.wl-maz@kernel.org>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <3205f7ae-5568-c064-23ac-ea726246173b@amazon.com>
Date:   Thu, 12 Sep 2019 09:50:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <86d0g6syva.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D11UWB001.ant.amazon.com (10.43.161.53) To
 EX13D01EUB002.ant.amazon.com (10.43.166.113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,


On 9/11/2019 5:15 PM, Marc Zyngier wrote:
> [+James]
>
> Hi Talel,
>
> On Tue, 10 Sep 2019 20:05:09 +0100,
> Talel Shenhar <talel@amazon.com> wrote:
>
>> +	log1 = readl(pos->mmio_base + AL_POS_ERROR_LOG_1);
> Do you actually need the implied barriers? I'd expect that relaxed
> accesses should be enough.

You are correct. Barriers are not needed, In v1 this driver indeed used 
_relaxed versions.

Due to request coming from Arnd in v1 patch series I removed it. As this 
is not data path I had no strong objection for removing it.

>
>> +	if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
>> +		return IRQ_NONE;
>> +
>> +	log0 = readl(pos->mmio_base + AL_POS_ERROR_LOG_0);
>> +	writel(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
>> +
>> +	addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
>> +	addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
>> +	request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
>> +	bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
>> +
>> +	dev_err(&pdev->dev, "addr=0x%llx request_id=0x%x bresp=0x%x\n",
>> +		addr, request_id, bresp);
> What is this information? How do we make use of it? Given that this is
> asynchronous, how do we correlate it to the offending software?

Indeed this information arriving from the HW is asynchronous.

There is no direct method to get the offending software.

There are all kinds of hacks we do to find the offending software once 
we find this error. most of the time its a new patch introduced but some 
of the time is just digging.

> The whole think looks to me like a poor man's EDAC handling, and I'd
> expect to be plugged in that subsystem instead. Any reason why this
> isn't the case? It would certainly make the handling uniform for the
> user.

This logic was not plugged into EDAC as there is no "Correctable" error 
here. its just error event. Not all errors are EDAC in the sense of 
Error Detection And *Correction*. There are no correctable errors for 
this driver.

So plugging it  under EDAC seems like abusing the EDAC system.

Now that I've emphasize the reason for not putting this under EDAC, what 
do you think? should this "only uncorrectable event" driver should be 
part of EDAC?


Thanks,

Talel

